From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
Date: Tue, 5 May 2015 18:15:58 +0100
Message-ID: <20150505171558.GO1550@arm.com>
References: <55464BB2.7030401@dawncrow.de>
 <20150505105111.GB1550@arm.com>
 <5548F965.9070302@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5548F965.9070302@dawncrow.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>, Catalin Marinas <Catalin.Marinas@arm.com>
List-Id: linux-arch.vger.kernel.org

On Tue, May 05, 2015 at 06:09:57PM +0100, Andr=C3=A9 Hentschel wrote:
> Am 05.05.2015 um 12:51 schrieb Will Deacon:
> > On Sun, May 03, 2015 at 05:24:18PM +0100, Andr=C3=A9 Hentschel wrot=
e:
> >> From: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
> >>
> >> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user wri=
teable TLS
> >> register on ARM is preserved per thread.
> >>
> >> This patch does it analogous to the ARM patch, but for compat mode=
 on ARM64.
> >>
> >> Signed-off-by: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: Jonathan Austin <jonathan.austin@arm.com>=20
> >>
> >> ---
> >> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f4038136=
41efa74a031)
> >=20
> > Curious, but why do you need this? iirc, we added this for arch/arm=
/ because
> > of some windows rt (?) emulation in wine. Is that still the case he=
re and is
> > anybody actually using that?
>=20
> Yes, Windows ARM binaries are the well known use case, but also the c=
ompat
> mode should do what the arm kernel is doing I=E2=80=99d think and the=
 code wasn't
> adjusted yet.

Sure, I was just curious.

> What i'm curious about is why the main TLS register on arm64 is the u=
ser
> writeable, I'm not an security expert but this looks odd. I could eas=
ily
> provoke a crash by writing to it...

You've probably got the wrong TLS. Allowing a program to clobber it's o=
wn
thread-local storage is no worse than allowing it to write to its gener=
al
purpose registers, pc, etc.

I'm assuming the crash you saw was just a userspace crash, rather than
the kernel?

Will
