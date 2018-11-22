From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [for-next][PATCH 15/18] function_graph: Use new curr_ret_depth
 to manage depth instead of curr_ret_stack
Date: Thu, 22 Nov 2018 11:03:22 +0100
Message-ID: <20181122100322.GN2131@hirez.programming.kicks-ass.net>
References: <20181122002801.501220343@goodmis.org>
 <20181122003333.592319701@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122003333.592319701@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 21, 2018 at 07:28:16PM -0500, Steven Rostedt wrote:
> @@ -188,14 +186,20 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  	struct ftrace_graph_ent trace;
>  
>  	trace.func = func;
> -	trace.depth = current->curr_ret_stack + 1;
> +	trace.depth = ++current->curr_ret_depth;
>  
>  	/* Only trace if the calling function expects to */
>  	if (!ftrace_graph_entry(&trace))
> -		return -EBUSY;
> +		goto out;
>  
> -	return ftrace_push_return_trace(ret, func, &trace.depth,
> -					frame_pointer, retp);
> +	if (ftrace_push_return_trace(ret, func,
> +				     frame_pointer, retp))

You can unwrap that line, by my counting that's at 69 chars, so unless
you're editing on a C64 it should fit your screen.

> +		goto out;
> +
> +	return 0;
> + out:
> +	current->curr_ret_depth--;
> +	return -EBUSY;
>  }

[diff "default"]
	xfuncname = "^[[:alpha:]$_].*[^:]$"

avoids the need for that ludicrous label indenting.

Also, "error" might be a better label name.
