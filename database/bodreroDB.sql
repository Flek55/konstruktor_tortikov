USE boderero;

CREATE TABLE user_info(
  user_id INT NOT NULL,
  user_login VARCHAR(50),
  user_password VARCHAR(50),
  user_email VARCHAR(50),
  user_phone VARCHAR(15),
  PRIMARY KEY(user_id)
) COMMENT 'Contains description of user information.';

CREATE TABLE products(
  product_id INT NOT NULL,
  product_name VARCHAR(50),
  product_price DECIMAL,
  PRIMARY KEY(product_id)
) COMMENT 'Information about the products.';

CREATE TABLE `order`(
  user_id INT NOT NULL,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY(user_id, order_id, product_id)
) COMMENT 'Gets order id and connects it to a user.';

CREATE TABLE form_order(
order_id INT NOT NULL, product_id INT NOT NULL,
  PRIMARY KEY(order_id, product_id)
) COMMENT 'Collects products in one order.';

ALTER TABLE `order`
  ADD CONSTRAINT user_info_order
    FOREIGN KEY (user_id) REFERENCES user_info (user_id);

ALTER TABLE form_order
  ADD CONSTRAINT products_order
    FOREIGN KEY (product_id) REFERENCES products (product_id);

ALTER TABLE `order`
  ADD CONSTRAINT form_order_order
    FOREIGN KEY (order_id, product_id) REFERENCES form_order (order_id, product_id)
  ;
