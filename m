From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC] change non-atomic bitops method
Date: Tue, 3 Feb 2015 20:10:38 +0100
Message-ID: <20150203191038.GF10842@pengutronix.de>
References: <20150202193154.GC10842@pengutronix.de>
 <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <30242.1422976483@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58681 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965698AbbBCTKp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 14:10:45 -0500
Content-Disposition: inline
In-Reply-To: <30242.1422976483@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

Hello,

[added some more context again]

On Tue, Feb 03, 2015 at 03:14:43PM +0000, David Howells wrote:
> > > -     *p  |=3D mask;
> > > +     if ((*p & mask) =3D=3D 0)
> > > +             *p  |=3D mask;
> > Care to fix the double space here while touching the code?
> >=20
> > I think the more natural check here is:
> >=20
> >         if ((~*p & mask) !=3D 0)
> >                 *p |=3D mask;
> >
> > Might be a matter of taste, but this check is equivalent to
> >=20
> > 	*p !=3D (*p | mask)
> >=20
> > which is what you really want to test for.
> I would argue that this is less clear as to what's going on.
OK, I admit that this equivalence is not obvious. Then maybe let the
compiler find the equivalence and do:

-	*p  |=3D mask;
+	if (*p !=3D (*p | mask))
+		p |=3D mask;

?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
