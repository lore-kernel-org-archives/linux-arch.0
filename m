From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 2/5] do_div(): generic optimization for constant divisor on 32-bit machines
Date: Wed, 04 Nov 2015 21:42:58 +0000
Message-ID: <yw1xoaf97865.fsf@unicorn.mansr.com>
References: <201511031333.Yk9ngQZJ%fengguang.wu@intel.com>
	<21544300.LSjO3j3Xy7@wuerfel>
	<alpine.LFD.2.20.1511041542130.630@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1511041542130.630@knanqh.ubzr> (Nicolas Pitre's
	message of "Wed, 4 Nov 2015 16:04:57 -0500 (EST)")
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Nicolas Pitre <nicolas.pitre@linaro.org> writes:

> On Tue, 3 Nov 2015, Arnd Bergmann wrote:
>
>> On Tuesday 03 November 2015 13:32:17 kbuild test robot wrote:
>> >=20
>> >    net/can/bcm.c: In function 'bcm_proc_show':
>> > >> net/can/bcm.c:223:1: warning: the frame size of 1156 bytes is l=
arger than 1024 bytes [-Wframe-larger-than=3D]
>> >     }
>>=20
>> Interesting, that is a lot of stack for a function that only has a c=
ouple
>> of local variables:
>>=20
>> #define IFNAMSIZ        16
>>         char ifname[IFNAMSIZ];
>>         struct sock *sk =3D (struct sock *)m->private;
>>         struct bcm_sock *bo =3D bcm_sk(sk);
>>         struct bcm_op *op;
>>=20
>>=20
>> This is a parisc-allyesconfig kernel, so I assume that CONFIG_PROFIL=
E_ALL_BRANCHES
>> is on, which instruments every 'if' in the kernel. If that causes pr=
oblems,
>> we could decide to disable the do_div optimization whenever CONFIG_P=
ROFILE_ALL_BRANCHES
>> is enabled.
>
> I have an ARM allyesconfig build here where that function needs a fra=
me=20
> of 88 bytes only. And that is with my do_div optimization applied.
>
> With the do_div optimization turned off, the stack frame is still 88=20
> bytes.
>
> Turning on CONFIG_PROFILE_ALL_BRANCHES makes the frame size to grow t=
o=20
> 96 bytes.
>
> Keeping CONFIG_PROFILE_ALL_BRANCHES=3Dy and activating the do_div=20
> optimization again, and the function frame size goes back to 88 bytes=
=2E
>
> So I wonder what parisc gcc could be doing with this code.

I've seen parisc gcc do many strange things.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
