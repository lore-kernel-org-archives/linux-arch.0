Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27033 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753439AbeAFBTN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jan 2018 20:19:13 -0500
Subject: [PATCH 12/18] Thermal/int340x: prevent bounds-check bypass via
 speculative execution
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 05 Jan 2018 17:10:59 -0800
Message-ID: <151520105920.32271.1091443154687576996.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, torvalds@linux-foundation.org, tglx@linutronix.de, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
Message-ID: <20180106011059.q6TBbkaN2J2Lw26lwZ_a5xKxhQSdYVOBYIDJT6xizQc@z>

Static analysis reports that 'trip' may be a user controlled value that
is used as a data dependency to read '*temp' from the 'd->aux_trips'
array.  In order to avoid potential leaks of kernel memory values, block
speculative execution of the instruction stream that could issue reads
based on an invalid value of '*temp'.

Based on an original patch by Elena Reshetova.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../thermal/int340x_thermal/int340x_thermal_zone.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
index 145a5c53ff5c..442a1d9bf7ad 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/compiler.h>
 #include "int340x_thermal_zone.h"
 
 static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
@@ -52,20 +53,21 @@ static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
 					 int trip, int *temp)
 {
 	struct int34x_thermal_zone *d = zone->devdata;
+	unsigned long *elem;
 	int i;
 
 	if (d->override_ops && d->override_ops->get_trip_temp)
 		return d->override_ops->get_trip_temp(zone, trip, temp);
 
-	if (trip < d->aux_trip_nr)
-		*temp = d->aux_trips[trip];
-	else if (trip == d->crt_trip_id)
+	if ((elem = nospec_array_ptr(d->aux_trips, trip, d->aux_trip_nr))) {
+		*temp = *elem;
+	} else if (trip == d->crt_trip_id) {
 		*temp = d->crt_temp;
-	else if (trip == d->psv_trip_id)
+	} else if (trip == d->psv_trip_id) {
 		*temp = d->psv_temp;
-	else if (trip == d->hot_trip_id)
+	} else if (trip == d->hot_trip_id) {
 		*temp = d->hot_temp;
-	else {
+	} else {
 		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
 			if (d->act_trips[i].valid &&
 			    d->act_trips[i].id == trip) {
