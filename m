From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 08/37] char: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:09 -0700
Message-ID: <1212092289.28403.110.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:41560 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbYE2USK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:10 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083442wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:10 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/char/pcmcia/cm4040_cs.c |    2 +-
 drivers/char/tpm/tpm_tis.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 035084c..450d329 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -268,7 +268,7 @@ static ssize_t cm4040_read(struct file *filp, char __user *buf,
 	}
 #endif
 
-	bytes_to_read = 5 + le32_to_cpu(*(__le32 *)&dev->r_buf[1]);
+	bytes_to_read = 5 + get_le32((__le32 *)&dev->r_buf[1]);
 
 	DEBUGP(6, dev, "BytesToRead=%lu\n", bytes_to_read);
 
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 13a4bdd..128148e 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -228,7 +228,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	expected = be32_to_cpu(*(__be32 *) (buf + 2));
+	expected = get_be32((__be32 *)(buf + 2));
 	if (expected > count) {
 		size = -EIO;
 		goto out;
-- 
1.5.6.rc0.277.g804cf
