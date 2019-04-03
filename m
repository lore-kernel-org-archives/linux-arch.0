Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:51290 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCPlL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 11:41:11 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190402094320.GM11158@hirez.programming.kicks-ass.net>
Date: Wed, 3 Apr 2019 11:39:09 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190403153909.McxubI4p7TX52YoFb2CUv7B2y8f7Hg5tlrc9oxaLoDo@z>

Peter, Longman, many thanks for your detailed comments!

A few follow-up questions are inlined below.

> On Apr 2, 2019, at 5:43 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
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
>>> +	  trading some of the short term fairness for better =
performance.
>>> +
>>> +	  Say N if you want absolute first come first serve fairness.
>>> +
>>=20
>> The patch that I am looking for is to have a separate
>> numa_queued_spinlock_slowpath() that coexists with
>> native_queued_spinlock_slowpath() and
>> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
>> appropriate one for the system at hand.
Is this how this selection works today for paravirt?
I see a PARAVIRT_SPINLOCKS config option, but IIUC you are talking about =
a different mechanism here.
Can you, please, elaborate or give me a link to a page that explains =
that?

>=20
> Agreed; and until we have static_call, I think we can abuse the =
paravirt
> stuff for this.
>=20
> By the time we patch the paravirt stuff:
>=20
>  check_bugs()
>    alternative_instructions()
>      apply_paravirt()
>=20
> we should already have enumerated the NODE topology and so =
nr_node_ids()
> should be set.
>=20
> So if we frob pv_ops.lock.queued_spin_lock_slowpath to
> numa_queued_spin_lock_slowpath before that, it should all get patched
> just right.
>=20
> That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
> PARAVIRT_SPINLOCK, which is a bit awkward=E2=80=A6
Just to mention here, the patch so far does not address paravirt, but =
our goal is to add this support once we address all the concerns for the =
native version.
So we will end up with four variants for the queued_spinlock_slowpath() =
=E2=80=94 one for each combination of native/paravirt and NUMA/non-NUMA.
Or perhaps we do not need a NUMA/paravirt variant?

=E2=80=94 Alex
