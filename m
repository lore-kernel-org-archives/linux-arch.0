From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 0/3] qspinlock: Introducing a 4-byte queue spinlock
Date: Wed, 19 Feb 2014 12:39:29 +0530
Message-ID: <530458A9.1090603@linux.vnet.ibm.com>
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com> <53029167.4060109@zytor.com> <20140218073111.GW27965@twins.programming.kicks-ass.net> <5303B4C4.2040907@hp.com> <20140218212827.GR14089@laptop.programming.kicks-ass.net> <5303FDEC.9060001@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:55971 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbaBSHDh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2014 02:03:37 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <raghavendra.kt@linux.vnet.ibm.com>;
	Wed, 19 Feb 2014 17:03:35 +1000
In-Reply-To: <5303FDEC.9060001@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On 02/19/2014 06:12 AM, Waiman Long wrote:
> On 02/18/2014 04:28 PM, Peter Zijlstra wrote:
>> On Tue, Feb 18, 2014 at 02:30:12PM -0500, Waiman Long wrote:
>>> I will start looking at how to make it work with paravirt. Hopefully, it
>>> won't take too long.
>> The cheap way out is to simply switch to the test-and-set spinlock on
>> whatever X86_FEATURE_ indicates a guest I suppose.
>
> I don't think there is X86_FEATURE flag that indicates running in a
> guest. In fact, a guest should never find out if it is running virtualized.
>
> After reading the current PV ticketlock implementation, I have a rough
> idea of what I need to do to implement PV support in qspinlock. A large
> portion of PV ticketlock code is find out the CPU number of the next one
> to get the lock. The current qspinlock implementation has already
> included CPU number of the previous member in the queue and it should be
> pretty easy to store CPU number of the next one in the queue node
> structure. These CPU numbers can then be supplied to the kick_cpu()
> function to schedule in the require the CPU to make sure that progress
> can be made.

That is correct.
Strict serialization of the lock is usually a headache for virtualized
guest (especially when overcommitted). I am eager to test the next
version.
