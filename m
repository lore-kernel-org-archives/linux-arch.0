From: Sylvain Chouleur <sylvain.chouleur@intel.com>
Subject: [PATCH] rtc-cmos: Support of century field
Date: Mon, 15 Jun 2015 15:01:11 +0200
Message-ID: <87pp4xf7mw.fsf@schouleu-mobl1.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17972 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbbFOM6w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Jun 2015 08:58:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

If century field is supported by the RTC CMOS device, then we should use
it and do not consider years greater that 169 as an error.

For information, the year field of the rtc_time structure contains the
value to add to 1970 to obtain the current year.
This was a hack to be able to support years from 1970 to 2069.
This patch remains compatible with this implementation.

Signed-off-by: Sylvain Chouleur <sylvain.chouleur@intel.com>
---
 include/asm-generic/rtc.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
index fa86f240c874..4e3b6558331e 100644
--- a/include/asm-generic/rtc.h
+++ b/include/asm-generic/rtc.h
@@ -16,6 +16,9 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/delay.h>
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 
 #define RTC_PIE 0x40		/* periodic interrupt enable */
 #define RTC_AIE 0x20		/* alarm interrupt enable */
@@ -46,6 +49,7 @@ static inline unsigned int __get_rtc_time(struct rtc_time *time)
 {
 	unsigned char ctrl;
 	unsigned long flags;
+	unsigned char century = 0;
 
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_year;
@@ -79,6 +83,11 @@ static inline unsigned int __get_rtc_time(struct rtc_time *time)
 #ifdef CONFIG_MACH_DECSTATION
 	real_year = CMOS_READ(RTC_DEC_YEAR);
 #endif
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century)
+		century = CMOS_READ(acpi_gbl_FADT.century);
+#endif
 	ctrl = CMOS_READ(RTC_CONTROL);
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
@@ -90,12 +99,16 @@ static inline unsigned int __get_rtc_time(struct rtc_time *time)
 		time->tm_mday = bcd2bin(time->tm_mday);
 		time->tm_mon = bcd2bin(time->tm_mon);
 		time->tm_year = bcd2bin(time->tm_year);
+		century = bcd2bin(century);
 	}
 
 #ifdef CONFIG_MACH_DECSTATION
 	time->tm_year += real_year - 72;
 #endif
 
+	if (century)
+		time->tm_year += (century - 19) * 100;
+
 	/*
 	 * Account for differences between how the RTC uses the values
 	 * and how they are defined in a struct rtc_time;
@@ -122,6 +135,7 @@ static inline int __set_rtc_time(struct rtc_time *time)
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_yrs, leap_yr;
 #endif
+	unsigned char century = 0;
 
 	yrs = time->tm_year;
 	mon = time->tm_mon + 1;   /* tm_mon starts at zero */
@@ -150,6 +164,15 @@ static inline int __set_rtc_time(struct rtc_time *time)
 		yrs = 73;
 	}
 #endif
+
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century) {
+		century = (yrs + 1900) / 100;
+		yrs %= 100;
+	}
+#endif
+
 	/* These limits and adjustments are independent of
 	 * whether the chip is in binary mode or not.
 	 */
@@ -169,6 +192,7 @@ static inline int __set_rtc_time(struct rtc_time *time)
 		day = bin2bcd(day);
 		mon = bin2bcd(mon);
 		yrs = bin2bcd(yrs);
+		century = bin2bcd(century);
 	}
 
 	save_control = CMOS_READ(RTC_CONTROL);
@@ -185,6 +209,11 @@ static inline int __set_rtc_time(struct rtc_time *time)
 	CMOS_WRITE(hrs, RTC_HOURS);
 	CMOS_WRITE(min, RTC_MINUTES);
 	CMOS_WRITE(sec, RTC_SECONDS);
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century)
+		CMOS_WRITE(century, acpi_gbl_FADT.century);
+#endif
 
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-- 
1.9.1
