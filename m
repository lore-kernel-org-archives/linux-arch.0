Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:19692 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1946058AbWKAHYQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2006 02:24:16 -0500
Date: Wed, 1 Nov 2006 18:23:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Message-Id: <20061101182352.c35b41ba.sfr@canb.auug.org.au>
In-Reply-To: <20061030230210.041531ea.akpm@osdl.org>
References: <20061028223730.GC3243@athena.road.mcmartin.ca>
	<20061030155910.GC13625@athena.road.mcmartin.ca>
	<20061030230210.041531ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__1_Nov_2006_18_23_52_+1100_2QbEUhrfCVF1W7n."
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__1_Nov_2006_18_23_52_+1100_2QbEUhrfCVF1W7n.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2006 23:02:10 -0800 Andrew Morton <akpm@osdl.org> wrote:
>
> On Mon, 30 Oct 2006 10:59:10 -0500
> Kyle McMartin <kyle@parisc-linux.org> wrote:
>
> > [N.B. the modification to powerpc is probably wrong, since it seems
> >  to require a wrapper for handling the signed ints like sparc64 and s390
> >  have. -- Kyle]
>
> Well that's a bit sad.  Could the ppc guys please take a look?

It will be fine.  Neither of the passed ints have valid negative values.
The original comment was overly zealous.

However it would be nice to not have "32" in the names of gerneic compat
functions i.e. call it copy_compat_siginfo_from_user or
get_compat_siginfo.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__1_Nov_2006_18_23_52_+1100_2QbEUhrfCVF1W7n.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFSEuOFdBgD/zoJvwRAmYDAJ9/ckKeGIL80LTAspRT0GntPYTpkACeKtKW
nnDNh8hiVQ6XKlahcbkarkU=
=Gjim
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Nov_2006_18_23_52_+1100_2QbEUhrfCVF1W7n.--
