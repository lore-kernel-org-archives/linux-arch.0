From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 6/6] arm64: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
Date: Fri, 14 Dec 2018 22:00:54 -0500
Message-ID: <20181214220054.101f9e4c@vmware.local.home>
References: <20181210193007.655970639@goodmis.org>
        <20181210193335.417173167@goodmis.org>
        <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 13 Dec 2018 17:09:35 +0000
James Morse <james.morse@arm.com> wrote:

> Hi Steven,
> 

> I gave this branch a spin, but I hit the WARN_ON() fairly easily:

Thanks for testing!

Can you see if this patch fixes it for you?

-- Steve

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d4f04f0ca646..8dfd5021b933 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -246,10 +246,10 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	idx = current->curr_ret_stack - idx;
+	idx = task->curr_ret_stack - idx;
 
 	if (idx >= 0 && idx <= task->curr_ret_stack)
-		return &current->ret_stack[idx];
+		return &task->ret_stack[idx];
 
 	return NULL;
 }
