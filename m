Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33769 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdCGXlK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 18:41:10 -0500
Received: by mail-qk0-f176.google.com with SMTP id y76so33269351qkb.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2017 15:39:39 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 08/16] intel_th: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:25 -0800
Message-ID: <1488920133-27229-9-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170307205525.ZEXLMXDY7rAcWKVFuto5OvbG-wZwtmy7W0CuVY4S5RI@z>

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Add #ifdef CONFIG_X86
---
 drivers/hwtracing/intel_th/msu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index e88afe1..dbbe31d 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -27,7 +27,9 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/cacheflush.h>
+#ifdef CONFIG_X86
+#include <asm/set_memory.h>
+#endif
 
 #include "intel_th.h"
 #include "msu.h"
-- 
2.7.4
