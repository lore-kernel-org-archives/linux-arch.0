From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 4/5] mips: fix error values in case of bad_stack
Date: Tue, 28 Sep 2010 18:50:47 +0100
Message-ID: <E1P0eKF-0006jH-5I@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


we want EFAULT, not -<syscall number>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/scall32-o32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index d3edb9f..da98051 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -169,7 +169,7 @@ stackargs:
 	 * We probably should handle this case a bit more drastic.
 	 */
 bad_stack:
-	negu	v0				# error
+	li	v0, EFAULT
 	sw	v0, PT_R2(sp)
 	li	t0, 1				# set error flag
 	sw	t0, PT_R7(sp)
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 7ce0a36..d2bc285 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -156,7 +156,7 @@ trace_a_syscall:
 	 * The stackpointer for a call with more than 4 arguments is bad.
 	 */
 bad_stack:
-	dnegu	v0			# error
+	li	v0, EFAULT
 	sd	v0, PT_R2(sp)
 	li	t0, 1			# set error flag
 	sd	t0, PT_R7(sp)
-- 
1.5.6.5
