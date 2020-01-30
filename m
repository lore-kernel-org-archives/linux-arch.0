From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Thu, 30 Jan 2020 17:05:28 -0500
Message-ID: <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
References: <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:37734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 17:06:34 -0500
In-Reply-To: <20200125111931.GW11457@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com


> On Jan 25, 2020, at 6:19 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Jan 24, 2020 at 01:19:05PM -0500, Alex Kogan wrote:
>=20
>> Is there a lightweight way to identify such a =E2=80=9Cprioritized=E2=80=
=9D thread?
>=20
> No; people might for instance care about tail latencies between their
> identically spec'ed worker tasks.

I would argue that those users need to tune/reduce the intra-node =
handoff
threshold for their needs. Or disable CNA altogether.

In general, Peter, seems like you are not on board with the way Longman
suggested to handle prioritized threads. Am I right?

Thanks,
=E2=80=94 Alex
