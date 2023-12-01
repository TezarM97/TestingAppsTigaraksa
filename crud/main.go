package main

import (
	"fmt"
	"os"
	"testapps/src/apps/crud/controllers"
	"testapps/src/config"

	// "testapps_tigaraksa/src/config"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/viper"
)

const (
	CONFIG_PATH string = "./environment"

	COMMON_CONFIG_TYPE string = "yaml"
	COMMON_CONFIG_NAME string = "common"

	SERVICE_CONFIG_TYPE string = "yaml"
	SERVICE_CONFIG_NAME string = "crudconf"

	INGRESS_PREFIX string = "/testapps_tigaraksa"
	VERSION        string = "v1"
)

func main() {
	setupConfig()

	// setupMongoDB()
	// defer closeMongoDB()

	setupMysql()
	defer closeMysql()

	// setupRedis()
	// defer closeRedis()

	//-------------------------------------- setup GRPC server
	// go grpc_usermanagement_authorization.SetupGrpcServerUserManagementAuthorization{}.SetupServer()
	//--------------------------------------

	api := gin.Default()
	crud := api.Group(fmt.Sprintf("%v/%v", INGRESS_PREFIX, VERSION))
	{
		crud.POST("/login", controllers.ControllersCrud{}.Login)
		crud.POST("/store", controllers.ControllersCrud{}.Store)
		crud.GET("/getdataall", controllers.ControllersCrud{}.Index)
		crud.GET("/getdatabyid/:id", controllers.ControllersCrud{}.GetDataById)
		crud.POST("/getdatabyname", controllers.ControllersCrud{}.GetDataByName)
		crud.DELETE("/deletedatabyname", controllers.ControllersCrud{}.Delete)
		crud.PUT("/updatedata", controllers.ControllersCrud{}.UpdateData)

	}

	// panel_management := api.Group(fmt.Sprintf("%v/%v", INGRESS_PREFIX, VERSION))
	// {
	// 	panel_management.POST("/", controllers.ControllersPanel{}.Index)
	// 	panel_management.POST("/store", controllers.ControllersPanel{}.Store)
	// 	panel_management.PUT("/update/:id_panel", controllers.ControllersPanel{}.Update)
	// }

	port := fmt.Sprintf(":%v", viper.GetString("server.port"))
	api.Run(port)

	log.Info("Running server ... ")
}

func setupConfig() {
	// viper.AddConfigPath(filepath.Base(CONFIG_PATH))
	viper.AddConfigPath(CONFIG_PATH)
	viper.SetConfigName(COMMON_CONFIG_NAME)
	viper.SetConfigType(COMMON_CONFIG_TYPE)

	if err := viper.ReadInConfig(); err != nil {
		log.Error("Error reading config file : ", err.Error())
		os.Exit(0)
	}

	viper.MergeInConfig()
	// viper.AddConfigPath(filepath.Base(CONFIG_PATH))
	viper.AddConfigPath(CONFIG_PATH)
	viper.SetConfigName(SERVICE_CONFIG_NAME)
	viper.SetConfigType(SERVICE_CONFIG_TYPE)
	viper.MergeInConfig()

}

func setupMysql() {
	err := config.SetupMysql()
	if err != nil {
		log.Error("Setup DB failed : ", err.Error())
		os.Exit(0)
	}

	fmt.Println("-------------------- MySQL Connection Success --------------------")
}

func closeMysql() {
	log.Info("Close MySQL connection ... ")
	err := config.CloseMysql()
	if err != nil {
		log.Error("Close DB failed : ", err.Error())
		os.Exit(0)
	}
}

// func setupPostgres() {
// 	err := config.SetupPostgres()
// 	if err != nil {
// 		log.Error("Setup DB failed : ", err.Error())
// 		os.Exit(0)
// 	}

// 	fmt.Println("-------------------- Postgres Connection Success --------------------")
// }

// func closePostgres() {
// 	log.Info("Close Postgres connection ... ")
// 	err := config.ClosePostgres()
// 	if err != nil {
// 		log.Error("Close DB failed : ", err.Error())
// 		os.Exit(0)
// 	}
// }

// func setupMongoDB() {
// 	err := config.SetupMongoDB()
// 	if err != nil {
// 		log.Error("Setup DB failed : ", err.Error())
// 		os.Exit(0)
// 	}

// 	fmt.Println("-------------------- Mongo Connection Success --------------------")
// }

// func closeMongoDB() {
// 	log.Info("Close MongoDB connection ... ")
// 	err := config.CloseMongoDB()
// 	if err != nil {
// 		log.Error("Close DB failed : ", err.Error())
// 		os.Exit(0)
// 	}
// }

// func setupRedis() {
// 	err := config.SetupRedis()
// 	if err != nil {
// 		log.Error("Setup Redis failed : ", err.Error())
// 		os.Exit(0)
// 	}

// 	fmt.Println("-------------------- Redis Connection Success --------------------")
// }

// func closeRedis() {
// 	log.Info("Close Redis connection ... ")
// 	err := config.CloseRedis()
// 	if err != nil {
// 		log.Error("Close DB failed : ", err.Error())
// 		os.Exit(0)
// 	}
// }
