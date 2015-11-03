From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 07/13] Make FB_BACKLIGHT_{LEVELS,MAX} always visible
Date: Tue,  3 Nov 2015 11:46:28 -0800
Message-ID: <1446579994-9937-8-git-send-email-palmer__42573.7727586695$1446580269$gmane$org@dabbelt.com>
References: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34446 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbbKCTqz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2015 14:46:55 -0500
Received: by padhx2 with SMTP id hx2so19310865pad.1
        for <linux-arch@vger.kernel.org>; Tue, 03 Nov 2015 11:46:55 -0800 (PST)
In-Reply-To: <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, dhowells@redhat.com
Cc: viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, josh@joshtriplett.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>

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
index fb795c3..8926f13 100644
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
2.4.10
