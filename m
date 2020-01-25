Return-Path: <SRS0=zFKq=3O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29044 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729660AbgAYAjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:00 -0500
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
 <693E6287-E37C-4C5D-BE33-B3D813BE505D@oracle.com>
 <edc53126-bfe4-5102-d2eb-2332bf3a68e5@redhat.com>
 <D39064BF-6EF3-4C13-B2D1-34C282A20F5E@oracle.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <518185c1-c03a-7e8c-9d09-f67e42c9bc82@redhat.com>
Date: Fri, 24 Jan 2020 19:38:50 -0500
MIME-Version: 1.0
In-Reply-To: <D39064BF-6EF3-4C13-B2D1-34C282A20F5E@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com
Message-ID: <20200125003850.Vw9E3VI0LUOXJ7Yq22YH6_ZDP-Dr3tJxKgCiErNMuAA@z>

On 1/24/20 4:27 PM, Alex Kogan wrote:
>
>> On Jan 24, 2020, at 4:12 PM, Waiman Long <longman@redhat.com> wrote:
>>
>> On 1/24/20 3:09 PM, Alex Kogan wrote:
>>>>> We also probably do not want those =E2=80=9Cprioritized=E2=80=9D th=
reads to disrupt
>>>>> normal
>>>>> CNA operation. E.g., if the main queue looks like T1_1, P2_1, T1_2,
>>>>> =E2=80=A6, where
>>>>> T1_x is a thread running on node 1 and P2_1 is a prioritized thread
>>>>> running
>>>>> on node 2, we want to pass the lock from T1_1 to P2_1 and then to T=
1_2
>>>>> (rather than have P2_1 to scan for another thread on node 2).
>>>>>
>>>>> There is a way to achieve that =E2=80=94 when we pass the lock to P=
2_1,
>>>>> we can set its numa node field to 1. This means that we need to
>>>>> reset the numa
>>>>> node field in cna_init_node(), but AFAICT this is relatively cheap.
>>>>> The rest
>>>>> of the CNA logic should not change.
>>>> I won't recommend doing that. If the lock cacheline has been moved
>>>> from node 1 to 2, I will say it is better to stick with node 2 rathe=
r
>>>> than switching back to node 1. That will mean that the secondary
>>>> queue may contain lock waiters from the same nodes, but they will
>>>> eventually be flushed back to the primary queue.
>>>>
>>> That=E2=80=99s right, assuming we do not reset intra_node count when
>>> transferring the
>>> lock to a prioritized thread from another node. Otherwise, we may sta=
rve
>>> waiters in the secondary queue.=20
>>>
>>> Still, that can make the lock even less fair to non-prioritized
>>> threads. When
>>> you flush the secondary queue, the preference may remain with the sam=
e
>>> node. This will not happen in the current form of CNA, as we never ge=
t=20
>>> threads from the preferred node in the secondary queue.
>> That is true.
>>
>> However, it is no different from the current scheme that a waiter from
>> another node may have to wait for 64k other waiters to go first before
>> it has a chance to get it. Now that waiter can be from the same node a=
s
>> well.
> The difference is that in the current form of CNA, the preferred node _=
will
> change after 64k lock transitions. In the change you propose, this is n=
o
> longer the case. It may take another ~64k transitions for that to happe=
n.
> More generally, I think this makes the analysis of the lock behavior mo=
re
> convoluted.
>
> I think we should treat those prioritized threads as =E2=80=9Cwild=E2=80=
=9D cards, passing the=20
> lock through them, but keeping the preferred node intact. This will pot=
entially
> cost one extra lock migration, but will make reasoning about the lock
> behavior easier.

It seems like you prefer mathematical purity than practical
consideration. I won't object to that if you insist that is the right
way to go. Just be mindful that you may need to add a preferred node
value to do that. It will also complicate the code, but it is your choice=
.

Cheers,
Longman
