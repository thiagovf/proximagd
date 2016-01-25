package br.com.equipejr.auxi;

import java.util.Calendar;
import java.util.concurrent.TimeUnit;

public class CalendarUtil {

	public static long daysBetweenDates (Calendar cal1) {
		Calendar cal2 = Calendar.getInstance();
		long diff = cal1.getTimeInMillis() - cal2.getTimeInMillis();
		
		return TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
	}
}
