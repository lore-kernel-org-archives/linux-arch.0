From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 07/14] powerpc: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:40 -0400
Message-ID: <20160725034247.109173-8-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36478 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbcGYDoC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2016 23:44:02 -0400
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/kprobes.c | 2 +-
 arch/powerpc/mm/fault.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 3ed8ec09b5c9..e785cc9e1ecd 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -29,7 +29,7 @@
 #include <linux/kprobes.h>
 #include <linux/ptrace.h>
 #include <linux/preempt.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/slab.h>
 #include <asm/code-patching.h>
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a4db22f65021..bb1ffc559f38 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -26,7 +26,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/perf_event.h>
-- 
2.8.4
