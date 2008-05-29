From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 06/37] atm: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:05 -0700
Message-ID: <1212092285.28403.108.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:43046 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbYE2USG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:06 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083458wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:05 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/atm/lanai.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 144a49f..305f5cf 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -949,7 +949,7 @@ static int __devinit eeprom_read(struct lanai_dev *lanai)
 /* read a big-endian 4-byte value out of eeprom */
 static inline u32 eeprom_be4(const struct lanai_dev *lanai, int address)
 {
-	return be32_to_cpup((const u32 *) &lanai->eeprom[address]);
+	return get_be32((__be32 *)&lanai->eeprom[address]);
 }
 
 /* Checksum/validate EEPROM contents */
@@ -1409,7 +1409,7 @@ static void vcc_rx_aal5(struct lanai_vcc *lvcc, int endptr)
 	 * changes have arrived
 	 */
 	rmb();
-	size = be32_to_cpup(x) & 0xffff;
+	size = get_be32(x) & 0xffff;
 	if (unlikely(n != aal5_size(size))) {
 		/* Make sure size matches padding */
 		printk(KERN_INFO DEV_LABEL "(itf %d): Got bad AAL5 length "
@@ -1729,7 +1729,7 @@ static void run_service(struct lanai_dev *lanai)
 	const u32 *end = lanai->service.start + wreg;
 	while (lanai->service.ptr != end) {
 		ntx += handle_service(lanai,
-		    le32_to_cpup(lanai->service.ptr++));
+		    get_le32(lanai->service.ptr++));
 		if (lanai->service.ptr >= lanai->service.end)
 			lanai->service.ptr = lanai->service.start;
 	}
-- 
1.5.6.rc0.277.g804cf
