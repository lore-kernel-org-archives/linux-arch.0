From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 15/20] score: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:39 -0500
Message-ID: <20170122163244.11740-16-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Cc: Chen Liqin <liqin.linux@gmail.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/score/mm/extable.c | 2 +-
 arch/score/mm/fault.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/score/mm/extable.c b/arch/score/mm/extable.c
index 01ff6445171c..ec871355fc2d 100644
--- a/arch/score/mm/extable.c
+++ b/arch/score/mm/extable.c
@@ -23,7 +23,7 @@
  * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 
 int fixup_exception(struct pt_regs *regs)
 {
diff --git a/arch/score/mm/fault.c b/arch/score/mm/fault.c
index 995b71e4db4b..b85fad4f0874 100644
--- a/arch/score/mm/fault.c
+++ b/arch/score/mm/fault.c
@@ -28,7 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/string.h>
-- 
2.11.0
