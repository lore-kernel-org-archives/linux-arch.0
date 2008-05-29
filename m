From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 02/37] powerpc: use get/put_endian helpers
Date: Thu, 29 May 2008 13:17:55 -0700
Message-ID: <1212092275.28403.104.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYE2UR5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:17:57 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:17:57 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index cff550e..7981205 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -528,7 +528,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	}
 
 	/* Validate the CRC */
-	crc = be32_to_cpu(*(__be32 *)((void *)firmware + calc_size));
+	crc = get_be32((__be32 *)((void *)firmware + calc_size));
 	if (crc != crc32(0, firmware, calc_size)) {
 		printk(KERN_ERR "qe-firmware: firmware CRC is invalid\n");
 		return -EIO;
-- 
1.5.6.rc0.277.g804cf
