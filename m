From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] bitops: fix signedness of compile-time hweight
 implementations
Date: Wed, 22 Jan 2014 18:47:54 +0100
Message-ID: <20140122174754.GS31570@twins.programming.kicks-ass.net>
References: <alpine.DEB.2.02.1312180459580.30198@tamien>
 <alpine.DEB.2.02.1401221718500.4071@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35852 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbaAVRsN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2014 12:48:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1401221718500.4071@utopia.booyaka.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Walmsley <pwalmsley@nvidia.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 22, 2014 at 05:19:58PM +0000, Paul Walmsley wrote:
> Hi Peter, hpa, Arnd,
>=20
> On Wed, 18 Dec 2013, Paul Walmsley wrote:
>=20
> >=20
> > Enabling '-Wsign-compare' compiler warnings on code that includes
> > include/linux/bitops.h can generate the following warning:
> >=20
> > In file included from include/linux/kernel.h:10:0,
> >                  from <random filename>:48:
> > include/linux/bitops.h: In function =E2=80=98hweight_long=E2=80=99:
> > include/linux/bitops.h:77:26: error: signed and unsigned type in co=
nditional
> > expression [-Werror=3Dsign-compare]
> >=20
> > (converted to an error with -Werror)
> >=20
> > This is due to the use of the logical negation operator '!' in the
> > __const_hweight8 macro in include/asm-generic/bitops/const_hweight.=
h.
> > The use of that operator here results in a signed value.
> >=20
> > Fix by explicitly casting the __const_hweight8 macro expansion to
> > 'unsigned int'.  While here, clean up several checkpatch.pl warning=
s.
> >=20
> > Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Intended for v3.14.
>=20
> Ping.  Just checking to see if you have any comments on this one, or =
if=20
> you're planning to send it upstream for v3.14.

I'm not sure through which tree to send it, but just I've queued it so
it doesn't get lost again.

Also, it didn't apply as is for some reason, hit it on the head with a
hammer though.
