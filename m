Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbeK1FFs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Nov 2018 00:05:48 -0500
Date: Tue, 27 Nov 2018 18:07:23 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [for-next][PATCH 04/18] arm64: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181127180722.GB19216@arm.com>
References: <20181122002801.501220343@goodmis.org>
 <20181122003331.917870132@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122003331.917870132@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, stable@kernel.org
Message-ID: <20181127180723.thT2viM0fEqwkASXhLviVfV2g0AhbtrG5ktk3-w2_58@z>

On Wed, Nov 21, 2018 at 07:28:05PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The function_graph_entry() function does the work of calling the function
> graph hook function and the management of the shadow stack, simplifying the
> work done in the architecture dependent prepare_ftrace_return().
> 
> Have arm64 use the new code, and remove the shadow stack management as well as
> having to set up the trace structure.
> 
> This is needed to prepare for a fix of a design bug on how the curr_ret_stack
> is used.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@kernel.org
> Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/arm64/kernel/ftrace.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Minor nit: the subject refers to function_graph_entry(), but looks like
you settled on function_graph_enter() in the end.

Anyway, looks like no change for us, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
