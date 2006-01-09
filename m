Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:46314 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751634AbWAIXh6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2006 18:37:58 -0500
Date: Tue, 10 Jan 2006 10:37:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: sys_pciconfig_{read,write}
Message-Id: <20060110103733.5d0bcdef.sfr@canb.auug.org.au>
In-Reply-To: <20060109162718.GP19769@parisc-linux.org>
References: <20060109162718.GP19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__10_Jan_2006_10_37_33_+1100_mtAiF_NUYMNzV9hf"
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, cneira@srb.cl
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Tue__10_Jan_2006_10_37_33_+1100_mtAiF_NUYMNzV9hf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jan 2006 09:27:18 -0700 Matthew Wilcox <matthew@wil.cx> wrote:
>
> I bet most people don't even know we have these syscalls.  But they're
> built into every arch except X86, and only hooked up on alpha, arm,
> ia64, ppc32, sparc and sparc64.

and ppc64 ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Jan_2006_10_37_33_+1100_mtAiF_NUYMNzV9hf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDwvPCFdBgD/zoJvwRApi2AJ41aD7D/7Jy8Tp/8K6YYq4I752XagCfS7t6
p0JcQrnGxdPIu/mcF1QIlOI=
=8zBK
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jan_2006_10_37_33_+1100_mtAiF_NUYMNzV9hf--
