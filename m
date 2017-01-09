From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 03/10] m32r: migrate exception table users off module.h and onto extable.h
Date: Mon, 9 Jan 2017 15:40:03 -0500
Message-ID: <20170109204010.5047-4-paul.gortmaker@windriver.com>
References: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-arch.vger.kernel.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/m32r/mm/extable.c | 2 +-
 arch/m32r/mm/fault.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m32r/mm/extable.c b/arch/m32r/mm/extable.c
index 40ccf80d29cf..8ac8ba6ef60c 100644
--- a/arch/m32r/mm/extable.c
+++ b/arch/m32r/mm/extable.c
@@ -2,7 +2,7 @@
  * linux/arch/m32r/mm/extable.c
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
index a3785d3644c2..a05dc3184594 100644
--- a/arch/m32r/mm/fault.c
+++ b/arch/m32r/mm/fault.c
@@ -23,7 +23,7 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/highmem.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 #include <asm/m32r.h>
-- 
2.11.0
