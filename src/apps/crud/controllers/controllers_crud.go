package controllers

import (
	"net/http"
	"testapps/src/apps/crud/dtos"
	"testapps/src/apps/crud/services"
	"testapps/src/common/entity"
	"testapps/src/common/lib"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
)

type ControllersCrud struct{}

func (self ControllersCrud) UpdateData(c *gin.Context) {
	var errors []*lib.IError
	validate := validator.New()
	var request entity.Dataperusahaan
	c.BindJSON(&request)
	err := validate.Struct(request)
	if err != nil {
		lib.HandlerResponseHttp(c, http.StatusBadRequest, errors, "error validation", err.Error())
		return
	}
	//-------------

	code, data, message, errorresp := services.ServicesCrud{}.Update(request, request)
	if errorresp != nil {
		lib.HandlerResponseHttp(c, code, data, message, errorresp.Error())
		return
	}

	lib.HandlerResponseHttp(c, code, data, message, nil)
	return

}

func (self ControllersCrud) Index(c *gin.Context) {

	code, data, message, errorresp := services.ServicesCrud{}.Index()
	if errorresp != nil {
		lib.HandlerResponseHttp(c, code, data, message, errorresp.Error())
		return
	}

	lib.HandlerResponseHttp(c, code, data, message, nil)
	return

}

func (self ControllersCrud) Delete(c *gin.Context) {
	var errors []*lib.IError
	validate := validator.New()
	var request dtos.DtosFindByName
	c.BindJSON(&request)
	err := validate.Struct(request)
	if err != nil {
		for _, err := range err.(validator.ValidationErrors) {
			var el lib.IError
			el.Field = err.Field()
			el.Tag = err.Tag()
			el.Value = err.Param()
			errors = append(errors, &el)
		}
		lib.HandlerResponseHttp(c, http.StatusBadRequest, errors, "error validation", err.Error())
		return
	}
	//-------------

	code, data, message, errorresp := services.ServicesCrud{}.Delete(request)
	if errorresp != nil {
		lib.HandlerResponseHttp(c, code, data, message, errorresp.Error())
		return
	}

	lib.HandlerResponseHttp(c, code, data, message, nil)
	return
}

func (self ControllersCrud) GetDataByName(c *gin.Context) {
	//------------- validation
	var errors []*lib.IError
	validate := validator.New()
	var request dtos.DtosFindByName
	c.BindJSON(&request)
	err := validate.Struct(request)
	if err != nil {
		for _, err := range err.(validator.ValidationErrors) {
			var el lib.IError
			el.Field = err.Field()
			el.Tag = err.Tag()
			el.Value = err.Param()
			errors = append(errors, &el)
		}
		lib.HandlerResponseHttp(c, http.StatusBadRequest, errors, "error validation", err.Error())
		return
	}
	//-------------

	code, data, message, errorresp := services.ServicesCrud{}.GetDataByName(request)
	if errorresp != nil {
		lib.HandlerResponseHttp(c, code, data, message, errorresp.Error())
		return
	}

	lib.HandlerResponseHttp(c, code, data, message, nil)
	return
}

func (self ControllersCrud) Login(c *gin.Context) {
	//------------- validation
	var errors []*lib.IError
	validate := validator.New()
	var request dtos.DtosLogin
	c.BindJSON(&request)
	err := validate.Struct(request)
	if err != nil {
		for _, err := range err.(validator.ValidationErrors) {
			var el lib.IError
			el.Field = err.Field()
			el.Tag = err.Tag()
			el.Value = err.Param()
			errors = append(errors, &el)
		}
		lib.HandlerResponseHttp(c, http.StatusBadRequest, errors, "error validation", err.Error())
		return
	}
	//-------------

	code, data, message, errorresp := services.ServicesCrud{}.Logins(request)
	if errorresp != nil {
		lib.HandlerResponseHttp(c, code, data, message, errorresp.Error())
		return
	}

	lib.HandlerResponseHttp(c, code, data, message, nil)
	return
}

func (self ControllersCrud) GetDataById(c *gin.Context) {
	id := c.Param("id")

	code, data, message, errorresp := services.ServicesCrud{}.GetDataById(id)
	if errorresp != nil {
		lib.HandlerResponseHttp(c, code, data, message, errorresp.Error())
		return
	}

	lib.HandlerResponseHttp(c, code, data, message, nil)
	return
}

func (self ControllersCrud) Store(c *gin.Context) {
	//------------- validation
	var errors []*lib.IError
	validate := validator.New()
	var request entity.Dataperusahaan
	c.BindJSON(&request)
	err := validate.Struct(request)
	if err != nil {
		for _, err := range err.(validator.ValidationErrors) {
			var el lib.IError
			el.Field = err.Field()
			el.Tag = err.Tag()
			el.Value = err.Param()
			errors = append(errors, &el)
		}
		lib.HandlerResponseHttp(c, http.StatusBadRequest, errors, "error validation", err.Error())
		return
	}
	//-------------

	code, data, message, errorresp := services.ServicesCrud{}.Store(request)
	if errorresp != nil {
		lib.HandlerResponseHttp(c, code, data, message, errorresp.Error())
		return
	}
	lib.HandlerResponseHttp(c, code, data, message, nil)
	return

}
