From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 20/37] fbdev: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:39 -0700
Message-ID: <1212092319.28403.122.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:1069 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbYE2USm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:42 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1839946ika.5
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:41 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied <airlied@linux.ie>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/video/aty/mach64_accel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/mach64_accel.c b/drivers/video/aty/mach64_accel.c
index a8f60c3..4e8b77c 100644
--- a/drivers/video/aty/mach64_accel.c
+++ b/drivers/video/aty/mach64_accel.c
@@ -412,7 +412,7 @@ void atyfb_imageblit(struct fb_info *info, const struct fb_image *image)
 		u32 *pbitmap, dwords = (src_bytes + 3) / 4;
 		for (pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, le32_to_cpup(pbitmap), par);
+			aty_st_le32(HOST_DATA0, get_le32(pbitmap), par);
 		}
 	}
 
-- 
1.5.6.rc0.277.g804cf
