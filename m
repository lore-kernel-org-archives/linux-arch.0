From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv2 11/14] module: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:15:03 -0800
Message-ID: <1488413706-9739-12-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34187 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdCBAWs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 19:22:48 -0500
Received: by mail-qk0-f173.google.com with SMTP id s186so98855475qkb.1
        for <linux-arch@vger.kernel.org>; Wed, 01 Mar 2017 16:22:05 -0800 (PST)
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jessica Yu <jeyu@redhat.com>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>linux


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module.c b/kernel/module.c
index 7eba6de..c0f04b3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -49,6 +49,7 @@
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/mmu_context.h>
 #include <linux/license.h>
 #include <asm/sections.h>
-- 
2.7.4
