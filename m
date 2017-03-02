Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36416 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753524AbdCBCRV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 21:17:21 -0500
Received: by mail-qk0-f175.google.com with SMTP id n186so99512182qkb.3
        for <linux-arch@vger.kernel.org>; Wed, 01 Mar 2017 18:17:20 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv2 09/14] watchdog: hpwdt: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:15:01 -0800
Message-ID: <1488413706-9739-10-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170302001501.3tNptjHwD3J5sIAfe5LGf-iX9Y7EDHp5I5DMO4nkUl0@z>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 70c7194..67fbe35 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -34,7 +34,7 @@
 #include <linux/nmi.h>
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #endif /* CONFIG_HPWDT_NMI_DECODING */
 #include <asm/nmi.h>
 #include <asm/frame.h>
-- 
2.7.4
