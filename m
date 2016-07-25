From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 05/14] mips: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:38 -0400
Message-ID: <20160725034247.109173-6-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46427 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbcGYDnf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2016 23:43:35 -0400
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/kernel/module.c | 1 +
 arch/mips/kernel/traps.c  | 2 +-
 arch/mips/mm/extable.c    | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 79850e376ef6..94627a3a6a0d 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -20,6 +20,7 @@
 
 #undef DEBUG
 
+#include <linux/extable.h>
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6fb4704bd156..b4522e3a0562 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -20,7 +20,7 @@
 #include <linux/kexec.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
diff --git a/arch/mips/mm/extable.c b/arch/mips/mm/extable.c
index 9d25d2ba4b9e..e474fa2efed4 100644
--- a/arch/mips/mm/extable.c
+++ b/arch/mips/mm/extable.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 1997, 99, 2001 - 2004 Ralf Baechle <ralf@linux-mips.org>
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/spinlock.h>
 #include <asm/branch.h>
 #include <asm/uaccess.h>
-- 
2.8.4
