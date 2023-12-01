package helper

import (
	"testapps/src/common/lib"

	"github.com/spf13/viper"
)

type HelperLog struct{}

func (self HelperLog) StoreLog(req lib.LogCreate) {
	timenow := lib.TimeNow()
	parse := timenow.Format(viper.GetString("common.date_time_ymdhis"))
	self.SaveMongo(lib.LogCreate{
		Type:        req.Type,
		Service:     req.Service,
		SubService:  req.SubService,
		Table:       req.Table,
		Description: req.Description,
		Error:       req.Error,
		CreatedAt:   parse,
	}, "log_error")
	// fmt.Println("log error : ", err)
}

func (self HelperLog) SaveMongo(data lib.LogCreate, collection string) error {
	// dbconn := config.DBClientMongo.Database(viper.GetString("database.mongo.name")).Collection(collection)

	// _, err := dbconn.InsertOne(context.TODO(), data)

	// if err != nil || err == mongo.ErrNoDocuments {
	// 	return err
	// } else {
	// 	return nil
	// }

	return nil
}
