From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] arm: Preserve TPIDRURW on context switch
Date: Mon, 22 Apr 2013 16:18:37 +0100
Message-ID: <20130422151836.GA15665@mudshark.cambridge.arm.com>
References: <517168BB.3070903@dawncrow.de>
 <20130422143616.GP14496@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62596 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753263Ab3DVPSz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Apr 2013 11:18:55 -0400
Content-Disposition: inline
In-Reply-To: <20130422143616.GP14496@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

On Mon, Apr 22, 2013 at 03:36:16PM +0100, Russell King - ARM Linux wrot=
e:
> On Fri, Apr 19, 2013 at 05:54:35PM +0200, Andr=E9 Hentschel wrote:
> > From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.d=
e>
> >=20
> > There are more and more applications coming to WinRT, Wine could su=
pport them,
> > but mostly they expect to have the thread environment block (TEB) i=
n TPIDRURW.
> > This register must be preserved per thread instead of being cleared=
=2E
> >=20
> > Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
>=20
> This actually makes things less efficient all round, because you
> now use the value immediately after loading, which means it will caus=
e
> pipeline stalls, certainly on older CPUs.
>=20
> Could you please rework the patch to try avoiding soo many modificati=
ons
> to the way things have been done here?

copy_thread also needs updating so that the *register* value for the pa=
rent
is copied to the child, since the parent may have written the register
after the last context-switch, meaning that tp_value is out-of-date.

Will
