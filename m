Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:38334 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDPb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 23:15:31 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
Date: Wed, 3 Apr 2019 23:14:49 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <C74425B5-3006-4721-8BEF-55E86830C13D@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, dave.dice@oracle.com, rahul.x.yadav@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Message-ID: <20190404031449.ux0qaqz7wcxXvy_YkEUWTLydgJDXkZKOzHpqw8db8ls@z>

Hi, Hanjun.=20

> On Apr 3, 2019, at 10:02 PM, Hanjun Guo <guohanjun@huawei.com> wrote:
>=20
> Hi Alex,
>=20
> On 2019/3/29 23:20, Alex Kogan wrote:
>> +
>> +static __always_inline void cna_init_node(struct mcs_spinlock *node, =
int cpuid,
>> +					  u32 tail)
>> +{
>> +	if (decode_numa_node(node->node_and_count) =3D=3D -1)
>> +		store_numa_node(node, numa_cpu_node(cpuid));
>=20
> How about using cpu_to_node() here and #include <linux/topology.h> in =
this
> file, then the code can be reused for other architectures such as =
ARM64?
Good point. Thanks!

=E2=80=94 Alex

>=20
> Thanks
> Hanjun
>=20
