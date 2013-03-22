From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [patch 34/34] xtensa: Use generic idle loop
Date: Fri, 22 Mar 2013 16:37:45 +0400
Message-ID: <CAMo8BfLQSieZpUvWL=yLDh4KgM1LboWRy79_MKbOW38nw_Q8tw@mail.gmail.com>
References: <20130321214930.752934102@linutronix.de>
	<20130321215235.546600507@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130321215235.546600507@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Zankel <chris@zankel.net>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 22, 2013 at 1:53 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Unfortunately this arch does not compile at all :(

Hi Thomas,

according to KISSKB http://kisskb.ellerman.id.au/kisskb/compiler/19/
it does, you probably don't need to build allmodconfig.

With this patch I see WARN coming from the kernel/cpu/idle.c:94,
xtensa __platform_idle returns with interrupts enabled.
Interestingly, even the default arch_cpu_idle does so.

-- 
Thanks.
-- Max
