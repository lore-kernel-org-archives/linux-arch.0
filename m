Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfDDFFa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Apr 2019 01:05:30 -0400
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
Date: Thu, 4 Apr 2019 07:05:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190403160112.GK4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Alex Kogan <alex.kogan@oracle.com>
Cc: Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190404050524.LTSqoV0kOiRUJYUWhYr1chN1KjwY2YtNXsCA2hWZUNs@z>

On 03/04/2019 18:01, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 11:39:09AM -0400, Alex Kogan wrote:
> 
>>>> The patch that I am looking for is to have a separate
>>>> numa_queued_spinlock_slowpath() that coexists with
>>>> native_queued_spinlock_slowpath() and
>>>> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
>>>> appropriate one for the system at hand.
>> Is this how this selection works today for paravirt?
>> I see a PARAVIRT_SPINLOCKS config option, but IIUC you are talking about a different mechanism here.
>> Can you, please, elaborate or give me a link to a page that explains that?
> 
> Oh man, you ask us to explain how paravirt patching works... that's
> magic :-)
> 
> Basically, the compiler will emit a bunch of indirect calls to the
> various pv_ops.*.* functions.
> 
> Then, at alternative_instructions() <- apply_paravirt() it will rewrite
> all these indirect calls to direct calls to the function pointers that
> are in the pv_ops structure at that time (+- more magic).
> 
> So we initialize the pv_ops.lock.* methods to the normal
> native_queued_spin*() stuff, if KVM/Xen/whatever setup detectors pv
> spnlock support changes the methods to the paravirt_queued_*() stuff.
> 
> If you wnt more details, you'll just have to read
> arch/x86/include/asm/paravirt*.h and arch/x86/kernel/paravirt*.c, I
> don't think there's a coherent writeup of all that.
> 
>>> Agreed; and until we have static_call, I think we can abuse the paravirt
>>> stuff for this.
>>>
>>> By the time we patch the paravirt stuff:
>>>
>>>  check_bugs()
>>>    alternative_instructions()
>>>      apply_paravirt()
>>>
>>> we should already have enumerated the NODE topology and so nr_node_ids()
>>> should be set.
>>>
>>> So if we frob pv_ops.lock.queued_spin_lock_slowpath to
>>> numa_queued_spin_lock_slowpath before that, it should all get patched
>>> just right.
>>>
>>> That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
>>> PARAVIRT_SPINLOCK, which is a bit awkward…
> 
>> Just to mention here, the patch so far does not address paravirt, but
>> our goal is to add this support once we address all the concerns for
>> the native version.  So we will end up with four variants for the
>> queued_spinlock_slowpath() — one for each combination of
>> native/paravirt and NUMA/non-NUMA.  Or perhaps we do not need a
>> NUMA/paravirt variant?
> 
> I wouldn't bother with a pv version of the numa aware code at all. If
> you have overcommitted guests, topology is likely irrelevant anyway. If
> you have 1:1 pinned guests, they'll not use pv spinlocks anyway.
> 
> So keep it to tertiary choice:
> 
>  - native
>  - native/numa
>  - paravirt

Just for the records: the paravirt variant could easily choose whether
it wants to include a numa version just by using the existing hooks.
With PARAVIRT_SPINLOCK configured I guess even the native case would
need to use the paravirt hooks for selection of native or native/numa.

Without PARAVIRT_SPINLOCK this would be just an alternative() then?

Maybe the resulting code would be much more readable if we'd just
make PARAVIRT_SPINLOCK usable without the other PARAVIRT hooks? So
splitting up PARAVIRT into PARAVIRT_GUEST (timer hooks et al) and
the patching infrastructure, with PARAVIRT_GUEST and PARAVIRT_SPINLOCK
selecting PARAVIRT, and PARAVIRT_XXL selecting PARAVIRT_GUEST.


Juergen
