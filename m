From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 14:22:13 +0000
Message-ID: <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
 <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
 <1667268.iM977TQnEK@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1667268.iM977TQnEK@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 03:09:14PM +0100, Arnd Bergmann wrote:
> On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> > When a header file is removed from generic-y (often accompanied by the
> > addition of an arch specific header), the generated wrapper file will
> > persist, and in some cases may still take precedence over the new arch
> > header.
> >=20
> > For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> > context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> > and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> > the wrapper when reusing a dirty build tree resulted in build failures
> > in arch/mips/kernel/signal.c:
> >=20
> > arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=80=
=99:
> > arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=E2=80=
=99 has no member named =E2=80=98uc_extcontext=E2=80=99
> >   return &uc->uc_extcontext;
> >             ^
> >=20
> > Fix by detecting and removing wrapper headers in generated header
> > directories that do not correspond to a filename in generic-y, genhdr-y,
> > or the newly introduced generated-y.
>=20
> Good idea.
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd

> Can you merge this through the mips tree, or do you need me to pick it
> up through asm-generic?

I was envisaging the kbuild tree tbh, but I don't really mind how it
gets merged. This patch depends on patch 1, which adds generated-y to
x86 so we don't delete their other generated headers, but other than
that it doesn't really have any dependencies.

Cheers
James

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnkaVAAoJEGwLaZPeOHZ6LmUQAKpWgHRKouJiF5R5uD2uvVkn
PfRiCE8HmFx4ZN6wZu5uSF8wujCGQGxUr6JTvfyC66CvHlFSgPwCwHEseoTFAvHj
rE77AQcz3qUwz30KIfS9Hj7XaBBPgi6XC9ljQ4qghijCpLANreyLvah90pg1Tgge
r9AX7SaSsXMX9jJj8h6zOuTKXELlDAzi6rGm/Zp+dzscdht9U5OoTruJ06HvxdLG
+4AdpuYpAW+qHYrqhmo6vGWwgLZaps37dOHk0pRcdRXRVaaCr9LjZmywR/FAz6+3
idr6ME2irAhSe8sMXB+A4dscHp8GFCcutyInhNFSw5JrZrifjp15sLhpbb8pgX5y
I4N8mn9ADW/bRNcvi6Y9zPBNLbnY+kOdPNKrSsJbtW9oLhS4ZR9amYjqsfzFfWzM
yvhr1BB7ENHca2aF9Cm2RM0W25luhYjOhMY1QMTg0Wk28dbGeKh5eMOt4MEuf4/1
sd/b5SRgAIoSCvq9dJfIpOv6tu0WIooepA6ZtJ7N7LYSaI7PdAbjIqKG/lNUWB66
PFzprvBh9XI/dpoUTYtWgIG7Kt6cLA8gcfwqa0ZCK+1B0kR/B2OxymaXEIig/CpL
54F2hef8q3L8aHlP6XZ4911AT2nPhtt9s4hoUhWnJBnkWlS5C5RyiSmPzfp617tn
iWeC12OMk1R0ZgpqL3HU
=Lh3+
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
