From: <gregkh@linuxfoundation.org>
Subject: Patch "locking/refcounts, x86/asm: Enable CONFIG_ARCH_HAS_REFCOUNT" has been added to the 4.14-stable tree
Date: Wed, 06 Dec 2017 18:25:59 +0100
Message-ID: <151258115912787@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdLFR0F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Dec 2017 12:26:05 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: keescook@chromium.org, alexander.levin@verizon.com, ard.biesheuvel@linaro.org, efault@gmx.de, elena.reshetova@intel.com, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de, torvalds@linux-foundation.org
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    locking/refcounts, x86/asm: Enable CONFIG_ARCH_HAS_REFCOUNT

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     locking-refcounts-x86-asm-enable-config_arch_has_refcount.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Wed Dec  6 18:04:41 CET 2017
From: Kees Cook <keescook@chromium.org>
Date: Sat, 2 Sep 2017 13:09:46 -0700
Subject: locking/refcounts, x86/asm: Enable CONFIG_ARCH_HAS_REFCOUNT

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


Patches currently in stable-queue which might be from keescook@chromium.org are

queue-4.14/locking-refcounts-x86-asm-use-unique-.text-section-for-refcount-exceptions.patch
queue-4.14/locking-refcounts-x86-asm-enable-config_arch_has_refcount.patch
