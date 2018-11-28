Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeK2Hma (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Nov 2018 02:42:30 -0500
Date: Wed, 28 Nov 2018 15:39:31 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Message-ID: <20181128203931.ym2rkya7a6agzzy3@redhat.com>
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122002801.501220343@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Message-ID: <20181128203931.OHYmK_TIAvrCX8u81LFR_F5Lt-TerMcexd8SBBClngw@z>

On Wed, Nov 21, 2018 at 07:28:01PM -0500, Steven Rostedt wrote:
>
> [ ... snip ... ]
>
> Feel free to test this! I'll be pushing this to linux-next and let it
> sit there a week or so before pushing it to Linus.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/urgent

Hi Steve,

With your ftrace/urgent branch linked above, if I try a quick
function_graph test like the following:

  SYSFS=/sys/kernel/debug/tracing

  echo 0 > "$SYSFS/tracing_on"
  echo cmdline_proc_show > "$SYSFS/set_graph_function"
  echo function_graph > "$SYSFS/current_tracer"
  echo 1 > "$SYSFS/tracing_on"

I see a bunch of scheduler interrupt functions in the trace/trace_pipe
without even invoking cmdline_proc_show().

This tests works as expected with Linux 4.20-rc3 though:

  % cat /sys/kernel/debug/tracing/trace_pipe
   2)               |  cmdline_proc_show() {
   2)   0.320 us    |    seq_puts();
   2)   0.030 us    |    seq_putc();
   2)   1.352 us    |  }

Operator error, or did the patchset break something?

Regards,

-- Joe
