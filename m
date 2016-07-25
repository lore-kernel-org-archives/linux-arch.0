From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 04/14] arm64: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:37 -0400
Message-ID: <20160725034247.109173-5-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36438 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbcGYDny (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2016 23:43:54 -0400
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm64/kernel/probes/kprobes.c | 2 +-
 arch/arm64/mm/extable.c            | 2 +-
 arch/arm64/mm/fault.c              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index bf9768588288..9c1866ef3271 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -19,7 +19,7 @@
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/slab.h>
 #include <linux/stop_machine.h>
 #include <linux/stringify.h>
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 81acd4706878..c9f118cd812b 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -2,7 +2,7 @@
  * Based on arch/arm/mm/extable.c
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c8beaa0da7df..427f2fd49463 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -18,7 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/hardirq.h>
-- 
2.8.4
