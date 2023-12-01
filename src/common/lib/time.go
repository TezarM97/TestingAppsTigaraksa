package lib

import (
	"time"

	"github.com/spf13/viper"
)

func TimeNow() time.Time {
	loc, _ := time.LoadLocation(viper.GetString("common.time_location"))
	now := time.Now().In(loc)
	return now
}

func AddDate(year int, month int, days int) time.Time {
	now := TimeNow()
	addTime := now.AddDate(year, month, days)
	return addTime
}

func AddHours(hour int) time.Time {
	now := TimeNow()
	addHour := now.Add(time.Hour * time.Duration(hour))
	return addHour
}

func AddMinutes(minutes int) time.Time {
	now := TimeNow()
	addHour := now.Add(time.Minute * time.Duration(minutes))
	return addHour
}

func LastDateOfMonth(year int, month time.Month) time.Time {
	//-------------------- example
	// loc, _ := time.LoadLocation("Asia/Jakarta")

	// timebulan := time.Month(8)

	// datatime := time.Date(2023, timebulan+1, 0, 0, 0, 0, 0, loc)
	// fmt.Println("last date : ", datatime)
	//--------------------

	loc, _ := time.LoadLocation(viper.GetString("common.time_location"))
	return time.Date(year, month+1, 0, 0, 0, 0, 0, loc)
}
