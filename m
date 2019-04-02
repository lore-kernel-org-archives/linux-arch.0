From: guoren@kernel.org
Subject: [PATCH 3/3] riscv/signal: Fixup additional syscall restarting
Date: Tue,  2 Apr 2019 16:02:33 +0800
Message-ID: <1554192153-2587-3-git-send-email-guoren@kernel.org>
References: <1554192153-2587-1-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554192153-2587-1-git-send-email-guoren@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, palmer@sifive.com
Cc: linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, ren_guo@c-sky.com
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The function of do_notify_resume called by entry.S could be entered
in loop when SIGPENDING was setted again before sret. So we must add
prevent code to make syscall restart (regs->sepc -= 0x4) or it may
re-execute unexpected instructions.

Just like in_syscall & forget_syscall used by arm.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/kernel/signal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 837e164..804d6ee 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -234,6 +234,9 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 
 	/* Are we from a system call? */
 	if (regs->scause == EXC_SYSCALL) {
+		/* Avoid additional syscall restarting via ret_from_exception */
+		regs->scause = -1UL;
+
 		/* If so, check system call restarting.. */
 		switch (regs->a0) {
 		case -ERESTART_RESTARTBLOCK:
@@ -272,6 +275,9 @@ static void do_signal(struct pt_regs *regs)
 
 	/* Did we come from a system call? */
 	if (regs->scause == EXC_SYSCALL) {
+		/* Avoid additional syscall restarting via ret_from_exception */
+		regs->scause = -1UL;
+
 		/* Restart the system call - no handlers present */
 		switch (regs->a0) {
 		case -ERESTARTNOHAND:
-- 
2.7.4
