package lib

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func HandlerResponseHttp(c *gin.Context, code int, data any, message string, errorresponse any) {
	switch code {
	case 200:
		ResponseSuccess(c, data, message, errorresponse)
	case 201:
		ResponseCreate(c, data, message, errorresponse)
	case 400:
		ResponseBadrequest(c, data, message, errorresponse)
	case 401:
		ResponseUnauthorized(c, data, message, errorresponse)
	case 404:
		ResponseNotfound(c, data, message, errorresponse)
	case 409:
		ResponseConflic(c, data, message, errorresponse)
	case 500:
		ResponseInternalservererror(c, data, message, errorresponse)
	}
}

func ResponseSuccess(c *gin.Context, data any, message string, errorresponse any) { //200
	c.AbortWithStatusJSON(http.StatusOK, gin.H{
		"code":    http.StatusOK,
		"data":    data,
		"error":   errorresponse,
		"message": message})
}

func ResponseCreate(c *gin.Context, data any, message string, errorresponse any) { //201
	c.AbortWithStatusJSON(http.StatusCreated, gin.H{
		"code":    http.StatusCreated,
		"data":    data,
		"error":   errorresponse,
		"message": message})
}

func ResponseUnauthorized(c *gin.Context, data any, message string, errorresponse any) { //401
	c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{
		"code":    http.StatusUnauthorized,
		"data":    data,
		"error":   errorresponse,
		"message": message})
}

func ResponseNotfound(c *gin.Context, data any, message string, errorresponse any) { //404
	c.AbortWithStatusJSON(http.StatusNotFound, gin.H{
		"code":    http.StatusNotFound,
		"data":    data,
		"error":   errorresponse,
		"message": message})
	return
}

func ResponseInternalservererror(c *gin.Context, data any, message string, errorresponse any) { //500
	c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
		"code":    http.StatusInternalServerError,
		"data":    data,
		"error":   errorresponse,
		"message": message})

}

func ResponseConflic(c *gin.Context, data any, message string, errorresponse any) { //409
	c.AbortWithStatusJSON(http.StatusConflict, gin.H{
		"code":    http.StatusConflict,
		"data":    data,
		"error":   errorresponse,
		"message": message})
}

func ResponseBadrequest(c *gin.Context, data any, message string, errorresponse any) { //400
	c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
		"code":    http.StatusBadRequest,
		"data":    data,
		"error":   errorresponse,
		"message": message})
}
