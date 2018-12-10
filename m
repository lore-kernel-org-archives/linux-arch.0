From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/6] powerpc/frace: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
Date: Mon, 10 Dec 2018 14:30:10 -0500
Message-ID: <20181210193334.998050515@goodmis.org>
References: <20181210193007.655970639@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[
  Folks, I'm working on rewriting the function graph tracer. In order to
  do so, some changes need to be done that affect architecture specific
  code. I'm only able to compile test these changes. I would like to
  have folks check out my repo and give them a test.

    git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  ftrace/core

  Head SHA1: 51584396cff54aaf57ed0bd353767d71429f77b4
]

The structure of the ret_stack array on the task struct is going to
change, and accessing it directly via the curr_ret_stack index will no
longer give the ret_stack entry that holds the return address. To access
that, architectures must now use ftrace_graph_get_ret_stack() to get the
associated ret_stack that matches the saved return address.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/powerpc/kernel/process.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f34730010f..ce393df243aa 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2061,9 +2061,10 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	int count = 0;
 	int firstframe = 1;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	int curr_frame = current->curr_ret_stack;
+	struct ftrace_ret_stack *ret_stack;
 	extern void return_to_handler(void);
 	unsigned long rth = (unsigned long)return_to_handler;
+	int curr_frame = 0;
 #endif
 
 	sp = (unsigned long) stack;
@@ -2089,9 +2090,13 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((ip == rth) && curr_frame >= 0) {
-				pr_cont(" (%pS)",
-				       (void *)current->ret_stack[curr_frame].ret);
-				curr_frame--;
+				ret_stack = ftrace_graph_get_ret_stack(current,
+								  curr_frame++);
+				if (ret_stack)
+					pr_cont(" (%pS)",
+						(void *)ret_stack->ret);
+				else
+					curr_frame = -1;
 			}
 #endif
 			if (firstframe)
-- 
2.19.1
