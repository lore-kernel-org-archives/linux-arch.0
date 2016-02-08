Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38163 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836AbcBHR57 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2016 12:57:59 -0500
Received: by mail-wm0-f45.google.com with SMTP id p63so126884515wmp.1
        for <linux-arch@vger.kernel.org>; Mon, 08 Feb 2016 09:57:59 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 1/3] x86: kallsyms: disable absolute percpu symbols on !SMP
Date: Mon,  8 Feb 2016 18:57:46 +0100
Message-ID: <1454954268-3225-2-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1454954268-3225-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454954268-3225-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org, linux@roeck-us.net
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20160208175746.RGN_Do9o8DT30IU9ClKgzWhSkx6XZw3wrCGZyfrJPyU@z>

scripts/kallsyms.c has a special --absolute-percpu command line
option which deals with the zero based per cpu offsets that are
used when building for SMP on x86_64. This means that the option
should only be passed in that case, so add a Kconfig symbol with
the correct predicate, and use that instead.

Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 init/Kconfig            | 4 ++++
 scripts/link-vmlinux.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 22320804fbaf..b17824a875fa 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1420,6 +1420,10 @@ config KALLSYMS_ALL
 
 	   Say N unless you really need all symbols.
 
+config KALLSYMS_ABSOLUTE_PERCPU
+	bool
+	default X86_64 && SMP
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ba6c34ea5429..7a08bf9a9576 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -86,7 +86,7 @@ kallsyms()
 		kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
 	fi
 
-	if [ -n "${CONFIG_X86_64}" ]; then
+	if [ -n "${CONFIG_KALLSYMS_ABSOLUTE_PERCPU}" ]; then
 		kallsymopt="${kallsymopt} --absolute-percpu"
 	fi
 
-- 
2.5.0

