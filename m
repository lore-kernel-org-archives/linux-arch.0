From: Will Deacon <will.deacon@arm.com>
Subject: Re: arm: Request to preserve TPIDRURW per thread
Date: Tue, 22 Jan 2013 09:24:25 +0000
Message-ID: <20130122092424.GA12295@mudshark.cambridge.arm.com>
References: <50FDD7A8.1080402@dawncrow.de>
 <20130122001143.GA4107@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:57061 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750915Ab3AVJYh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Jan 2013 04:24:37 -0500
Content-Disposition: inline
In-Reply-To: <20130122001143.GA4107@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>

On Tue, Jan 22, 2013 at 12:11:43AM +0000, Greg KH wrote:
> On Tue, Jan 22, 2013 at 01:04:56AM +0100, Andr=E9 Hentschel wrote:
> > Hi,
> > that comes a bit late, but [1] asked for objections.
> > As you can see in [2] there are more and more applications coming t=
o WinRT, Wine could support them,
> > but mostly they expect to have the thread environment block (TEB) i=
n TPIDRURW.
> > This register must be preserved per thread and we have patches for =
that.
> >=20
> > Currently there exist two kernel behaviours:
> >=20
> > 1. the kernel does not touch TPIDRURW at all ("covert channel")
> > 2. the kernel clears TPIDRURW on thread switch
> >=20
> > Attached to [3] you'll find kernel patches you can freely use.
> > Permission and more info you'll find in [4].
> > Any hints or suggestions?
> >=20
> > [1] http://www.kernelhub.org/?p=3D2&msg=3D57979
> > [2] http://forum.xda-developers.com/showthread.php?t=3D2092348
> > [3] http://bugs.winehq.org/show_bug.cgi?id=3D31322
> > [4] http://bugs.winehq.org/show_bug.cgi?id=3D31308
>=20
> Please submit the patches to fix this in the way described in
> Documentation/SubmittingPatches.  Once they are in Linus's tree, I'll=
 be
> glad to take them in the stable tree if they meet the guidelines that
> are described in Documentation/stable_kernel_rules.txt.

Please also send them to linux-arm-kernel@lists.infradead.org, since th=
at's
the happening place for arch/arm/ and they'll likely get reviewed there=
=2E

Cheers,

Will
