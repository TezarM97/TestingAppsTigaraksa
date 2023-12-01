package lib

import "go.mongodb.org/mongo-driver/bson/primitive"

type Map map[string]interface{} // sama seperti array object {}
type Mapany map[string]any      // sama seperti array object {}
type Mapstring map[string]string
type Slice []interface{} // sama seperti array [] kosong

type IError struct {
	Field string
	Tag   string
	Value string
}

type Pagination struct {
	Limit  int32  `json:"limit,omitempty" validate:"required"`
	Offset int32  `json:"offset"`
	Search string `json:"search,omitempty"`
	Order  string `json:"order,omitempty" validate:"required"`
	Sort   string `json:"sort,omitempty" validate:"required"`
}

type UuidMigration struct {
	ID   primitive.ObjectID `json:"_id" bson:"_id,omitempty"`
	Uuid string             `json:"uuid" bson:"uuid,omitempty"`
}

type KeyValue struct {
	Key   string `json:"key" bson:"key,omitempty"`
	Value any    `json:"value" bson:"value,omitempty"`
}

type LogCreate struct {
	ID          primitive.ObjectID `json:"_id" bson:"_id,omitempty"`
	Type        string             `json:"type" bson:"type,omitempty"`
	Service     string             `json:"service" bson:"service,omitempty"`
	SubService  string             `json:"sub_service" bson:"sub_service,omitempty"`
	Table       string             `json:"table" bson:"table,omitempty"`
	Description string             `json:"description" bson:"description,omitempty"`
	Error       any                `json:"error" bson:"error,omitempty"`
	CreatedAt   string             `json:"created_at" bson:"created_at,omitempty"`
}

type JwtSession struct {
	Key       int64  `json:"key" bson:"key,omitempty"`
	Value     string `json:"value" bson:"value,omitempty"`
	ExpiredAt int64  `json:"expired_at" bson:"expired_at,omitempty"`
}

type DtosHeader struct {
	Key   string `json:"key"`
	Value string `json:"value"`
}

type DtosBody struct {
	Key   string `json:"key"`
	Value string `json:"value"`
}

type HttpClientStructResponse struct {
	Code int `json:"code"`
	Body any `json:"body"`
}
