Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33171 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdIBUJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Sep 2017 16:09:53 -0400
Received: by mail-pg0-f53.google.com with SMTP id t3so9080769pgt.0
        for <linux-arch@vger.kernel.org>; Sat, 02 Sep 2017 13:09:53 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 2/2] locking/refcounts, x86/asm: Enable CONFIG_ARCH_HAS_REFCOUNT
Date: Sat,  2 Sep 2017 13:09:46 -0700
Message-ID: <1504382986-49301-3-git-send-email-keescook@chromium.org>
In-Reply-To: <1504382986-49301-1-git-send-email-keescook@chromium.org>
References: <1504382986-49301-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kees Cook <keescook@chromium.org>, Mike Galbraith <efault@gmx.de>, "x86@kernel.org" <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20170902200946.4aA2q7RA6JjoRcxfgUQrguISaoYIhj72Y-dGele87mY@z>

With the section inlining bug fixed for the x86 refcount protection,
we can turn the config back on.

Cc: Mike Galbraith <efault@gmx.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eaa8ff41f424..c6acdcdb3fc6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -56,7 +56,7 @@ config X86
 	select ARCH_HAS_MMIO_FLUSH
 	select ARCH_HAS_PMEM_API		if X86_64
 	# Causing hangs/crashes, see the commit that added this change for details.
-	select ARCH_HAS_REFCOUNT		if BROKEN
+	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
-- 
2.7.4
