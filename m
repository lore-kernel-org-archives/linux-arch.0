From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Mon, 10 Jan 2011 20:25:52 +0100
Message-ID: <20110110192552.GG24920@pengutronix.de>
References: <AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com>
 <1294426405.2929.23.camel@heimdal.trondhjem.org>
 <20110107190229.GX31708@n2100.arm.linux.org.uk>
 <1294427467.4895.66.camel@mulgrave.site>
 <1294505384.4181.14.camel@heimdal.trondhjem.org>
 <1294528551.4181.19.camel@heimdal.trondhjem.org>
 <20110110105019.GC24920@pengutronix.de>
 <1294676734.3349.10.camel@heimdal.trondhjem.org>
 <4D2B3D03.8050504@pengutronix.de>
 <1294680035.3349.19.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60045 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab1AJT0A (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2011 14:26:00 -0500
Content-Disposition: inline
In-Reply-To: <1294680035.3349.19.camel@heimdal.trondhjem.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arch@vger.kernel.org, linux-nfs@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Parisc List <linux-parisc@vger.kernel.org>, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, Linus Torvalds <torvalds@linux-foundation.org>, Marc Kleine-Budde <m.kleine-budde@pengutronix.de>, linux-arm-kernel@lists.infradead.org

Hello Trond,

On Mon, Jan 10, 2011 at 12:20:35PM -0500, Trond Myklebust wrote:
> On Mon, 2011-01-10 at 18:08 +0100, Marc Kleine-Budde wrote:=20
> > On 01/10/2011 05:25 PM, Trond Myklebust wrote:
> > > On Mon, 2011-01-10 at 11:50 +0100, Uwe Kleine-K=F6nig wrote:=20
> > >> Hi Trond,
> > >>
> > >> On Sat, Jan 08, 2011 at 06:15:51PM -0500, Trond Myklebust wrote:
> > >>> ---------------------------------------------------------------=
--------------------=20
> > >> It would be great if you could add a "8<" in the line above next=
 time.
> > >> Then git-am -c does the right thing (at least I think so).
> > >=20
> > > Sorry. I wasn't aware of that particular idiom. So something like
> > >=20
> > > 8<------------------------------------------------------------
> > > From: Trond Myklebust <Trond.Myklebust@netapp.com>
> > > Subject: .....
> >=20
> > Yes.
> >=20
> > From "man git-mailinfo":
> > "A line that mainly consists of scissors (either ">8" or "8<") and
> > perforation (dash "-")"
> >=20
> > BTW:
> > Is this patch a candidate for stable?
>=20
> Yes. I'm planning on sending it to the stable list after Linus merges=
 it
> into mainline.
So there is another idiom for you:  just put

	Cc: stable@kernel.org

in the S-o-b block and Greg will pick it off "automatically".  (Just in
case you don't know, and if you do, maybe someone else learned
something.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
