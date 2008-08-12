From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
Date: Tue, 12 Aug 2008 16:43:52 +1000
Message-ID: <20080812164352.ddcf1ef5.sfr@canb.auug.org.au>
References: <200808111606.44103.arnd@arndb.de>
	<200808111618.08206.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:37604 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbYHLGoD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Aug 2008 02:44:03 -0400
In-Reply-To: <200808111618.08206.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, David Woodhouse <dwmw2@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@ozlabs.org

--Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, 11 Aug 2008 16:18:07 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> +#ifdef CONFIG_MODULES
> +.macro __EXPORT_SYMBOL sym section symtab strtab
> +	.section \section,"a",@progbits
> +	.type \symtab, @object
> +	.ifeq BITS_PER_LONG-32
> +	.align 3
> +\symtab:
> +	.long \sym
> +	.long \strtab
> +	.else
> +	.align 4

This won't be portable across architectures as .align is sometimes in
bytes and sometimes a power of two.  You can use .balign or .p2align
portably on gas, though.=20

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkihMSgACgkQjjKRsyhoI8z1NgCdE+5N8sLRvEyit8oSyDlvgFDC
A1QAoLW3fr0aR/zWgq/v5nbXOSHaCWv4
=jmEu
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o--
