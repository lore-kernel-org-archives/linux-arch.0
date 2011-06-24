From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 14/19] OpenRISC: Module support
Date: Fri, 24 Jun 2011 10:52:05 +0200
Message-ID: <1308905525.6699.23.camel@localhost>
References: <1308483825-6023-1-git-send-email-jonas@southpole.se>
	 <1308483825-6023-15-git-send-email-jonas@southpole.se>
	 <31626.1308686616@turing-police.cc.vt.edu>
	 <201106221626.12023.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tYR13ReIKy8XYceQKK8i"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201106221626.12023.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



--=-tYR13ReIKy8XYceQKK8i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-06-22 at 16:26 +0200, Arnd Bergmann wrote:
> I think that an easy way to do that would be to add to kernel/module.c
> code like:
>=20
> #ifndef module_alloc
> void *module_alloc(unsigned long size)
> {
> 	return vmalloc(size);
> }
> #endif
>=20

I noticed that kernel/module.c already has this:

unsigned int __weak arch_mod_section_prepend(struct module *mod,
                                             unsigned int section)


Is using a __weak attribute on the default (generic) implementations a
better approach?

> Then each architecture that needs a special version can do
> #define module_alloc(size) module_alloc(size)
> in their respective asm/module.h

With the __weak variant this wouldn't be necessary...

/Jonas

--=-tYR13ReIKy8XYceQKK8i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4EUDMACgkQ70gcjN2673PFLQCfSF4nv2BBwE2wyyBgMXVrV+Gb
N6cAoKEEbFTKSjRyCDrvXHejJaKEcFqv
=pAlF
-----END PGP SIGNATURE-----

--=-tYR13ReIKy8XYceQKK8i--
