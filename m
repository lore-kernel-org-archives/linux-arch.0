From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Date: Mon, 26 Nov 2018 14:15:57 +0900
Message-ID: <20181126141557.3f7be1aad456345b9a0dfcae@kernel.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122002801.501220343@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Steve,

This series looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Thank you!

# Now I know why sometimes func-graph depth looks broken...


On Wed, 21 Nov 2018 19:28:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> While working on rewriting function graph tracer, I found a design
> flaw in the code. Commit 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth
> before calling trace return callback") tried to fix a bug that caused
> interrupts not to be traced if max_depth was set to 1 (for debugging
> NO_HZ_FULL), because if it came in just as another function that was being
> traced that had a depth of 1 was exiting. This caused the timing of being in
> the kernel to be off. The fix was simply to move the calling of the return
> function after the updating of curr_ret_stack index as that was what was
> being used.
> 
> The change log even says that it was safe to do this, but unfortunately it
> was not, and the barrier() there was specifically *for* that function (which
> shows why one should document barriers).
> 
> The problem is that the return callback may still be using what's on the
> shadow stack and by changing the shadow stack pointer, it may allow for
> another function being traced to overwrite that data. Note, if this happens,
> it will only cause garbage data to be traced and will not affect the actual
> operations of the kernel (ie. it wont crash).
> 
> Unfortunately just reverting that will bring back the old bug. The real way
> to fix that old bug is to create another counter to handle the depth, but
> this means that we need to change all the architectures that implement
> function graph tracing (that's 12 of them). Luckily, I need to do this
> anyway in my re-design so this is a good thing.
> 
> Since all the archictectures do basicall the same thing to prepare the
> function graph trace to be traced, I made a generic function that they all
> can use and simplified the logic of all the architectures. Then I'm able to
> fix the design problem in one place.
> 
> I pushed this code up to let zero-day have a whack at it, and I also
> downloaded the latest 8.1.0 cross compilers for all the archs that are
> affected and compiled tested them all (and got rid of all the warnings
> I introduced as well).
> 
> I marked this all for stable, but in reality it may not need to be ported
> as it will probably not be trivial to do so, becaues you'll need to also
> fix the architectures that are no longer used (although do we care about
> them?). But if someone really cares about correct timings of the function
> graph profiler when the options/graph-time is set to zero, then be my
> guest.
> 
> Feel free to test this! I'll be pushing this to linux-next and let it
> sit there a week or so before pushing it to Linus.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/urgent
> 
> Head SHA1: 1ffd62e282a649483afb0bb4d76f7244b3c10075
> 
> 
> Steven Rostedt (VMware) (18):
>       function_graph: Create function_graph_enter() to consolidate architecture code
>       x86/function_graph: Simplify with function_graph_entry()
>       ARM: function_graph: Simplify with function_graph_entry()
>       arm64: function_graph: Simplify with function_graph_entry()
>       microblaze: function_graph: Simplify with function_graph_entry()
>       MIPS: function_graph: Simplify with function_graph_entry()
>       nds32: function_graph: Simplify with function_graph_entry()
>       parisc: function_graph: Simplify with function_graph_entry()
>       powerpc/function_graph: Simplify with function_graph_entry()
>       riscv/function_graph: Simplify with function_graph_entry()
>       s390/function_graph: Simplify with function_graph_entry()
>       sh/function_graph: Simplify with function_graph_entry()
>       sparc/function_graph: Simplify with function_graph_entry()
>       function_graph: Make ftrace_push_return_trace() static
>       function_graph: Use new curr_ret_depth to manage depth instead of curr_ret_stack
>       function_graph: Move return callback before update of curr_ret_stack
>       function_graph: Reverse the order of pushing the ret_stack and the callback
>       function_graph: Have profiler use curr_ret_stack and not depth
> 
> ----
>  arch/arm/kernel/ftrace.c             | 17 +------------
>  arch/arm64/kernel/ftrace.c           | 15 +----------
>  arch/microblaze/kernel/ftrace.c      | 15 ++---------
>  arch/mips/kernel/ftrace.c            | 14 ++---------
>  arch/nds32/kernel/ftrace.c           | 18 ++-----------
>  arch/parisc/kernel/ftrace.c          | 17 +++----------
>  arch/powerpc/kernel/trace/ftrace.c   | 15 ++---------
>  arch/riscv/kernel/ftrace.c           | 14 ++---------
>  arch/s390/kernel/ftrace.c            | 13 ++--------
>  arch/sh/kernel/ftrace.c              | 16 ++----------
>  arch/sparc/kernel/ftrace.c           | 11 +-------
>  arch/x86/kernel/ftrace.c             | 15 +----------
>  include/linux/ftrace.h               |  4 +--
>  include/linux/sched.h                |  1 +
>  kernel/trace/ftrace.c                |  7 ++++--
>  kernel/trace/trace_functions_graph.c | 49 ++++++++++++++++++++++++++++--------
>  16 files changed, 67 insertions(+), 174 deletions(-)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
