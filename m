From: Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH 2/6][RFC] audit: add arch field to seccomp event log
Date: Wed,  5 Mar 2014 16:27:03 -0500
Message-ID: <7f3959e9f2c971e91d63287518beb30aff56d917.1393974970.git.rgb@redhat.com>
References: <cover.1393974970.git.rgb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1393974970.git.rgb@redhat.com>
In-Reply-To: <cover.1393974970.git.rgb@redhat.com>
References: <cover.1393974970.git.rgb@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>, microblaze-uclinux@itee.uq.edu.au, linux@openrisc.net, x86@kernel.org, oleg@redhat.com, eparis@redhat.com, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, sgrubb@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

The AUDIT_SECCOMP record looks something like this:

type=SECCOMP msg=audit(1373478171.953:32775): auid=4325 uid=4325 gid=4325 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0 pid=12381 comm="test" sig=31 syscall=231 compat=0 ip=0x39ea8bca89 code=0x0

In order to determine what syscall 231 maps to, we need to have the arch= field right before it.

To see the event, compile this test.c program:

=====
int main(void)
{
        return seccomp_load(seccomp_init(SCMP_ACT_KILL));
}
=====

gcc -g test.c -o test -lseccomp

After running the program, find the record by:  ausearch --start recent -m SECCOMP -i

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

---
 kernel/auditsc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3bc12d2..7317f46 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -67,6 +67,7 @@
 #include <linux/binfmts.h>
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
+#include <asm/syscall.h>
 #include <linux/capability.h>
 #include <linux/fs_struct.h>
 #include <linux/compat.h>
@@ -2415,6 +2416,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld", signr);
+	audit_log_format(ab, " arch=%x",
+			 syscall_get_arch(current, task_pt_regs(current)));
 	audit_log_format(ab, " syscall=%ld", syscall);
 	audit_log_format(ab, " compat=%d", is_compat_task());
 	audit_log_format(ab, " ip=0x%lx", KSTK_EIP(current));
-- 
1.7.1
