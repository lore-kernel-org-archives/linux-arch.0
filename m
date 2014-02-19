From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 0/3] qspinlock: Introducing a 4-byte queue spinlock
Date: Wed, 19 Feb 2014 12:17:15 -0800
Message-ID: <CA+55aFwyVgLJq2OgKZBK7g+T5-_M4o+dnEAr+qtYxA5t_=HSvA@mail.gmail.com>
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com>
	<53029167.4060109@zytor.com>
	<20140218073111.GW27965@twins.programming.kicks-ass.net>
	<5303B4C4.2040907@hp.com>
	<20140218212827.GR14089@laptop.programming.kicks-ass.net>
	<5303FDEC.9060001@hp.com>
	<20140219085107.GG27965@twins.programming.kicks-ass.net>
	<53050501.3070101@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53050501.3070101@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <waiman.long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 19, 2014 at 11:24 AM, Waiman Long <waiman.long@hp.com> wrote:
>
> We do have a CONFIG_PARAVIRT macro that turns on or off PV support. The
> queue spinlock can be easily changed into an unfair lock which allows lock
> stealing. We could have a config option to make it unfair in the PARAVIRT
> environment, but I don't think Linus like the idea of an unfair lock.

I could care less for the paravirt case. As long as the native case
ends up being sane (even when CONFIG_PARAVIRT is set at compile time),
I'm fine.

When actually running in a paravirtualized environment, locks are
always going to have problems.

                  Linus
