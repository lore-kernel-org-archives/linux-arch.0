From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 64/75] locking/refcounts, x86/asm: Enable CONFIG_ARCH_HAS_REFCOUNT
Date: Thu,  7 Dec 2017 14:08:26 +0100
Message-ID: <20171207130821.402343480@linuxfoundation.org>
References: <20171207130818.742746317@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207130818.742746317@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Elena <elena.reshetova@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Sasha Levin <alexander.levin@verizon.com>
List-Id: linux-arch.vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>


[ Upstream commit 39208aa7ecb7d9c4e86df782b5693270313cbab1 ]

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -56,7 +56,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_PMEM_API		if X86_64
 	# Causing hangs/crashes, see the commit that added this change for details.
-	select ARCH_HAS_REFCOUNT		if BROKEN
+	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
