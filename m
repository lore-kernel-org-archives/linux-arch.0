From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 11/14] alpha: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:44 -0400
Message-ID: <20160725034247.109173-12-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/alpha/kernel/traps.c | 2 +-
 arch/alpha/mm/fault.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 74aceead06e9..7cf05aa482d5 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -13,7 +13,7 @@
 #include <linux/sched.h>
 #include <linux/tty.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kallsyms.h>
 #include <linux/ratelimit.h>
 
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 83e9eee57a55..47948b4dd157 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -22,7 +22,7 @@
 #include <linux/mman.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 extern void die_if_kernel(char *,struct pt_regs *,long, unsigned long *);
-- 
2.8.4
