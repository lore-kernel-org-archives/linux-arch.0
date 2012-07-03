Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50235 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754298Ab2GCLsq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 07:48:46 -0400
Date: Tue, 3 Jul 2012 12:48:44 +0100
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Message-ID: <20120703114844.GJ29030@opensource.wolfsonmicro.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au>
 <20120703101209.GH29030@opensource.wolfsonmicro.com>
 <201207031116.05876.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
In-Reply-To: <201207031116.05876.arnd@arndb.de>
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120703114844.91G9wG6Do6h9wXDyfo8UgsRlGdeWqdoDFNHw8jnrMO8@z>


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 11:16:05AM +0000, Arnd Bergmann wrote:
> On Tuesday 03 July 2012, Mark Brown wrote:

> > No idea, I'm just taking the existing default header and making it more
> > generally available.

> I prefer Stephen's version because that maintains the type checking.

I agree, I've already made the change locally.

> However, that is not a controversial point at all IMHO. The question
> that we need to decide on is whether we want automatic "generic-y"
> statements in Kbuild.asm.

Well, it does seem to defeat a large part of the point of having generic
headers if they're not there by default - it means that if you add a
header you need to go round every single architecture adding the header
explicitly which is cumbersome and annoying, especially with the less
actively maintained architectures.  On the other hand if you do things
without adding a generic header then people whine about not using the
generic header mechanism...

> I would definitely prefer being able to just write=20

> generic-y +=3D clkdev.h=20

I agree but I don't see this as something that should block having the
facility.  Or if it does I guess I'll need to try to either fix clkdev
to use the arch include optionally or go round all the architectures
either of which is going to be needlessly painful.

> Maybe Michal Marek or someone on the kbuild mailing list can help
> out with a solution for that.

We could do that incrementally...

The reason I'm doing this is that the lack of a widely available clock
API is a considerable pain point for a lot of the stuff I work on and
this is the major blocker to just enabling the default implementation on
architectures that don't support it already which would be a big step
forwards.

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8twUAAoJEBus8iNuMP3dEccP/jpo8pI2fFMTFlHKD+MjOS2U
R52sHENpRoq8afV5Aazr8Q48zjht0EhKOBXFH/451MFL2IULEhi0GP/Vg3f+ygaJ
1JJZ6XFybV7ew46sinZbpw2iWGZEf+2F6bGzimp3zJHW39g9Eai2LvTNKCw1BkzW
v5x+F63nLyjsb1v85q+9ek9dLSs8hToqrwTBCjRbPD1sOY6xUlTCd2HngD6e1r1F
b3DgNP745drFM1C4KqQ4Epfdwk+dGfR7g8DPSVoy7HG7Agn+bggz6NqVLe817ln+
aZTqoYlHg8RYXx/aP/ELcuunUoptM/tlJQ0QQdNtBi2AsgnK677gshR4DD3GZssQ
reJGfeva0BB255a+ONTFoAsgNUZVtv0b4XzjyVxVLcDhRDXW1AaJUT9FHcstHDRO
zzD3PEOiyCw1JEMN8Rn49z5DJSsEiVc9lphA7+RbSxWzbzrdsMUBVxSZM60iO8Rz
ukVh64cFF60yjhkrZ96NQH/BKotOOlTSSjmx3CFcsF6aWp7C9anldcj6y0Te4KoV
7LsrN5QDNWr2/ZOx3zz6iYV2b+SfKoCaczBTvaPvyXzEG7Bubnuqw8N/k2eByDSG
HkPAtN4Jhcg/sB+sHhwMp+qRelgqYhN/4lGwpY1RbAEj//AMIngBwtZX5Rqxadjx
HHeEOigvl/7pimz0hPrk
=001g
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
