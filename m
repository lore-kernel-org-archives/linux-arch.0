From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH -tip RFC v2 05/22] kprobes: Use NOKPROBE_SYMBOL() in sample
	modules
Date: Fri, 15 Nov 2013 04:53:30 +0000
Message-ID: <20131115045330.27580.7377.stgit@kbuild-fedora.novalocal>
References: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Use NOKPROBE_SYMBOL() to protect handlers from kprobes
in sample modules.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 samples/kprobes/jprobe_example.c    |    1 +
 samples/kprobes/kprobe_example.c    |    3 +++
 samples/kprobes/kretprobe_example.c |    2 ++
 3 files changed, 6 insertions(+)

diff --git a/samples/kprobes/jprobe_example.c b/samples/kprobes/jprobe_example.c
index b754135..40114ac 100644
--- a/samples/kprobes/jprobe_example.c
+++ b/samples/kprobes/jprobe_example.c
@@ -35,6 +35,7 @@ static long jdo_fork(unsigned long clone_flags, unsigned long stack_start,
 	jprobe_return();
 	return 0;
 }
+NOKPROBE_SYMBOL(jdo_fork);
 
 static struct jprobe my_jprobe = {
 	.entry			= jdo_fork,
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 366db1a..462d90f 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -46,6 +46,7 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
 	/* A dump_stack() here will give a stack backtrace */
 	return 0;
 }
+NOKPROBE_SYMBOL(handler_pre);
 
 /* kprobe post_handler: called after the probed instruction is executed */
 static void handler_post(struct kprobe *p, struct pt_regs *regs,
@@ -68,6 +69,7 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
 		p->addr, regs->ex1);
 #endif
 }
+NOKPROBE_SYMBOL(handler_post);
 
 /*
  * fault_handler: this is called if an exception is generated for any
@@ -81,6 +83,7 @@ static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
 	/* Return 0 because we don't handle the fault. */
 	return 0;
 }
+NOKPROBE_SYMBOL(handler_fault);
 
 static int __init kprobe_init(void)
 {
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 1041b67..d932c52 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -47,6 +47,7 @@ static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 	data->entry_stamp = ktime_get();
 	return 0;
 }
+NOKPROBE_SYMBOL(entry_handler);
 
 /*
  * Return-probe handler: Log the return value and duration. Duration may turn
@@ -66,6 +67,7 @@ static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 			func_name, retval, (long long)delta);
 	return 0;
 }
+NOKPROBE_SYMBOL(ret_handler);
 
 static struct kretprobe my_kretprobe = {
 	.handler		= ret_handler,
