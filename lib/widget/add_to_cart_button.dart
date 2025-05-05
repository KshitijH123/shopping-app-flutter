import 'package:flutter/material.dart';
import 'package:interview_practice/model/product.dart';

class AddToCartButton extends StatefulWidget {
  final Product product;
  final MainAxisSize mainAxisSize;
  final VoidCallback? onQuantityChange;

  const AddToCartButton({
    super.key,
    required this.product,
    this.onQuantityChange,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.product.quantity == 0) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            widget.product.quantity = 1;
            widget.onQuantityChange?.call();
            setState(() {});
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent[100],
          ),
          child: Text('Add to Cart'),
        ),
      );
    } else {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisSize: widget.mainAxisSize,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                widget.product.quantity--;
                widget.onQuantityChange?.call();
                setState(() {});
              },
              child: Text('-', style: TextStyle(fontSize: 20)),
            ),
            Text(
              widget.product.quantity.toString(),
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                widget.product.quantity++;
                widget.onQuantityChange?.call();
                setState(() {});
              },
              child: Text('+', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      );
    }
  }
}
