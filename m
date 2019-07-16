Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46483 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfGPLre (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 07:47:34 -0400
Date: Tue, 16 Jul 2019 21:47:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/5] Add NUMA-awareness to qspinlock
References: <20190715192536.104548-1-alex.kogan@oracle.com>
In-Reply-To: <20190715192536.104548-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Message-ID: <1563277166.m9swqogbqb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, arnd@arndb.de, bp@alien8.de, guohanjun@huawei.com, hpa@zytor.com, jglauber@marvell.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de, will.deacon@arm.com, x86@kernel.org
Cc: daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com, steven.sistare@oracle.com
Message-ID: <20190716114727.L9SRK51Svt2lDwjh_KPwSpMtaSP1qmNlf9fC-WjHHeE@z>

Alex Kogan's on July 16, 2019 5:25 am:
> Our evaluation shows that CNA also improves performance of user=20
> applications that have hot pthread mutexes. Those mutexes are=20
> blocking, and waiting threads park and unpark via the futex=20
> mechanism in the kernel. Given that kernel futex chains, which
> are hashed by the mutex address, are each protected by a=20
> chain-specific spin lock, the contention on a user-mode mutex=20
> translates into contention on a kernel level spinlock.=20

What applications are those, what performance numbers? Arguably that's
much more interesting than microbenchmarks (which are mainly useful to
help ensure the fast paths are not impacted IMO).

Thanks,
Nick
=
