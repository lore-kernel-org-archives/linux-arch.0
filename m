Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:57700 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfFDXWl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2019 19:22:41 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190403160112.GK4038@hirez.programming.kicks-ass.net>
Date: Tue, 4 Jun 2019 19:21:13 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de, hpa@zytor.com, x86@kernel.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Message-ID: <20190604232113.a2i9EEjezkSg7dm_tfZNW7iVUSVsw8-m-edTvpL7Ito@z>

Hi, Peter, Longman,=20

> On Apr 3, 2019, at 12:01 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Apr 03, 2019 at 11:39:09AM -0400, Alex Kogan wrote:
>=20
>>>> The patch that I am looking for is to have a separate
>>>> numa_queued_spinlock_slowpath() that coexists with
>>>> native_queued_spinlock_slowpath() and
>>>> paravirt_queued_spinlock_slowpath(). At boot time, we select the =
most
>>>> appropriate one for the system at hand.
>> Is this how this selection works today for paravirt?
>> I see a PARAVIRT_SPINLOCKS config option, but IIUC you are talking =
about a different mechanism here.
>> Can you, please, elaborate or give me a link to a page that explains =
that?
>=20
> Oh man, you ask us to explain how paravirt patching works... that's
> magic :-)
>=20
> Basically, the compiler will emit a bunch of indirect calls to the
> various pv_ops.*.* functions.
>=20
> Then, at alternative_instructions() <- apply_paravirt() it will =
rewrite
> all these indirect calls to direct calls to the function pointers that
> are in the pv_ops structure at that time (+- more magic).
Trying to resume this work, I am looking for concrete steps required to =
integrate CNA with the paravirt patching.

Looking at alternative_instructions(), I wonder if I need to add another =
call, something like apply_numa() similar to apply_paravirt(), and do =
the patch work there.
Or perhaps I should =E2=80=9Cjust" initialize the pv_ops structure with =
the corresponding numa_queued_spinlock_slowpath() in paravirt.c?

Also, the paravirt code is under arch/x86, while CNA is generic (not =
x86-specific).
Do you still want to see CNA-related patching residing under arch/x86?

We still need a config option (something like NUMA_AWARE_SPINLOCKS) to =
enable CNA patching under this config only, correct?

Thanks in advance,
=E2=80=94 Alex
