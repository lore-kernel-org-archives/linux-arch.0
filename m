Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267526AbUIOEhm@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:12194 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S267480AbUIOEhm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 00:37:42 -0400
Date: Wed, 15 Sep 2004 14:37:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: waitid fallout
Message-Id: <20040915143730.6b230fbc.sfr@canb.auug.org.au>
In-Reply-To: <20040915033903.GA904@twiddle.net>
References: <20040915033903.GA904@twiddle.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__15_Sep_2004_14_37_30_+1000_=Di7rYS5PNnd/DFH"
To: Richard Henderson <rth@twiddle.net>
Cc: roland@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__15_Sep_2004_14_37_30_+1000_=Di7rYS5PNnd/DFH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 14 Sep 2004 20:39:03 -0700 Richard Henderson <rth@twiddle.net> wrote:
>
> Is an *entire* struct rusage required in siginfo_t for sigchld?
> 
> It's much bigger than the 24 (!) words of padding we had reserved
> for expansion in siginfo_t.

On 64bit archs, at least.  This means that we break the ABI ...

> Which means that the size of siginfo_t changed, which means that
> any existing "sigwaitinfo ({ SIGCHLD }, &info)" will now corrupt
> user memory.  Perhaps we think no one does this, but we should
> at least be aware of the ABI change.
> 
> Alpha is not yet using a VDSO for the signal frame unwind info, so
> I noticed that all of my signal cancelation tests are now failing,
> because the layout of the signal frame changed.  Perhaps I'll take
> this opportunity to update, but it does require a rather coordinated
> kernel + libc upgrade in order to keep things working smoothly...

We cannot do this even with coordination, as some of the 64bit archs
ABIs have been Standardised in the LSB.

Unless, of course, we revise the ABI Specs as well ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__15_Sep_2004_14_37_30_+1000_=Di7rYS5PNnd/DFH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBR8cO4CJfqux9a+8RAoXbAJ9l2SYO4SpjAcGqjumY7PQl64bEFQCeKqWi
HervPBk+tomcfxtXcVHaDL0=
=vyaV
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Sep_2004_14_37_30_+1000_=Di7rYS5PNnd/DFH--
