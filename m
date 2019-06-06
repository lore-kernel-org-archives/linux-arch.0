Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:36368 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFPXe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2019 11:23:34 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190605204003.GC3402@hirez.programming.kicks-ass.net>
Date: Thu, 6 Jun 2019 11:21:48 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <6426D627-77EE-471C-B02A-A85271B666E9@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
 <20190605204003.GC3402@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de, hpa@zytor.com, x86@kernel.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Message-ID: <20190606152148.naNDyC6wj8nPl5QzE-z0c21Wj8ddOTd2R2saB6Dcst4@z>

>> Also, the paravirt code is under arch/x86, while CNA is generic (not
>> x86-specific).  Do you still want to see CNA-related patching =
residing
>> under arch/x86?
>>=20
>> We still need a config option (something like NUMA_AWARE_SPINLOCKS) =
to
>> enable CNA patching under this config only, correct?
>=20
> There is the static_call() stuff that could be generic; I posted a new
> version of that today (x86 only for now, but IIRC there's arm64 =
patches
> for that around somewhere too).

The static_call technique appears as the more desirable long-term =
approach, but I think it would be prudent to keep the patches decoupled =
for now so we can move forward with less entanglements.
So unless anyone objects, we will work on plugging into the existing =
patching for pv.
And we will keep that code under arch/x86, but will be open for any =
suggestion to move it elsewhere.

Thanks!
=E2=80=94 Alex
