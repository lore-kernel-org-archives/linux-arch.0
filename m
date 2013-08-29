From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [gcv v3 06/35] scheduler: Replace __get_cpu_var uses
Date: Thu, 29 Aug 2013 14:30:53 -0400
Message-ID: <20130829143053.3fc2caa8@gandalf.local.home>
References: <20130828193457.140443630@linux.com>
	<00000140c67817eb-b582280a-f059-499f-a24c-a11f3d59b86e-000000@email.amazonses.com>
	<20130829075818.GW10002@twins.programming.kicks-ass.net>
	<20130829100143.GA29672@gmail.com>
	<00000140cb02576f-e106763c-d382-4b66-bb85-d7a9cb266b81-000000@email.amazonses.com>
	<20130829173256.GB6276@home.goodmis.org>
	<00000140cb49bdde-1279ffb0-5c49-400d-970c-a481d527e98a-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00000140cb49bdde-1279ffb0-5c49-400d-970c-a481d527e98a-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Thu, 29 Aug 2013 18:15:43 +0000
Christoph Lameter <cl@linux.com> wrote:

> On Thu, 29 Aug 2013, Steven Rostedt wrote:
> 
> Its not really an atomic operation in the classic sense.

It doesn't need to be atomic, it could mean it is used within atomic
locations. Basically, "can't be interrupted here". I just said
"something like", it didn't even need to be that.

> 
> this_cpu_no_preempt_check_read ?

I would make it much shorter. You could use "raw_this_cpu_read()",
which usually means "no checks here". Or, "this_cpu_read_nopreempt()".

> 
> The problem that I have is also that a kernel with preemption is not
> something that see anywhere these days. Looks more like an academic
> exercise? Does this really matter? All the distro I see use

Um, my paycheck depends on PREEMPT_RT working. And there's a lot of
interest in real PREEMPT by audio folks. It's no more an
academic exercise than people wanting really low kernel latency.

> PREEMPT_VOLUNTARY. Performance degradation is significant if massive
> amounts of checks and preempt disable/enable points are added to the
> kernel.

They are usually disabled for production systems. But we run a bunch of
tests with the debug checks enabled, which catch bugs before we ship a
kernel for a production system.

> 
> Do we agree that it is necessary and useful to add another variant of
> this_cpu ops for this? The concern of having too many variants is no
> longer there? Adding another variant is not that difficult just code
> intensive.

How many places use the this_cpu_*() without preemption disabled? I
wouldn't think there's many. I never complained about another variant,
so you need to ask those that have. The tough question for me is what
that variant name should be ;-)

-- Steve
