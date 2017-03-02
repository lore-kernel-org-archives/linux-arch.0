Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33266 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbdCBCC4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 21:02:56 -0500
Received: by mail-qk0-f176.google.com with SMTP id n127so102002973qkf.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Mar 2017 18:02:50 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv2 10/14] bpf: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:15:02 -0800
Message-ID: <1488413706-9739-11-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170302001502.lFEyBiz2lTQSRSIj1upDBqxDnqjD5XUUIzWb2GPE60E@z>


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0c167fd..c2b403f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -18,7 +18,7 @@
 
 #include <net/sch_generic.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <uapi/linux/filter.h>
 #include <uapi/linux/bpf.h>
-- 
2.7.4
