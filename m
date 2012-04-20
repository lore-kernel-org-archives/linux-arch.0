From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [patch 00/18] SMP: Boot and CPU hotplug refactoring - Part 1
Date: Fri, 20 Apr 2012 16:06:04 +0200
Message-ID: <CAFLxGvzgRpJq_BRrfgGh-V-k9XQmSvSN6hmK+6jm86Vy7v3EVg@mail.gmail.com>
References: <20120420122120.097464672@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120420122120.097464672@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 20, 2012 at 3:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> This converts all architectures except m32r, mn10300, tile and UM to
> the new core facility. These architecture are calling fork_idle() in
> the very early boot code in smp_prepare_cpus() for unknown reasons.
> I haven't analyzed yet, whether this is on purpose or can be moved
> over to the generic facility. It'd be nice if the responsible maintainers
> could look into that as well.

SMP is marked as broken on UM, so I don't have any objections. :-)

-- 
Thanks,
//richard
