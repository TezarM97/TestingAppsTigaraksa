package config

import (
	"github.com/spf13/viper"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var DBClientMysql *gorm.DB

func SetupMysql() error {
	host := viper.GetString("database.mysql.host") // viper ini gantinya .env, jadi dia ada di folder environment/common.yaml
	port := viper.GetString("database.mysql.port") // isee
	dbName := viper.GetString("database.mysql.db")
	username := viper.GetString("database.mysql.username")
	password := viper.GetString("database.mysql.password")

	// fmt.Println("databasenya : ", dbName)

	dsn := username + ":" + password + "@tcp" + "(" + host + ":" + port + ")/" + dbName + "?" + "parseTime=true&loc=Local"

	client, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

	if err != nil {
		return err
	}

	DBClientMysql = client

	return nil
}

func CloseMysql() error {
	// get generic db interface
	db, err := DBClientMysql.DB()

	// Return error if there problem
	if err != nil {
		return err
	}

	// close the db connection
	db.Close()

	return nil
}
