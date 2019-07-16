Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44814 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPXHS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 19:07:18 -0400
Date: Wed, 17 Jul 2019 09:07:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/5] Add NUMA-awareness to qspinlock
References: <20190715192536.104548-1-alex.kogan@oracle.com>
        <1563277166.m9swqogbqb.astroid@bobo.none>
        <7D29555E-8F72-4EDD-8A87-B1A59C3945A6@oracle.com>
In-Reply-To: <7D29555E-8F72-4EDD-8A87-B1A59C3945A6@oracle.com>
MIME-Version: 1.0
Message-ID: <1563317552.qsi08y8lyr.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, bp@alien8.de, daniel.m.jordan@oracle.com, dave.dice@oracle.com, guohanjun@huawei.com, hpa@zytor.com, jglauber@marvell.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com, peterz@infradead.org, rahul.x.yadav@oracle.com, steven.sistare@oracle.com, tglx@linutronix.de, will.deacon@arm.com, x86@kernel.org
Message-ID: <20190716230709.dxbgfuPQnE6l3AfxuWyOYdxuuW-hL25g20vq336QYBs@z>

Alex Kogan's on July 17, 2019 12:45 am:
>=20
>> On Jul 16, 2019, at 7:47 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> Alex Kogan's on July 16, 2019 5:25 am:
>>> Our evaluation shows that CNA also improves performance of user=20
>>> applications that have hot pthread mutexes. Those mutexes are=20
>>> blocking, and waiting threads park and unpark via the futex=20
>>> mechanism in the kernel. Given that kernel futex chains, which
>>> are hashed by the mutex address, are each protected by a=20
>>> chain-specific spin lock, the contention on a user-mode mutex=20
>>> translates into contention on a kernel level spinlock.=20
>>=20
>> What applications are those, what performance numbers? Arguably that's
>> much more interesting than microbenchmarks (which are mainly useful to
>> help ensure the fast paths are not impacted IMO).
>=20
> Those are applications that use locks in which waiting threads can park (=
block),
> e.g., pthread mutexes. Under (user-level) contention, the park-unpark mec=
hanism
> in the kernel creates contention on (kernel) spin locks protecting futex =
chains.
> As an example, we experimented with LevelDB (key-value store), and includ=
ed
> performance numbers in the patch. Or you are looking for something else?

Oh, no that's good. I confused myself thinking that was another will it
scale benchmark. The speedup becomes significant on readrandom, I wonder
if of it might be that you're gating which threads get to complete the=20
futex operation and so the effect is amplified beyond just the critical
section of the spin lock?

Am I reading the table correctly, this test gets about 2.1x speedup when
scaling from 1 to 142 threads in the patch-CNA case?

Thanks,
Nick
=
