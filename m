From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v4 1/3] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Tue, 18 Feb 2014 14:31:34 -0500
Message-ID: <5303B516.3080409@hp.com>
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com> <1392669684-4807-2-git-send-email-Waiman.Long@hp.com> <20140218073326.GX27965@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140218073326.GX27965@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
List-Id: linux-arch.vger.kernel.org

On 02/18/2014 02:33 AM, Peter Zijlstra wrote:
> On Mon, Feb 17, 2014 at 03:41:22PM -0500, Waiman Long wrote:
>> +#define	_QCODE(lock)	(atomic_read(&(lock)->qlcode)>>  _QCODE_OFFSET)
>> +#define	_QLOCK(lock)	(atomic_read(&(lock)->qlcode)&  _QSPINLOCK_LOCKED)
>> +#define GET_QN_IDX(code)	(((code)>>  _QCODE_VAL_OFFSET)&  3)
>> +#define GET_CPU_NR(code)	(((code)>>  (_QCODE_VAL_OFFSET + 2)) - 1)
>> +#ifndef _SET_QCODE
>> +#define _SET_QCODE(cpu, idx)	((((cpu) + 1)<<  (_QCODE_VAL_OFFSET + 2)) |\
>> +				((idx)<<  _QCODE_VAL_OFFSET) |\
>
> Someone please take the CPP away.. dude most this doesn't need to be a
> macro. Its used only in 1 or two places and its utterly unreadable.

Yes, I can take them away. It is not a big problem.

-Longman
