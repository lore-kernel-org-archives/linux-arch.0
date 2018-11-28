Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeK2IDU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Nov 2018 03:03:20 -0500
Date: Wed, 28 Nov 2018 16:00:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Message-ID: <20181128160021.09acd1af@gandalf.local.home>
In-Reply-To: <20181128203931.ym2rkya7a6agzzy3@redhat.com>
References: <20181122002801.501220343@goodmis.org>
        <20181128203931.ym2rkya7a6agzzy3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Message-ID: <20181128210021.kK-XBc09aA039mSZ7_itCZDg98hz6j7O7IAMQMi6GOE@z>

On Wed, 28 Nov 2018 15:39:31 -0500
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> Hi Steve,
> 
> With your ftrace/urgent branch linked above, if I try a quick
> function_graph test like the following:
> 
>   SYSFS=/sys/kernel/debug/tracing
> 
>   echo 0 > "$SYSFS/tracing_on"
>   echo cmdline_proc_show > "$SYSFS/set_graph_function"
>   echo function_graph > "$SYSFS/current_tracer"
>   echo 1 > "$SYSFS/tracing_on"
> 
> I see a bunch of scheduler interrupt functions in the trace/trace_pipe
> without even invoking cmdline_proc_show().
> 
> This tests works as expected with Linux 4.20-rc3 though:
> 
>   % cat /sys/kernel/debug/tracing/trace_pipe
>    2)               |  cmdline_proc_show() {
>    2)   0.320 us    |    seq_puts();
>    2)   0.030 us    |    seq_putc();
>    2)   1.352 us    |  }
> 
> Operator error, or did the patchset break something?

Nope, that does seem to be a bug :-/

-- Steve
