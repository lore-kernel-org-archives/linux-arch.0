From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC 3/3] asm-generic: Drop renameat syscall from default
	list
Date: Wed, 23 Apr 2014 11:08:07 +0100
Message-ID: <1398247687-13453-4-git-send-email-james.hogan@imgtec.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: Chen Liqin <liqin.linux@gmail.com>, James Hogan <james.hogan@imgtec.com>, linux-c6x-dev@linux-c6x.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Vineet Gupta <vgupta@synopsys.com>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Richard Kuo <rkuo@codeaurora.org>, linux@lists.openrisc.net, Lennox Wu <lennox.wu@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

The new renameat2 syscall provides all the functionality provided by the
renameat syscall and adds flags, so future architectures won't need to
include renameat.

Therefore drop the renameat syscall from the generic syscall list unless
__ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
including asm-generic/unistd.h, and adjust all architectures using the
generic syscall list to define it so that no in-tree architectures are
affected.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Vineet Gupta <vgupta@synopsys.com>
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
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
Is this the approach we want to take to keep the default syscall list
minimal? We could for example have made renameat2 use the renameat
syscall number for new arches, but it seemed best to leave a gap for new
arches to improve consistency of numbering.

This patch is a no-op for arches in tree, so there's no harm for this to
wait for the v3.16 merge window.
---
 arch/arc/include/uapi/asm/unistd.h       | 1 +
 arch/arm64/include/uapi/asm/unistd.h     | 3 +++
 arch/c6x/include/uapi/asm/unistd.h       | 1 +
 arch/hexagon/include/uapi/asm/unistd.h   | 1 +
 arch/metag/include/uapi/asm/unistd.h     | 2 ++
 arch/openrisc/include/uapi/asm/unistd.h  | 1 +
 arch/score/include/uapi/asm/unistd.h     | 1 +
 arch/tile/include/uapi/asm/unistd.h      | 1 +
 arch/unicore32/include/uapi/asm/unistd.h | 2 ++
 include/uapi/asm-generic/unistd.h        | 3 +++
 10 files changed, 16 insertions(+)

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
index 333640608087..947a864fa7d3 100644
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
1.8.1.2
