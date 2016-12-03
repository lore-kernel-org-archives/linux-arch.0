From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [RFC, PATCH, v3.9] default exported asm symbols to zero
Date: Sat, 03 Dec 2016 04:36:37 +0000
Message-ID: <1480739797.16599.118.camel@decadent.org.uk>
References: <20161129131922.GA31466@angband.pl>
	 <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
	 <14455987.OWjnZpEEup@wuerfel> <8452191.39CeLIHTBT@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jgxpGrB4le5YdtYZKT0O"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <8452191.39CeLIHTBT@wuerfel>
Resent-Message-ID: <DhE-IaLIXmL.A.Yw.zvkQYB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1480739797.16599.118.camel@decadent.org.uk
To: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org


--=-jgxpGrB4le5YdtYZKT0O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2016-12-02 at 13:40 +0100, Arnd Bergmann wrote:
> With binutils-2.16 and before, a weak missing symbol was kept during the
> final link, and a missing CRC for an export would lead to that CRC
> being treated as zero implicitly. With binutils-2.17, the crc
> symbol gets dropped, and any module trying to use it will fail to
> load.
>=20
> This sets the weak CRC symbol to zero explicitly, making it defined
> in vmlinux, which in turn lets us load the modules referring to
> that CRC.
>=20
> The comment above the __CRC_SYMBOL macro suggests that this was
> always the intention, although it also seems that all symbols
> defined in C have a correct CRC these days, and only the exports
> that are now done in assembly need this.
>=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure if this is the correct way of doing it, but this seems trivial
> enough and lets me build the kernel with missing CRCs with any binutils
> version.

I tried this along with Adam's patch on x86_64, with Debian's binutils
2.27.51.20161127.  The result was that the kernel's __kcrctab held 0
for several symbols, even though there was type information in asm-
prototypes.h and Module.symvers and the modules had a non-zero CRC for
those symbols.  With just Adam's patch, the kernel and modules agreed.

Ben.

> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 63554e9..59a3b2f 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -54,6 +54,7 @@ KSYM(__kstrtab_\name):
> =C2=A0KSYM(__kcrctab_\name):
> > =C2=A0	__put KSYM(__crc_\name)
> > =C2=A0	.weak KSYM(__crc_\name)
> > +	.set KSYM(__crc_\name), 0
> > =C2=A0	.previous
> =C2=A0#endif
> =C2=A0#endif
>=20
--=20
Ben Hutchings
Absolutum obsoletum. (If it works, it's out of date.) - Stafford Beer

--=-jgxpGrB4le5YdtYZKT0O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlhCS9UACgkQ57/I7JWG
EQn/LA/9Gu6KIOp7WrTbarspgkEtwgTK02mqCOZdtzDpZL1allV3IjjPEt1sXWgV
ko9iYxSVwBD4WkE5GgBjpsbzaLA8xrHKOMFut4bJheCGXRx8TkFyiaA+EainToZL
dGB0OFRm6XIMdQsJ26h506HHdQzqb5eqTTRjK+OQXTFsY+hXLQjfQbvaeQsE1xo6
Wf7ebEfWnZUD78i2UYH66rgVjErGRWNN6wwbV6fxhNlvDGiYiE8GVVV+VyjRIcV1
XelpnQ20CjQNzshYbFk4AuiTwquMsuvpWUBAZmmUdtuBzIHQH1OVuw6mycdJLYKQ
/VpyYJRqoussdtPoPeS7tct+/OlgmffX8wdd1uSPXg9yYMz4JSl3jTJFlhqKVVwW
phLHW4dNHpQjXmLnbWJ5nXhdX7d4ODWOycNB5efIQSz8XT0SfBcgZfFP9e+YAAm+
VMEOl3Lgs1881fVjhKeapFJD5ggA1ZmEoHEKif6aotSyLjvzGxSI6Hmg3oblXrAQ
jOQseYNiOS7vDxydePF9dS00wv5GS1XA/q3Aomfen4mmOI4/lyXpYyhQPxQyradb
W8o+q/TgYBb6TS0UjAl3ooFNQkFu23lQo/f3zBbB2/pcIRi7Ec8CNltYsPwyQJet
nPySQDk45Vm8JjrnAL2v6NEXlnZvHtLAJptwkBLOq7IkIOgPoi8=
=6jbi
-----END PGP SIGNATURE-----

--=-jgxpGrB4le5YdtYZKT0O--
