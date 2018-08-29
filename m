From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Wed, 29 Aug 2018 21:16:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:=0A=
> Hi Guys,=0A=
> Since v4.19-rc1 we are getting a serious regression on platforms with ARC=
 architecture.=0A=
> The kernel have become unstable and spontaneously crashes on LTP tests ex=
ecution / IO tests or=0A=
> even on boot.=0A=
>=0A=
> I don't know exactly what breaks but bisect clearly assign the blame to t=
his commit:=0A=
> 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using =
atomic_fetch_*()")=0A=
> https://github.com/torvalds/linux/commit/84c6591103dbeaf393a092a3fc7b0951=
0825f6b9=0A=
>=0A=
> Reverting the commit solves this problem.=0A=
>=0A=
> I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) wh=
ich uses same=0A=
> generic bitops implementation and it works fine.=0A=
>=0A=
> Do you have any ideas what went wrong?=0A=
=0A=
Back in 2016, Peter had fixed this file due to a problem I reported on ARC.=
 See=0A=
commit f75d48644c56a ("bitops: Do not default to __clear_bit() for=0A=
__clear_bit_unlock()")=0A=
That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic=0A=
__clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock=
() same.=0A=
=0A=
This patch undoes that which could explain the issues you see. @Peter, @Wil=
l ?=0A=
=0A=
-Vineet=0A=
