document.addEventListener('DOMContentLoaded', ready);

function ready() {
  // Attach event listener for each "Add to Cart" button
  const addToCartButtons = document.querySelectorAll('.shop-item-button');
  addToCartButtons.forEach(button => {
    button.addEventListener('click', addToCartClicked);
  });
  // Attach event listener for the purchase button
  document.querySelector('.btn-purchase').addEventListener('click', purchaseClicked);
}

function addToCartClicked(event) {
  // Use closest() to get the shop-item container
  const shopItem = event.target.closest('.shop-item');
  if (!shopItem) return;
  
  const titleElem = shopItem.querySelector('.shop-item-title');
  const priceElem = shopItem.querySelector('.shop-item-price');
  const imageElem = shopItem.querySelector('.shop-item-image');
  
  if (!titleElem || !priceElem || !imageElem) {
    console.error("Error: Missing required product details.");
    return;
  }
  
  const title = titleElem.innerText.trim();
  const priceText = priceElem.innerText.trim();
  const imageSrc = imageElem.src;
  
  // Log for debugging purposes
  console.log("Title:", title);
  console.log("Price Text:", priceText);
  console.log("This is image src  "+imageSrc)
  
  // Remove non-numeric characters and parse the price
  const price = parseFloat(priceText.replace(/[^0-9.]/g, ''));
  if (isNaN(price)) {
    alert("Error: Price is not a valid number.");
    return;
  }
  console.log("Parsed Price:", price);

  console.log("Hello calling ", addItemToCart(title, price, imageSrc))
  
  addItemToCart(title, price, imageSrc);
  updateCartTotal();
}

function addItemToCart(title, price, imageSrc) {
  const cartItems = document.querySelector('.cart-items');
  const existingItems = cartItems.querySelectorAll('.cart-item-title');
  console.log("Cart item ---",cartItems)
  console.log("Exiting Cart item ---",existingItems)
  
  // Prevent duplicate entries
  for (let item of existingItems) {
    if (item.innerText === title) {
      alert('This item is already in the cart');
      return;
    }
  }
  
  // Create a new table row for the cart item
  const cartRow = document.createElement('tr');
  console.log("cart row-- ",cartItems)
  cartRow.classList.add('cart-row');
  cartRow.innerHTML = `
    <td class="cart-item cart-column">
      <img class="cart-item-image" src="${imageSrc}" width="50" height="50">
      <span class="cart-item-title">${title}</span>
    </td>
    <td class="cart-item cart-column">
      <span class="cart-price">Rs ${price.toFixed(2)}</span>
    </td>
    <td class="cart-item cart-column">
      <input class="cart-quantity-input" type="number" value="1" min="1" style="width: 50px">
      <button class="btn btn-danger" type="button">Remove</button>
    </td>
  `;
  
  cartItems.appendChild(cartRow);
  
  // Attach event listeners for removal and quantity changes
  cartRow.querySelector('.btn-danger').addEventListener('click', removeCartItem);
  cartRow.querySelector('.cart-quantity-input').addEventListener('change', quantityChanged);
}

function removeCartItem(event) {
  event.target.closest('.cart-row').remove();
  updateCartTotal();
}

function quantityChanged(event) {
  const input = event.target;
  if (isNaN(input.value) || input.value <= 0) {
    input.value = 1;
  }
  updateCartTotal();
}

function updateCartTotal() {
  const cartRows = document.querySelectorAll('.cart-row');
  let total = 0;
  cartRows.forEach(row => {
    const priceElem = row.querySelector('.cart-price');
    const quantityElem = row.querySelector('.cart-quantity-input');
    const price = parseFloat(priceElem.innerText.replace(/[^0-9.]/g, ''));
    const quantity = parseInt(quantityElem.value);
    total += price * quantity;
  });
  total = Math.round(total * 100) / 100;
  document.querySelector('.cart-total-price').innerText = 'Rs ' + total.toFixed(2);
}

function purchaseClicked() {
  alert('Thank you for your purchase!');
  const cartItems = document.querySelector('.cart-items');
  while (cartItems.firstChild) {
    cartItems.removeChild(cartItems.firstChild);
  }
  updateCartTotal();
}
