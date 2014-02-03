From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] asm-generic: add sched_setattr/sched_getattr
	syscalls
Date: Mon, 3 Feb 2014 15:33:37 +0000
Message-ID: <1391441617-21518-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Chen Liqin <liqin.linux@gmail.com>, James Hogan <james.hogan@imgtec.com>, linux-c6x-dev@linux-c6x.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Vineet Gupta <vgupta@synopsys.com>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Richard Kuo <rkuo@codeaurora.org>, linux@lists.openrisc.net, Lennox Wu <lennox.wu@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Add the sched_setattr and sched_getattr syscalls to the generic syscall
list, which is used by the following architectures: arc, arm64, c6x,
hexagon, metag, openrisc, score, tile, unicore32.

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
 include/uapi/asm-generic/unistd.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a20a9b4d3871..dde8041f40d2 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -692,9 +692,13 @@ __SC_COMP(__NR_process_vm_writev, sys_process_vm_writev, \
 __SYSCALL(__NR_kcmp, sys_kcmp)
 #define __NR_finit_module 273
 __SYSCALL(__NR_finit_module, sys_finit_module)
+#define __NR_sched_setattr 274
+__SYSCALL(__NR_sched_setattr, sys_sched_setattr)
+#define __NR_sched_getattr 275
+__SYSCALL(__NR_sched_getattr, sys_sched_getattr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 274
+#define __NR_syscalls 276
 
 /*
  * All syscalls below here should go away really,
-- 
1.8.1.2
