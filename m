From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v3 1/2] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Fri, 31 Jan 2014 13:28:06 -0500
Message-ID: <52EBEB36.9090102@hp.com>
References: <1390933151-1797-1-git-send-email-Waiman.Long@hp.com> <1390933151-1797-2-git-send-email-Waiman.Long@hp.com> <20140130193539.GL5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:6019 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558AbaAaS2M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jan 2014 13:28:12 -0500
In-Reply-To: <20140130193539.GL5002@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On 01/30/2014 02:35 PM, Peter Zijlstra wrote:
> On Tue, Jan 28, 2014 at 01:19:10PM -0500, Waiman Long wrote:
>> This patch introduces a new queue spinlock implementation that can
>> serve as an alternative to the default ticket spinlock. Compared with
>> the ticket spinlock, this queue spinlock should be almost as fair as
>> the ticket spinlock. It has about the same speed in single-thread and
>> it can be much faster in high contention situations. Only in light to
>> moderate contention where the average queue depth is around 1-2 will
>> this queue spinlock be potentially a bit slower due to the higher
>> slowpath overhead.
> But light to moderate contention should be the most common case. If your
> spinlock is very heavily contended, it should be broken up.
>
> I would really like more performance numbers for this on single and dual
> socket machines and 'normal' workloads (ha! as if those exist), ie.
> kbuild is all very important to us :-)

Yes, I am planning to get more performance data on low end machines. The 
v3 patch was sent out to spur discussion on this topic while I am trying 
to get more data.

-Longman
