<?php
session_start();
include '../includes/header.php';

// Giỏ hàng sẽ được lưu trong $_SESSION['cart'] dạng: [product_id => quantity]
$cart = isset($_SESSION['cart']) ? $_SESSION['cart'] : [];

// Kết nối DB
include '../includes/db.php';

// Nếu giỏ rỗng
if (empty($cart)) {
    echo "<h2>Your cart is empty 🛒</h2>";
} else {
    echo "<h2>Your Cart</h2>";
    echo "<table border='1' cellpadding='8'>";
    echo "<tr><th>Product</th><th>Price</th><th>Quantity</th><th>Total</th></tr>";

    $grand_total = 0;

    foreach ($cart as $product_id => $quantity) {
        $stmt = $pdo->prepare("SELECT name, price FROM products WHERE id = ?");
        $stmt->execute([$product_id]);
        $product = $stmt->fetch();

        if ($product) {
            $total = $product['price'] * $quantity;
            $grand_total += $total;

            echo "<tr>";
            echo "<td>" . htmlspecialchars($product['name']) . "</td>";
            echo "<td>$" . number_format($product['price'], 2) . "</td>";
            echo "<td>$quantity</td>";
            echo "<td>$" . number_format($total, 2) . "</td>";
            echo "</tr>";
        }
    }

    echo "<tr><td colspan='3'><strong>Total</strong></td><td><strong>$" . number_format($grand_total, 2) . "</strong></td></tr>";
    echo "</table>";
    echo "<br><a href='checkout.php'>Proceed to Checkout</a>";
}

include '../includes/footer.php';
?>
