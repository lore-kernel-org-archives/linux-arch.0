From: tip-bot for Kees Cook <tipbot@zytor.com>
Subject: [tip:locking/core] locking/refcounts, x86/asm: Enable
 CONFIG_ARCH_HAS_REFCOUNT
Date: Thu, 28 Sep 2017 03:58:50 -0700
Message-ID: <tip-39208aa7ecb7d9c4e86df782b5693270313cbab1@git.kernel.org>
References: <1504382986-49301-3-git-send-email-keescook@chromium.org>
Reply-To: keescook@chromium.org, hpa@zytor.com, tglx@linutronix.de,
          ard.biesheuvel@linaro.org, peterz@infradead.org,
          linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
          elena.reshetova@intel.com, efault@gmx.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:42063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdI1LD1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2017 07:03:27 -0400
In-Reply-To: <1504382986-49301-3-git-send-email-keescook@chromium.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: keescook@chromium.org, hpa@zytor.com, tglx@linutronix.de, ard.biesheuvel@linaro.org, peterz@infradead.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, elena.reshetova@intel.com, mingo@kernel.org, linux-kernel@vger.kernel.org, efault@gmx.de

Commit-ID:  39208aa7ecb7d9c4e86df782b5693270313cbab1
Gitweb:     https://git.kernel.org/tip/39208aa7ecb7d9c4e86df782b5693270313cbab1
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Sat, 2 Sep 2017 13:09:46 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Sep 2017 09:45:05 +0200

locking/refcounts, x86/asm: Enable CONFIG_ARCH_HAS_REFCOUNT

With the section inlining bug fixed for the x86 refcount protection,
we can turn the config back on.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Elena <elena.reshetova@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch <linux-arch@vger.kernel.org>
Link: http://lkml.kernel.org/r/1504382986-49301-3-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 971feac..9053564 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -55,7 +55,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_PMEM_API		if X86_64
 	# Causing hangs/crashes, see the commit that added this change for details.
-	select ARCH_HAS_REFCOUNT		if BROKEN
+	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
