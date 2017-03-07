Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33691 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755990AbdCGVYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 16:24:08 -0500
Received: by mail-qk0-f180.google.com with SMTP id y76so26967208qkb.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2017 13:23:19 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 10/16] bpf: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:27 -0800
Message-ID: <1488920133-27229-11-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170307205527.2iKStfu5fpYsK2YMC-fCLsrfo4s7X0IDF2EfJGW-IdU@z>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: #ifdef guard
---
 include/linux/filter.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0c167fd..8053c38 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -18,7 +18,9 @@
 
 #include <net/sch_generic.h>
 
-#include <asm/cacheflush.h>
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
+#include <asm/set_memory.h>
+#endif
 
 #include <uapi/linux/filter.h>
 #include <uapi/linux/bpf.h>
-- 
2.7.4
