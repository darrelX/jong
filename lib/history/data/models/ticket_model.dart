class TicketModel {
  final String? id;
  final String? userId;
  final int? totalAmount;
  final bool? status;
  final DateTime? createdAt; // New property
  final DateTime? updatedAt;
  final List<Map<String, dynamic>>? products;

  TicketModel(
      {required this.id,
      required this.totalAmount,
      required this.userId,
      this.status = false,
      required this.createdAt,
      this.updatedAt,
      required this.products});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: (json['id'] as int).toString() as String?,
        totalAmount: json['total_amount'] as int?,
        userId: (json['user_id'] as int).toString() as String?,
        status: json['status'] as bool?,
        createdAt: (json['created_at'] as String) as DateTime?,
        updatedAt: (json['updated_at'] as String) as DateTime?,
        products: json['products'] as List<Map<String, dynamic>>?);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'user_id': userId,
        'quantity': totalAmount,
        'status': status,
        'created_At': createdAt,
        'products': products
      };

  static final Map<String, dynamic> ticket = {
    "current_page": 1,
    "data": [
      {
        "id": 1,
        "uuid": "MATYCARFEFVG",
        "user_id": 22,
        "status": true,
        "barman_id": 24,
        "created_at": "2024-07-09T03:35:22.000000Z",
        "updated_at": "2024-07-09T03:35:22.000000Z",
        "total_amount": 12642.400000000001,
        "products": [
          {
            "id": 3,
            "product_category_id": 1,
            "name": "Beer of 146XAF",
            "price": "644.74",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 4,
            "pivot": {"ticket_id": 1, "product_id": 3}
          },
          {
            "id": 5,
            "product_category_id": 1,
            "name": "Beer of 861XAF",
            "price": "412.39",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 4,
            "pivot": {"ticket_id": 1, "product_id": 5}
          },
          {
            "id": 6,
            "product_category_id": 1,
            "name": "Beer of 427XAF",
            "price": "149.69",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 4,
            "pivot": {"ticket_id": 1, "product_id": 6}
          },
          {
            "id": 8,
            "product_category_id": 1,
            "name": "Beer of 889XAF",
            "price": "976.89",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 8,
            "pivot": {"ticket_id": 1, "product_id": 8}
          }
        ],
        "company": null,
        "user": {
          "id": 22,
          "phone_number": "269.890.9920",
          "name": "Jeanie Cassin"
        },
      },
      {
        "id": 2,
        "uuid": "SLJOKJFWXGNK",
        "user_id": 30,
        "status": true,
        "barman_id": 45,
        "created_at": "2024-07-09T03:35:22.000000Z",
        "updated_at": "2024-07-09T03:35:22.000000Z",
        "total_amount": 8792.01,
        "products": [
          {
            "id": 8,
            "product_category_id": 1,
            "name": "Beer of 889XAF",
            "price": "976.89",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 9,
            "pivot": {"ticket_id": 2, "product_id": 8}
          }
        ],
        "company": null,
        "user": {
          "id": 30,
          "phone_number": "+1-304-718-3769",
          "name": "Prof. Walter Dickens"
        },
        "ticket_products": [
          {
            "id": 5,
            "ticket_id": 2,
            "product_id": 8,
            "quantity": 9,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 8,
              "product_category_id": 1,
              "name": "Beer of 889XAF",
              "price": "976.89",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          }
        ]
      },
      {
        "id": 3,
        "uuid": "QRQVIGMV50FV",
        "user_id": 47,
        "status": true,
        "barman_id": 48,
        "created_at": "2024-07-09T03:35:22.000000Z",
        "updated_at": "2024-07-09T03:35:22.000000Z",
        "total_amount": 4104.84,
        "products": [
          {
            "id": 2,
            "product_category_id": 1,
            "name": "Beer of 350XAF",
            "price": "788.16",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 1,
            "pivot": {"ticket_id": 3, "product_id": 2}
          },
          {
            "id": 9,
            "product_category_id": 1,
            "name": "Beer of 954XAF",
            "price": "368.52",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 9,
            "pivot": {"ticket_id": 3, "product_id": 9}
          }
        ],
        "company": null,
        "user": {
          "id": 47,
          "phone_number": "+1-985-318-7212",
          "name": "Arnulfo Beahan"
        },
        "ticket_products": [
          {
            "id": 6,
            "ticket_id": 3,
            "product_id": 2,
            "quantity": 1,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 2,
              "product_category_id": 1,
              "name": "Beer of 350XAF",
              "price": "788.16",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          },
          {
            "id": 7,
            "ticket_id": 3,
            "product_id": 9,
            "quantity": 9,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 9,
              "product_category_id": 1,
              "name": "Beer of 954XAF",
              "price": "368.52",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          }
        ]
      },
      {
        "id": 4,
        "uuid": "TYSE2RBTIXSK",
        "user_id": 5,
        "status": false,
        "barman_id": null,
        "created_at": "2024-07-09T03:35:22.000000Z",
        "updated_at": "2024-07-09T03:35:22.000000Z",
        "total_amount": 14526.86,
        "products": [
          {
            "id": 2,
            "product_category_id": 1,
            "name": "Beer of 350XAF",
            "price": "788.16",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 2,
            "pivot": {"ticket_id": 4, "product_id": 2}
          },
          {
            "id": 5,
            "product_category_id": 1,
            "name": "Beer of 861XAF",
            "price": "412.39",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 5,
            "pivot": {"ticket_id": 4, "product_id": 5}
          },
          {
            "id": 7,
            "product_category_id": 1,
            "name": "Beer of 335XAF",
            "price": "503.10",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 10,
            "pivot": {"ticket_id": 4, "product_id": 7}
          },
          {
            "id": 8,
            "product_category_id": 1,
            "name": "Beer of 889XAF",
            "price": "976.89",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 5,
            "pivot": {"ticket_id": 4, "product_id": 8}
          },
          {
            "id": 10,
            "product_category_id": 1,
            "name": "Beer of 618XAF",
            "price": "973.14",
            "created_at": "2024-07-09T03:35:21.000000Z",
            "updated_at": "2024-07-09T03:35:21.000000Z",
            "quantity": 1,
            "pivot": {"ticket_id": 4, "product_id": 10}
          }
        ],
        "user": {
          "id": 5,
          "phone_number": "951-210-1860",
          "name": "Esteban Simonis"
        },
        "ticket_products": [
          {
            "id": 8,
            "ticket_id": 4,
            "product_id": 2,
            "quantity": 2,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 2,
              "product_category_id": 1,
              "name": "Beer of 350XAF",
              "price": "788.16",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          },
          {
            "id": 9,
            "ticket_id": 4,
            "product_id": 5,
            "quantity": 5,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 5,
              "product_category_id": 1,
              "name": "Beer of 861XAF",
              "price": "412.39",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          },
          {
            "id": 10,
            "ticket_id": 4,
            "product_id": 7,
            "quantity": 10,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 7,
              "product_category_id": 1,
              "name": "Beer of 335XAF",
              "price": "503.10",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          },
          {
            "id": 11,
            "ticket_id": 4,
            "product_id": 8,
            "quantity": 5,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 8,
              "product_category_id": 1,
              "name": "Beer of 889XAF",
              "price": "976.89",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          },
          {
            "id": 12,
            "ticket_id": 4,
            "product_id": 10,
            "quantity": 1,
            "created_at": "2024-07-09T03:35:22.000000Z",
            "updated_at": "2024-07-09T03:35:22.000000Z",
            "product": {
              "id": 10,
              "product_category_id": 1,
              "name": "Beer of 618XAF",
              "price": "973.14",
              "created_at": "2024-07-09T03:35:21.000000Z",
              "updated_at": "2024-07-09T03:35:21.000000Z"
            }
          }
        ]
      },
    ],
    "total": 50
  };
}
