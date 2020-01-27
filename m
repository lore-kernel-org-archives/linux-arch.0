From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Date: Mon, 27 Jan 2020 01:16:36 -0500
Message-ID: <3CBCD208-0859-458E-8A89-96E8E9A98664@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
 <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:56656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0GRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 01:17:12 -0500
In-Reply-To: <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lihao Liang <lihaoliang@google.com>
Cc: linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, Will Deacon <will@kernel.org>


>>> This is particularly relevant
>>> in high contention situations when new threads keep arriving on the =
same
>>> socket as the lock holder.
>> In this case, the lock will stay on the same NUMA node/socket for
>> 2^numa_spinlock_threshold times, which is the worst case scenario if =
we
>> consider the long-term fairness. And if we have multiple nodes, it =
will take
>> up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
>> lock transitions until any given thread will acquire the lock
>> (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
>>=20
>=20
> You're right that the latest version of the patch handles long-term =
fairness
> deterministically.
>=20
> As I understand it, the n-th thread in the main queue is guaranteed to
> acquire the lock after N lock handovers, where N is bounded by
>=20
> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
>=20
> I'm not sure what role the variable nr_cpus_per_node plays in your =
analysis.

Yeah, that=E2=80=99s a minor point, but let me try to clarify.

The "n-th thread in the main queue=E2=80=9D is (at most) the =
nr_cpus_per_node-th thread=20
for some node k. So when the node k gets the preference, that thread =
will
get the lock after at most nr_cpus_per_node-1 lock transitions. As we =
consider
the upper bound, your analysis is also correct; mine is just a bit =
tighter.

Makes sense?

Regards,
=E2=80=94 Alex
