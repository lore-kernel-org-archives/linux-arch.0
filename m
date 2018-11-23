From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 15/18] function_graph: Use new curr_ret_depth
 to manage depth instead of curr_ret_stack
Date: Fri, 23 Nov 2018 09:14:47 -0500
Message-ID: <20181123091447.0e2eed1b@vmware.local.home>
References: <20181122002801.501220343@goodmis.org>
        <20181122003333.592319701@goodmis.org>
        <20181122100322.GN2131@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122100322.GN2131@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 22 Nov 2018 11:03:22 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 21, 2018 at 07:28:16PM -0500, Steven Rostedt wrote:
> > @@ -188,14 +186,20 @@ int function_graph_enter(unsigned long ret, unsigned long func,
> >  	struct ftrace_graph_ent trace;
> >  
> >  	trace.func = func;
> > -	trace.depth = current->curr_ret_stack + 1;
> > +	trace.depth = ++current->curr_ret_depth;
> >  
> >  	/* Only trace if the calling function expects to */
> >  	if (!ftrace_graph_entry(&trace))
> > -		return -EBUSY;
> > +		goto out;
> >  
> > -	return ftrace_push_return_trace(ret, func, &trace.depth,
> > -					frame_pointer, retp);
> > +	if (ftrace_push_return_trace(ret, func,
> > +				     frame_pointer, retp))  
> 
> You can unwrap that line, by my counting that's at 69 chars, so unless
> you're editing on a C64 it should fit your screen.

Thanks I may add a clean up patch. I already ran this code under
several hours of testing, and only plan on touching it if there's more
than cosmetic issues.

The reason that looks like that is because I just massaged the line it
replaced, and didn't take into account that I could now make it into a
single line.

> 
> > +		goto out;
> > +
> > +	return 0;
> > + out:
> > +	current->curr_ret_depth--;
> > +	return -EBUSY;
> >  }  
> 
> [diff "default"]
> 	xfuncname = "^[[:alpha:]$_].*[^:]$"
> 
> avoids the need for that ludicrous label indenting.

I still prefer the 'space', and it fits with the rest of the file ;-)

TomAYto / TomAHto

> 
> Also, "error" might be a better label name.

True. I'll add that on top too, but for the stable/rc release, that
isn't needed.

Thanks for taking a look at this code.

-- Steve
