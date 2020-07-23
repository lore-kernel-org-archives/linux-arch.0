From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 00/13] "Task_isolation" mode
Date: Thu, 23 Jul 2020 23:44:24 +0200
Message-ID: <877dutx5xj.fsf@nanos.tec.linutronix.de>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com> <87imeextf3.fsf@nanos.tec.linutronix.de> <831e023422aa0e4cb3da37ceef6fdcd5bc854682.camel@marvell.com> <20200723154933.GB709@worktop.programming.kicks-ass.net> <3ff1383e669b543462737b0d12c0d1fb7d409e3e.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ff1383e669b543462737b0d12c0d1fb7d409e3e.camel@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Belits <abelits@marvell.com>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>, Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "frederic@kernel.org" <frederic@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Alex Belits <abelits@marvell.com> writes:
> On Thu, 2020-07-23 at 17:49 +0200, Peter Zijlstra wrote:
>> 
>> 'What does noinstr mean? and why do we have it" -- don't dare touch
>> the
>> entry code until you can answer that.
>
> noinstr disables instrumentation, so there would not be calls and
> dependencies on other parts of the kernel when it's not yet safe to
> call them. Relevant functions already have it, and I add an inline call
> to perform flags update and synchronization. Unless something else is
> involved, those operations are safe, so I am not adding anything that
> can break those.

Sure.

 1) That inline function can be put out of line by the compiler and
    placed into the regular text section which makes it subject to
    instrumentation

 2) That inline function invokes local_irq_save() which is subject to
    instrumentation _before_ the entry state for the instrumentation
    mechanisms is established.

 3) That inline function invokes sync_core() before important state has
    been established, which is especially interesting in NMI like
    exceptions.

As you clearly documented why all of the above is safe and does not
cause any problems, it's just me and Peter being silly, right?

Try again.

Thanks,

        tglx
