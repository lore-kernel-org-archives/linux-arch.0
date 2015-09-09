Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33092 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbbIIVIx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2015 17:08:53 -0400
Received: by pacex6 with SMTP id ex6so20876691pac.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2015 14:08:52 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 07/13] Make FB_BACKLIGHT_{LEVELS,MAX} always visible
Date: Wed,  9 Sep 2015 14:08:16 -0700
Message-ID: <1441832902-28993-8-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20150909210816.3R66FI6G2Qm_7ClLurLLDYrcP_efFYBI_mcR7G90oC8@z>

Nothing else in the kernel defines this, and this header is visible to
userspace.  Rather than hiding it in an #ifdef, I think it's sane to
just make this visible to userspace.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/linux/fb.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index fb795c3b3c17..8926f13bc19f 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -392,11 +392,8 @@ struct fb_cursor {
 	struct fb_image	image;	/* Cursor image */
 };
 
-#ifdef CONFIG_FB_BACKLIGHT
 /* Settings for the generic backlight code */
 #define FB_BACKLIGHT_LEVELS	128
 #define FB_BACKLIGHT_MAX	0xFF
-#endif
-
 
 #endif /* _UAPI_LINUX_FB_H */
-- 
2.4.6

