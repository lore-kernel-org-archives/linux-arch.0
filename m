From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 10/37] hwmon: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:15 -0700
Message-ID: <1212092295.28403.112.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43494 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbYE2USR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:17 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392319yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:16 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/hwmon/ibmaem.c |    6 +++---
 drivers/hwmon/ibmpex.c |   13 ++++---------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 5c006c9..1146f12 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -444,17 +444,17 @@ static int aem_read_sensor(struct aem_data *data, u8 elt, u8 reg,
 	}
 	case 2: {
 		u16 *x = buf;
-		*x = be16_to_cpup((u16 *)rs_resp->bytes);
+		*x = get_be16((__be16 *)rs_resp->bytes);
 		break;
 	}
 	case 4: {
 		u32 *x = buf;
-		*x = be32_to_cpup((u32 *)rs_resp->bytes);
+		*x = get_be32((__be32 *)rs_resp->bytes);
 		break;
 	}
 	case 8: {
 		u64 *x = buf;
-		*x = be64_to_cpup((u64 *)rs_resp->bytes);
+		*x = get_be64((__be64 *)rs_resp->bytes);
 		break;
 	}
 	}
diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 4e9b19c..e1c99f0 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -38,11 +38,6 @@
 #define PEX_NET_FUNCTION	0x3A
 #define PEX_COMMAND		0x3C
 
-static inline u16 extract_value(const char *data, int offset)
-{
-	return be16_to_cpup((u16 *)&data[offset]);
-}
-
 #define TEMP_SENSOR		1
 #define POWER_SENSOR		2
 
@@ -165,7 +160,7 @@ static int ibmpex_ver_check(struct ibmpex_bmc_data *data)
 		 "v%d.%d %d-%02d-%02d on interface %d\n",
 		 data->sensor_major,
 		 data->sensor_minor,
-		 extract_value(data->rx_msg_data, 2),
+		 get_be16((__be16 *)&data->rx_msg_data[2]),
 		 data->rx_msg_data[4],
 		 data->rx_msg_data[5],
 		 data->interface);
@@ -247,11 +242,11 @@ static void ibmpex_update_device(struct ibmpex_bmc_data *data)
 		if (err)
 			continue;
 		data->sensors[i].values[0] =
-			extract_value(data->rx_msg_data, 16);
+			get_be16((__be16 *)&data->rx_msg_data[16]);
 		data->sensors[i].values[1] =
-			extract_value(data->rx_msg_data, 18);
+			get_be16((__be16 *)&data->rx_msg_data[18]);
 		data->sensors[i].values[2] =
-			extract_value(data->rx_msg_data, 20);
+			get_be16((__be16 *)&data->rx_msg_data[20]);
 	}
 
 	data->last_updated = jiffies;
-- 
1.5.6.rc0.277.g804cf
