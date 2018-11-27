Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeK1FZH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Nov 2018 00:25:07 -0500
Date: Tue, 27 Nov 2018 13:26:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 04/18] arm64: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181127132618.2b3e1944@gandalf.local.home>
In-Reply-To: <20181127180722.GB19216@arm.com>
References: <20181122002801.501220343@goodmis.org>
        <20181122003331.917870132@goodmis.org>
        <20181127180722.GB19216@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, stable@kernel.org
Message-ID: <20181127182618.DxWVB0gK2iR7fqEwaIG3S9QNVHqguYdbxCFY3EFSYhg@z>

On Tue, 27 Nov 2018 18:07:23 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Nov 21, 2018 at 07:28:05PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The function_graph_entry() function does the work of calling the function
> > graph hook function and the management of the shadow stack, simplifying the
> > work done in the architecture dependent prepare_ftrace_return().
> > 
> > Have arm64 use the new code, and remove the shadow stack management as well as
> > having to set up the trace structure.
> > 
> > This is needed to prepare for a fix of a design bug on how the curr_ret_stack
> > is used.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@kernel.org
> > Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)  
> 
> Minor nit: the subject refers to function_graph_entry(), but looks like
> you settled on function_graph_enter() in the end.

Ah you're right!

> 
> Anyway, looks like no change for us, so:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

-- Steve
