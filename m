Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:38254 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCPyO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 11:54:14 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190401093345.GA14281@hirez.programming.kicks-ass.net>
Date: Wed, 3 Apr 2019 11:53:53 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <20190401090653.GF11158@hirez.programming.kicks-ass.net>
 <20190401093345.GA14281@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190403155353.TD8LSXUTq_YxkieX2i7BtYoqUHshh0xqu4Vv7KvdKdg@z>


> On Apr 1, 2019, at 5:33 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Apr 01, 2019 at 11:06:53AM +0200, Peter Zijlstra wrote:
>> On Fri, Mar 29, 2019 at 11:20:04AM -0400, Alex Kogan wrote:
>>> diff --git a/kernel/locking/mcs_spinlock.h =
b/kernel/locking/mcs_spinlock.h
>>> index bc6d3244e1af..71ee4b64c5d4 100644
>>> --- a/kernel/locking/mcs_spinlock.h
>>> +++ b/kernel/locking/mcs_spinlock.h
>>> @@ -17,8 +17,18 @@
>>>=20
>>> struct mcs_spinlock {
>>> 	struct mcs_spinlock *next;
>>> +#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
>>> 	int locked; /* 1 if lock acquired */
>>> 	int count;  /* nesting count, see qspinlock.c */
>>> +#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
>>> +	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values =
*/
>>> +			  /* represent a pointer to the secondary queue =
head */
>>> +	u32 node_and_count;	/* node id on which this thread is =
running */
>>> +				/* with two lower bits reserved for =
nesting */
>>> +				/* count, see qspinlock.c */
>>> +	u32 encoded_tail; /* encoding of this node as the main queue =
tail */
>>> +	struct mcs_spinlock *tail;    /* points to the secondary queue =
tail */
>>> +#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
>>> };
>>=20
>> Please, have another look at the paravirt code, in particular at =
struct
>> pv_node and its usage. This is horrible.
>=20
> Thing is, this turns into a right mess when you also have PV spinlocks
> on.
>=20
> One thing we could maybe do is change locked and count to u8, then =
your
> overlay structure could be something like:
>=20
> struct mcs_spinlock {
> 	struct mcs_spinlock *next;
> 	u8 locked;
> 	u8 count;
> };
I was trying to keep the size of the mcs_spinlock structure for the =
non-NUMA variant unchanged.
If this is not a huge concern, changing the fields as above would indeed =
simplify a few things.

=E2=80=94 Alex=20

>=20
> struct cna_node {
> 	/* struct mcs_spinlock overlay */
> 	struct mcs_spinlock *next;
> 	u8 locked;
> 	u8 count;
>=20
> 	/* our CNA bits, consuming the slack and PV space */
> 	u16 node;
> 	u32 encoded_tail;
> 	struct mcs_spinlock *head;
> 	struct mcs_spinlock *tail;
> };
>=20
> Then you also don't need the first two patches.
