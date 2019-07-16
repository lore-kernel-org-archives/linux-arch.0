Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:55992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPObS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 10:31:18 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
Date: Tue, 16 Jul 2019 10:30:28 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <FDD00A3A-6938-40DE-B464-A56C641B4634@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190716143028.MvYNx3kiD9IF8Xo_Ma-4bFBxZYwRRW6XjlFbpWrgwfI@z>


> On Jul 16, 2019, at 7:05 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Jul 15, 2019 at 03:25:34PM -0400, Alex Kogan wrote:
>> +/**
>> + * find_successor - Scan the main waiting queue looking for the =
first
>> + * thread running on the same node as the lock holder. If found =
(call it
>> + * thread T), move all threads in the main queue between the lock =
holder
>> + * and T to the end of the secondary queue and return T; otherwise, =
return NULL.
>> + */
>> +static struct cna_node *find_successor(struct mcs_spinlock *me)
>=20
> Either don't use a kernel doc comment, but if you must, you have to
> stick to their format, otherwise we'll get endless stupid patches =
fixing
> up the stupid comment.
Will fix that.

Thanks,
=E2=80=94 Alex
