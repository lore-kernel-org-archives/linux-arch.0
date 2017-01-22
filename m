From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 12/20] nios2: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:36 -0500
Message-ID: <20170122163244.11740-13-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
List-Id: linux-arch.vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/nios2/mm/extable.c | 2 +-
 arch/nios2/mm/fault.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/mm/extable.c b/arch/nios2/mm/extable.c
index 4d2fc5a589d0..2574dba0407d 100644
--- a/arch/nios2/mm/extable.c
+++ b/arch/nios2/mm/extable.c
@@ -8,7 +8,7 @@
  * for more details.
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index affc4eb3f89e..e7a14e1e0d6b 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -21,7 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
 
-- 
2.11.0
