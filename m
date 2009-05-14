From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 01/15] asm-generic: rename termios.h, signal.h and
 mman.h
Date: Thu, 14 May 2009 15:11:07 +1000
Message-ID: <20090514151107.5eae120e.sfr@canb.auug.org.au>
References: <1242255398-23779-1-git-send-email-arnd@arndb.de>
	<1242255398-23779-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__14_May_2009_15_11_07_+1000_q4TDPuzzw9cHuhuM"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:53054 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbZENFLP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 May 2009 01:11:15 -0400
In-Reply-To: <1242255398-23779-2-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, Sam Ravnborg <sam@ravnborg.org>

--Signature=_Thu__14_May_2009_15_11_07_+1000_q4TDPuzzw9cHuhuM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, 13 May 2009 22:56:24 +0000 Arnd Bergmann <arnd@arndb.de> wrote:
>
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -2,9 +2,9 @@ header-y +=3D errno-base.h
>  header-y +=3D errno.h
>  header-y +=3D fcntl.h
>  header-y +=3D ioctl.h
> -header-y +=3D mman.h
> +header-y +=3D mman-common.h
>  header-y +=3D poll.h
> -header-y +=3D signal.h
> +header-y +=3D signal-defs.h
>  header-y +=3D statfs.h

I think that this change will prevent asm/mman.h and asm/signal.h from
being exported from the arch include/asm directories.
include/asm-generic/Kbuild is included by the arch/*/include/asm/Kbuild
files.

Maybe Sam (cc'd) could comment.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__14_May_2009_15_11_07_+1000_q4TDPuzzw9cHuhuM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoLp+sACgkQjjKRsyhoI8ybsQCeOdg6pAXxNKHa3s3MFsuPKHgQ
ScwAoKFwP0MPdVV+4vw6IDd4Dw/dGr1c
=PYX6
-----END PGP SIGNATURE-----

--Signature=_Thu__14_May_2009_15_11_07_+1000_q4TDPuzzw9cHuhuM--
