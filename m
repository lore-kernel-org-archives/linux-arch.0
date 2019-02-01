Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:58160 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAV0h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Feb 2019 16:26:37 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 2/3] locking/qspinlock: Introduce CNA into the slow path
 of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <2c8aabab-1bb0-0708-94c4-305fd860609e@redhat.com>
Date: Fri, 1 Feb 2019 16:26:06 -0500
Content-Transfer-Encoding: quoted-printable
Message-ID: <62BE66CF-1CFA-4921-B2FF-70D5460845D6@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-3-alex.kogan@oracle.com>
 <2c8aabab-1bb0-0708-94c4-305fd860609e@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Message-ID: <20190201212606.83v1NMMzYwVTI3DQ9N6LqDaCs2K2qwKm3u-i6UIr5-8@z>


> On Jan 31, 2019, at 12:38 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 01/30/2019 10:01 PM, Alex Kogan wrote:
>> In CNA, spinning threads are organized in two queues, a main queue =
for
>> threads running on the same socket as the current lock holder, and a
>> secondary queue for threads running on other sockets. For details,
>> see =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DRdsRU4oU2j-_hNG5kDC5ZEE_XHikl3Q=
LNttCaBde3QU&s=3DNQ840S1lz53Cq7AnOlPWdnjZI7_Ic3rfYsf-w2aYus4&e=3D.
>>=20
>> Note that this variant of CNA may introduce starvation by =
continuously
>> passing the lock to threads running on the same socket. This issue
>> will be addressed later in the series.
>>=20
>> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>=20
> Just wondering if you have tried include PARVIRT_SPINLOCKS option to =
see
> if that patch may screw up the PV qspinlock code.
No, I haven=E2=80=99t yet.
The idea was to make it work for non-PV systems first, and then extend =
to PV.

>=20
> Anyway, I do believe your claim that NUMA-aware qspinlock is good for
> large systems with many nodes. However, all these extra code are
> overhead for small systems that have a single node/socket, for =
instance.
>=20
> I will support doing something similar to what had been done to =
support
> PV qspinlock. IOW, a separate slowpath function that can be patched to
> become the default depending on the system being run on or a kernel =
boot
> option setting.
>=20
> I would like to keep the core slowpath function simple and easy to
> understand. So most of the CNA code should be encapsulated into some
> helper functions and put into a separated file.
Sounds good.=20
I think it should be pretty straightforward to encapsulate the CNA code =
and do what you suggest.
We will look into that.

Thanks,
=E2=80=94 Alex

>=20
> Thanks,
> Longman
>=20
