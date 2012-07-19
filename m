From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] Make most arch asm/module.h files use asm-generic/module.h [ver #2]
Date: Thu, 19 Jul 2012 09:30:13 -0400
Message-ID: <201207190930.16560.vapier@gentoo.org>
References: <20105.1342623053@warthog.procyon.org.uk> <31321.1342698046@warthog.procyon.org.uk> <20120719130703.GA17751@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4184560.sfx1yJpsId";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54050 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab2GSN3u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2012 09:29:50 -0400
In-Reply-To: <20120719130703.GA17751@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: David Howells <dhowells@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>, uclinux-dist-devel@blackfin.uclinux.org

--nextPart4184560.sfx1yJpsId
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 July 2012 09:07:03 Fengguang Wu wrote:
> On Thu, Jul 19, 2012 at 12:40:46PM +0100, David Howells wrote:
> > David Howells <dhowells@redhat.com> wrote:
> > > +static inline int apply_relocate(Elf_Shdr *sechdrs,
> > > +				 const char *strtab,
> > > +				 unsigned int symindex,
> > > +				 unsigned int relsec,
> > > +				 struct module *me)
> > > +{
> > > +	pr_err("module %s: REL relocation unsupported\n", me->name);
> > > +	return -ENOEXEC;
> > > +}
> >=20
> > Turns out you cannot use pr_err() and friends in a header file, lest it
> > get included in a file that defines pr_fmt() to be something
> > inconvenient.
> >=20
> > Thanks to Fengguang and his GIT tree cruncher for finding this in
> > Blackfin with the BF526-EZBRD_defconfig.
>=20
> For completeness, here are the error messages and David's comments:
> >> In file included from arch/blackfin/kernel/module.c:9:0:
> >> include/linux/moduleloader.h: In function 'apply_relocate':
> >> include/linux/moduleloader.h:48:2: error: 'mod' undeclared (first use =
in
> >> this function) include/linux/moduleloader.h:48:2: note: each undeclared
> >> identifier is reported only once for each function it appears in
> >
> >pr_err() is the problem.  If you're in a file that defines pr_fmt then it
> >will
> >
> >use that.  At the top of arch/blackfin/kernel/module.c:
> >        #define pr_fmt(fmt) "module %s: " fmt, mod->name
> >
> >I guess you can't use pr_err() in header files.

if it were "mod" instead of "me" in the variable list, i imagine it'd compi=
le=20
OK ;)
=2Dmike

--nextPart4184560.sfx1yJpsId
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQCAvoAAoJEEFjO5/oN/WBBf4P/19HP+zhtdv5iicYjGZh8vj5
BVmo3lFfghx097xrg75BcE5/eTwtz/aftvBq+eBzl4CUTavHGcP3jNy92NNX1L3d
MB6ADl9EV63UaLOmb2rAAiVdnh/TN1ZROfHxl7odf45ekKD3xfTdhMJqEekmWiTd
fEapAwq0lO7O5x8PV1lJl6MIXY1qABN5Ao6TP000Ox77XXw120KYLaCnb04e8ZIz
WSeMui7omZxvX78XabLLQ8orMvF+NtvoEkh05PolctVfdCCWBLl6QEmIpHaBsH5z
ktJjbMsWSiFCdJ2mA93mJCuT3LozDYqU2VB7IXk0dh3ee1oDzK6srLXWmwnQgdL4
4CbbCyfRP2uOxiS6Iwn1BZoscfTlKlFAxATQtsOuxUSMmPM1QZSz/K0hjVmV7Vjp
Obkf2SfAWGisiLM31xENk662qlCHq8sZ/paqtjt3eZaXOKGrssGV+agWpQPZx8hG
UomVM16P2+qxLiUqCJA0EOOW9ggCDp8j4tIhH2xt1ywv4cDp1bmh0Knq4dAN8zxQ
q2dynVwOmc9vYC83ebyxe4CgX5+lkGeOcTsK/mjV64S/jlEbcubHP28dE0Bnugdx
UWvcqFsf8kRz08Bri8Mw6P++D3ppCRTRdf0OPmfjwdmOpBl3z/m0T4hdV3Ko0j9b
AUA/tZTvZWnmdXHUwYCO
=mMXg
-----END PGP SIGNATURE-----

--nextPart4184560.sfx1yJpsId--
