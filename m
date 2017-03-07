Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35206 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756352AbdCGV7B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 16:59:01 -0500
Received: by mail-qk0-f181.google.com with SMTP id v125so27964513qkh.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2017 13:59:00 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 09/16] watchdog: hpwdt: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:26 -0800
Message-ID: <1488920133-27229-10-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170307205526.hU1ouyv4RbzVFq2bjoqaZdfjuFUe5OeLsnwtJ3k3hxk@z>

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: No changes
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
