Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:49228 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfGQRp4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 13:45:56 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <2a7a3ea8-7a94-52d4-b8ef-581de28e0063@redhat.com>
Date: Wed, 17 Jul 2019 13:44:28 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <10197432-47E5-49D7-AD68-8A412782012B@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
 <aa73b86d-902a-bb6f-d372-8645c8299a6d@redhat.com>
 <C1C55A40-FDB1-43B5-B551-F9B8BE776DF8@oracle.com>
 <2a7a3ea8-7a94-52d4-b8ef-581de28e0063@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717174428.mgpfgJ13dmCmBZuoHYGxbLqKx-M7xjNh97fVn44j0MA@z>


> On Jul 16, 2019, at 10:50 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 7/16/19 10:29 AM, Alex Kogan wrote:
>>=20
>>> On Jul 15, 2019, at 7:22 PM, Waiman Long <longman@redhat.com
>>> <mailto:longman@redhat.com>> wrote:
>>>=20
>>> On 7/15/19 5:30 PM, Waiman Long wrote:
>>>>> -#ifndef _GEN_PV_LOCK_SLOWPATH
>>>>> +#if !defined(_GEN_PV_LOCK_SLOWPATH) && =
!defined(_GEN_CNA_LOCK_SLOWPATH)
>>>>>=20
>>>>> #include <linux/smp.h>
>>>>> #include <linux/bug.h>
>>>>> @@ -77,18 +77,14 @@
>>>>> #define MAX_NODES	4
>>>>>=20
>>>>> /*
>>>>> - * On 64-bit architectures, the mcs_spinlock structure will be 16 =
bytes in
>>>>> - * size and four of them will fit nicely in one 64-byte =
cacheline. For
>>>>> - * pvqspinlock, however, we need more space for extra data. To =
accommodate
>>>>> - * that, we insert two more long words to pad it up to 32 bytes. =
IOW, only
>>>>> - * two of them can fit in a cacheline in this case. That is OK as =
it is rare
>>>>> - * to have more than 2 levels of slowpath nesting in actual use. =
We don't
>>>>> - * want to penalize pvqspinlocks to optimize for a rare case in =
native
>>>>> - * qspinlocks.
>>>>> + * On 64-bit architectures, the mcs_spinlock structure will be 20 =
bytes in
>>>>> + * size. For pvqspinlock or the NUMA-aware variant, however, we =
need more
>>>>> + * space for extra data. To accommodate that, we insert two more =
long words
>>>>> + * to pad it up to 36 bytes.
>>>>> */
>>>> The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as =
the
>>>> mcs_spinlock structure is 8-byte aligned. For better cacheline
>>>> alignment, I will like to keep mcs_spinlock to 16 bytes as before.
>>>> Instead, you can use encode_tail() to store the CNA node pointer in
>>>> "locked". For instance, use (encode_tail() << 1) in locked to
>>>> distinguish it from the regular locked=3D1 value.
>>>=20
>>> Actually, the encoded tail value is already shift left either 16 =
bits
>>> or 9 bits. So there is no need to shift it. You can assigned it =
directly:
>>>=20
>>> mcs->locked =3D cna->encoded_tail;
>>>=20
>>> You do need to change the type of locked to "unsigned int", though,
>>> for proper comparison with "1".
>>>=20
>> Got it, thanks.
>>=20
> I forgot to mention that I would like to see a boot command line =
option
> to force off and maybe on as well the numa qspinlock code. This can =
help
> in testing as you don't need to build 2 separate kernels, one with
> NUMA_AWARE_SPINLOCKS on and one with it off.
IIUC it should be easy to add a boot option to force off the NUMA-aware =
spinlock=20
even if it is enabled though config, but the other way around would =
require=20
compiling in the NUMA-aware spinlock stuff even if the config option is =
disabled.
Is that ok?

Also, what should the option name be?
"numa_spinlock=3Don/off=E2=80=9D if we want both ways, or =
=E2=80=9Cno_numa_spinlock" if we want just the =E2=80=9Cforce off=E2=80=9D=
 option?

> For small 2-socket systems,
> numa qspinlock may not help much.
It actually helps quite a bit (e.g., speedup of up to 42-57% for =
will-it-scale on a dual-socket x86 system).
We have numbers and plots in our paper on arxiv.

Regards,
=E2=80=94 Alex
