From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 1/2] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Thu, 01 Aug 2013 23:46:24 +0530
Message-ID: <51FAA5F8.2070209@linux.vnet.ibm.com>
References: <1375324631-32868-1-git-send-email-Waiman.Long@hp.com> <1375324631-32868-2-git-send-email-Waiman.Long@hp.com> <20130801094029.GK3008@twins.programming.kicks-ass.net> <51FAA1C3.2050507@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51FAA1C3.2050507@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <waiman.long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Richard Weinberger <richard@nod.at>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matt Fleming <matt.fleming@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Akinobu Mita <akinobu.mita@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, George Spelvin <linux@horizon.com>, Harvey Harrison <harv>
List-Id: linux-arch.vger.kernel.org

On 08/01/2013 11:28 PM, Waiman Long wrote:
> On 08/01/2013 05:40 AM, Peter Zijlstra wrote:
>> On Wed, Jul 31, 2013 at 10:37:10PM -0400, Waiman Long wrote:
>>
[...]
>>
>>> +         */
>>> +        for (qn_idx = 1; qn_idx<  MAX_QNODES; qn_idx++) {
>>> +            if (!node[qn_idx].used)
>>> +                break;
>>         }
>>
>>> +        if (unlikely(qn_idx == MAX_QNODES)) {
>>> +            /*
>>> +             * This shouldn't happen, print a warning message
>>> +             *&  busy spinning on the lock.
>>> +             */
>>> +            pr_warn("qspinlock: queue node table exhausted at "
>>> +                "cpu %d!\n", cpu_nr);
>> This could make your machine die hard.. not all contexts can printk().
>
> Do you have any suggestion? I could skip the warning and silently do the
> busy spinning. I just want some way to notify the user of this rare event.

We have used debugfs in pv-spinlock to avoid that since printk uses
spinlock again. may be it will help to profile many other parts of
code too.
