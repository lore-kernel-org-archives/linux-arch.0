From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Date: Thu, 29 Nov 2018 11:17:08 -0500
Message-ID: <20181129111708.766f35d6@gandalf.local.home>
References: <20181122002801.501220343@goodmis.org>
        <20181128203931.ym2rkya7a6agzzy3@redhat.com>
        <20181128160021.09acd1af@gandalf.local.home>
        <20181128222936.74da7f54@vmware.local.home>
        <20181128232430.425f8b12@vmware.local.home>
        <044db9c0-a937-252f-b9e6-e4060bca3b0d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <044db9c0-a937-252f-b9e6-e4060bca3b0d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 29 Nov 2018 10:08:55 -0500
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> With the "take 2" patch, I only see smp_irq_work_interrupt() graph when
> the graph_function is in progress..  for example:

In other words it works :-)

Can I get a Tested-by from you?

-- Steve
