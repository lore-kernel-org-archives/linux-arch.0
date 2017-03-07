From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 15/16] video: vermilion: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:32 -0800
Message-ID: <1488920133-27229-16-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32895 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdCGU5q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 15:57:46 -0500
Received: by mail-qk0-f178.google.com with SMTP id y76so25675700qkb.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2017 12:56:47 -0800 (PST)
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>linux


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: New files not caught in the first pass
---
 drivers/video/fbdev/vermilion/vermilion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 1c1e95a..ce4c4729 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -37,7 +37,7 @@
 #include <linux/mm.h>
 #include <linux/fb.h>
 #include <linux/pci.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 #include <linux/mmzone.h>
 
-- 
2.7.4
