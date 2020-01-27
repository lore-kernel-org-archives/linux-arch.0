From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Date: Mon, 27 Jan 2020 01:04:45 -0500
Message-ID: <FB96E148-C72B-4D00-95F0-C4B69A3EE454@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
 <20200125045844.GC2935@paulmck-ThinkPad-P72>
 <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
 <20200126153535.GL2935@paulmck-ThinkPad-P72>
 <20200126224245.GA22901@paulmck-ThinkPad-P72>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:46458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0GGV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 01:06:21 -0500
In-Reply-To: <20200126224245.GA22901@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org
Cc: Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com



> On Jan 26, 2020, at 5:42 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Sun, Jan 26, 2020 at 07:35:35AM -0800, Paul E. McKenney wrote:
>> On Sat, Jan 25, 2020 at 02:41:39PM -0500, Waiman Long wrote:
>>> On 1/24/20 11:58 PM, Paul E. McKenney wrote:
>>>> On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
>>>>> On 1/24/20 8:59 PM, Waiman Long wrote:
>>>>>>> You called it!  I will play with QEMU's -numa argument to see if =
I can get
>>>>>>> CNA to run for me.  Please accept my apologies for the false =
alarm.
>>>>>>>=20
>>>>>>> 							Thanx, =
Paul
>>>>>>>=20
>>>>>> CNA is not currently supported in a VM guest simply because the =
numa
>>>>>> information is not reliable. You will have to run it on baremetal =
to
>>>>>> test it. Sorry for that.
>>>>> Correction. There is a command line option to force CNA lock to be =
used
>>>>> in a VM. Use the "numa_spinlock=3Don" boot command line parameter.
>>>> As I understand it, I need to use a series of -numa arguments to =
qemu
>>>> combined with the numa_spinlock=3Don (or =3D1) on the kernel =
command line.
>>>> If the kernel thinks that there is only one NUMA node, it appears =
to
>>>> avoid doing CNA.
>>>>=20
>>>> Correct?
>>>>=20
>>>> 							Thanx, Paul
>>>>=20
>>> In auto-detection mode (the default), CNA will only be turned on =
when
>>> paravirt qspinlock is not enabled first and there are at least 2 =
numa
>>> nodes. The "numa_spinlock=3Don" option will force it on even when =
both of
>>> the above conditions are false.
>>=20
>> Hmmm...
>>=20
>> Here is my kernel command line taken from the console log:
>>=20
>> console=3DttyS0 locktorture.onoff_interval=3D0 numa_spinlock=3Don =
locktorture.stat_interval=3D15 locktorture.shutdown_secs=3D1800 =
locktorture.verbose=3D1
>>=20
>> Yet the string "Enabling CNA spinlock" does not appear.
>>=20
>> Ah, idiot here needs to enable CONFIG_NUMA_AWARE_SPINLOCKS in his =
build.
>> Trying again with "--kconfig "CONFIG_NUMA_AWARE_SPINLOCKS=3Dy"...
>=20
> And after fixing that, plus adding the other three Kconfig options =
required
> to enable this, I really do see "Enabling CNA spinlock" in the console =
log.
> Yay!
Great! Your persistence paid off :)

Yet, CNA does not do much interesting here, as it sees only one numa =
node.

>=20
> At the end of the 30-minute locktorture exclusive-lock run, I see =
this:
>=20
> Writes:  Total: 572176565  Max/Min: 54167704/10878216 ???  Fail: 0
>=20
> This is about a five-to-one ratio.  Is this expected behavior, given a
> single NUMA node on a single-socket system with 12 hardware threads?
I=E2=80=99m not sure what is expected here.
I=E2=80=99m guessing that if you boot your guest with the default=20
(non-CNA/non-paravirt) qspinlock, you will get a similar result.

>=20
> I will try reader-writer lock next.
>=20
> Again, should I be using qemu's -numa command-line option to create =
nodes?
> If so, what would be a sane configuration given 12 CPUs and 512MB of
> memory for the VM?  If not, what is a good way to exercise CNA's NUMA
> capabilities within a guest OS?
That=E2=80=99s a good question. Perhaps Longman knows the answer?

Regards,
=E2=80=94 Alex=
