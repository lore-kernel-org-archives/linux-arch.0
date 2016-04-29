Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:32291 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbcD2V3j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2016 17:29:39 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2] asm-generic: Drop renameat syscall from default list
Date: Fri, 29 Apr 2016 22:29:26 +0100
Message-ID: <1461965366-7893-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp
Message-ID: <20160429212926.qO73wlOG0LP8coxsrvqniLeI8SLE5akdUwgmvTXYj9w@z>

The newer renameat2 syscall provides all the functionality provided by
the renameat syscall and adds flags, so future architectures won't need
to include renameat.

Therefore drop the renameat syscall from the generic syscall list unless
__ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
including asm-generic/unistd.h, and adjust all architectures using the
generic syscall list to define it so that no in-tree architectures are
affected.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: linux-c6x-dev@linux-c6x.org
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-metag@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux@lists.openrisc.net
Cc: Chen Liqin <liqin.linux@gmail.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
---
I just found this patch on an old branch, it appears to have slipped
through the cracks. Time for a respon.

Changes in v2:
- Rebase onto v4.6-rc5.
- Add __ARCH_WANT_RENAMEAT to h8300 and nios2 arches too.
---
 arch/arc/include/uapi/asm/unistd.h       | 1 +
 arch/arm64/include/uapi/asm/unistd.h     | 3 +++
 arch/c6x/include/uapi/asm/unistd.h       | 1 +
 arch/h8300/include/uapi/asm/unistd.h     | 2 ++
 arch/hexagon/include/uapi/asm/unistd.h   | 1 +
 arch/metag/include/uapi/asm/unistd.h     | 2 ++
 arch/nios2/include/uapi/asm/unistd.h     | 2 ++
 arch/openrisc/include/uapi/asm/unistd.h  | 1 +
 arch/score/include/uapi/asm/unistd.h     | 1 +
 arch/tile/include/uapi/asm/unistd.h      | 1 +
 arch/unicore32/include/uapi/asm/unistd.h | 2 ++
 include/uapi/asm-generic/unistd.h        | 3 +++
 12 files changed, 20 insertions(+)

diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
index 39e58d1cdf90..41fa2ec9e02c 100644
--- a/arch/arc/include/uapi/asm/unistd.h
+++ b/arch/arc/include/uapi/asm/unistd.h
@@ -15,6 +15,7 @@
 #if !defined(_UAPI_ASM_ARC_UNISTD_H) || defined(__SYSCALL)
 #define _UAPI_ASM_ARC_UNISTD_H
 
+#define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 1caadc24e3fe..043d17a21342 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -13,4 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+#define __ARCH_WANT_RENAMEAT
+
 #include <asm-generic/unistd.h>
diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index e7d09a614d10..12d73d9d81f5 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -14,6 +14,7 @@
  *   more details.
  */
 
+#define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SYS_CLONE
 
 /* Use the standard ABI for syscalls. */
diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
index 7a2eb698def3..7dd20ef7625a 100644
--- a/arch/h8300/include/uapi/asm/unistd.h
+++ b/arch/h8300/include/uapi/asm/unistd.h
@@ -1,3 +1,5 @@
 #define __ARCH_NOMMU
 
+#define __ARCH_WANT_RENAMEAT
+
 #include <asm-generic/unistd.h>
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index ffee405d6803..21517600432b 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -27,6 +27,7 @@
  */
 
 #define sys_mmap2 sys_mmap_pgoff
+#define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/metag/include/uapi/asm/unistd.h b/arch/metag/include/uapi/asm/unistd.h
index b80b8e899d22..459b6ec15848 100644
--- a/arch/metag/include/uapi/asm/unistd.h
+++ b/arch/metag/include/uapi/asm/unistd.h
@@ -7,6 +7,8 @@
  * (at your option) any later version.
  */
 
+#define __ARCH_WANT_RENAMEAT
+
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
 
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index c4bf79510461..51a32c71ce2b 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -17,6 +17,8 @@
 
  #define sys_mmap2 sys_mmap_pgoff
 
+#define __ARCH_WANT_RENAMEAT
+
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
 
diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index ce40b71df006..471905bd7745 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -20,6 +20,7 @@
 
 #define sys_mmap2 sys_mmap_pgoff
 
+#define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
 
diff --git a/arch/score/include/uapi/asm/unistd.h b/arch/score/include/uapi/asm/unistd.h
index 9cb4260a5f3e..d4008c339e89 100644
--- a/arch/score/include/uapi/asm/unistd.h
+++ b/arch/score/include/uapi/asm/unistd.h
@@ -1,5 +1,6 @@
 #define __ARCH_HAVE_MMU
 
+#define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SYSCALL_NO_AT
 #define __ARCH_WANT_SYSCALL_NO_FLAGS
 #define __ARCH_WANT_SYSCALL_OFF_T
diff --git a/arch/tile/include/uapi/asm/unistd.h b/arch/tile/include/uapi/asm/unistd.h
index 3866397aaf5a..24e9187e85a8 100644
--- a/arch/tile/include/uapi/asm/unistd.h
+++ b/arch/tile/include/uapi/asm/unistd.h
@@ -12,6 +12,7 @@
  *   more details.
  */
 
+#define __ARCH_WANT_RENAMEAT
 #if !defined(__LP64__) || defined(__SYSCALL_COMPAT)
 /* Use the flavor of this syscall that matches the 32-bit API better. */
 #define __ARCH_WANT_SYNC_FILE_RANGE2
diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index d4cc4559d848..1f63c476528e 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -10,6 +10,8 @@
  * published by the Free Software Foundation.
  */
 
+#define __ARCH_WANT_RENAMEAT
+
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
 #define __ARCH_WANT_SYS_CLONE
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6e0f5f01734c..8fdb796c0540 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -127,8 +127,11 @@ __SYSCALL(__NR_unlinkat, sys_unlinkat)
 __SYSCALL(__NR_symlinkat, sys_symlinkat)
 #define __NR_linkat 37
 __SYSCALL(__NR_linkat, sys_linkat)
+#ifdef __ARCH_WANT_RENAMEAT
+/* renameat is superseded with flags by renameat2 */
 #define __NR_renameat 38
 __SYSCALL(__NR_renameat, sys_renameat)
+#endif /* __ARCH_WANT_RENAMEAT */
 
 /* fs/namespace.c */
 #define __NR_umount2 39
-- 
2.4.10

