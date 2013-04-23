From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] arm: Preserve TPIDRURW on context switch
Date: Tue, 23 Apr 2013 10:15:36 +0100
Message-ID: <20130423091536.GB17593@mudshark.cambridge.arm.com>
References: <517168BB.3070903@dawncrow.de>
 <20130422143616.GP14496@n2100.arm.linux.org.uk>
 <20130422151836.GA15665@mudshark.cambridge.arm.com>
 <5175A697.3080308@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5175A697.3080308@dawncrow.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 22, 2013 at 10:07:35PM +0100, Andr=E9 Hentschel wrote:
> Am 22.04.2013 17:18, schrieb Will Deacon:
> > On Mon, Apr 22, 2013 at 03:36:16PM +0100, Russell King - ARM Linux =
wrote:
> >> On Fri, Apr 19, 2013 at 05:54:35PM +0200, Andr=E9 Hentschel wrote:
> >>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow=
=2Ede>
> >>>
> >>> There are more and more applications coming to WinRT, Wine could =
support them,
> >>> but mostly they expect to have the thread environment block (TEB)=
 in TPIDRURW.
> >>> This register must be preserved per thread instead of being clear=
ed.
> >>>
> >>> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
> >>
> >> This actually makes things less efficient all round, because you
> >> now use the value immediately after loading, which means it will c=
ause
> >> pipeline stalls, certainly on older CPUs.
> >>
> >> Could you please rework the patch to try avoiding soo many modific=
ations
> >> to the way things have been done here?
> >=20
> > copy_thread also needs updating so that the *register* value for th=
e parent
> > is copied to the child, since the parent may have written the regis=
ter
> > after the last context-switch, meaning that tp_value is out-of-date=
=2E
>=20
> Thank you both for reviewing.
>=20
> I guess you mostly mean "ldr	r6, [r2, #TI_CPU_DOMAIN]".
> I just thought about old CPUs and remembered again that we at Wine
> need that patch only on v7 (and later). So is it ok to introduce a se=
t_tls_v7
> in tls.h and make use of CONFIG_CPU_V7 compile-time check in
> the changed files and in the copy_thread function?

No, we should support this feature on any CPU with the TPIDRURW registe=
r,
otherwise it's going to get really confusing for userspace.

> Do i need any further flag checks in copy_thread or can i use the
> compile-time check to add unconditional code?

You could introduce `get' tls functions, which don't do anything for CP=
Us
without the relevant registers.

Will
