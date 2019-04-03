Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDCQdX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Apr 2019 12:33:23 -0400
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
Date: Wed, 3 Apr 2019 12:33:20 -0400
MIME-Version: 1.0
In-Reply-To: <20190402094320.GM11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190403163320.tIrylwmb0jTHgEw-UVRZSH-iZKFMSjM3snlSeRES8as@z>

On 04/02/2019 05:43 AM, Peter Zijlstra wrote:
> On Mon, Apr 01, 2019 at 10:36:19AM -0400, Waiman Long wrote:
>> On 03/29/2019 11:20 AM, Alex Kogan wrote:
>>> +config NUMA_AWARE_SPINLOCKS
>>> +	bool "Numa-aware spinlocks"
>>> +	depends on NUMA
>>> +	default y
>>> +	help
>>> +	  Introduce NUMA (Non Uniform Memory Access) awareness into
>>> +	  the slow path of spinlocks.
>>> +
>>> +	  The kernel will try to keep the lock on the same node,
>>> +	  thus reducing the number of remote cache misses, while
>>> +	  trading some of the short term fairness for better performance.
>>> +
>>> +	  Say N if you want absolute first come first serve fairness.
>>> +
>> The patch that I am looking for is to have a separate
>> numa_queued_spinlock_slowpath() that coexists with
>> native_queued_spinlock_slowpath() and
>> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
>> appropriate one for the system at hand.
> Agreed; and until we have static_call, I think we can abuse the paravirt
> stuff for this.

I haven't checked Josh's patch to see if it is doing. The availability
of static_call will certainly make thing easier for this case.

> By the time we patch the paravirt stuff:
>
>   check_bugs()
>     alternative_instructions()
>       apply_paravirt()
>
> we should already have enumerated the NODE topology and so nr_node_ids()
> should be set.
>
> So if we frob pv_ops.lock.queued_spin_lock_slowpath to
> numa_queued_spin_lock_slowpath before that, it should all get patched
> just right.
>
> That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
> PARAVIRT_SPINLOCK, which is a bit awkward...

Yes, this is one way of doing it. Another way to use static key to
switch between the native and numa version. So if PARAVIRT_SPINLOCK is
defined, we use the paravirt patching to point to the right function. If
PARAVIRT_SPINLOCK isn't enabled, we can do something like

static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32
val)
{
        if (static_branch_unlikely(&use_numa_spinlock))
                numa_queued_spin_lock_slowpath(lock, val);
        else   
                native_queued_spin_lock_slowpath(lock, val);
}

Alternatively, we can also call numa_queued_spin_lock_slowpath() in
native_queued_spin_lock_slowpath() if we don't want to increase the code
size of spinlock call sites.

Cheers,
Longman
