Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33666 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755968AbdCGVYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 16:24:08 -0500
Received: by mail-qk0-f178.google.com with SMTP id y76so26966097qkb.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2017 13:23:18 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 14/16] misc: sram: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:31 -0800
Message-ID: <1488920133-27229-15-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>
Message-ID: <20170307205531.PPd3OdGWVsoRwoAQxal4A0gx_RFh-zO4wPaAjHGSwfY@z>

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
V3: New file which was not caught in the first pass.
---
 drivers/misc/sram-exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index ac52241..3d528a1 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -16,9 +16,10 @@
 
 #include <linux/device.h>
 #include <linux/genalloc.h>
+#include <linux/mm.h>
 #include <linux/sram.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include "sram.h"
 
-- 
2.7.4
