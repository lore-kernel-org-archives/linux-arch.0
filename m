From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 0/6] Introduce the for_each_set_clump macro
Date: Fri, 24 Apr 2020 09:50:33 -0400
Message-ID: <20200424135011.GA3255@icarus>
References: <20200424122407.GA5523@syed>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200424122407.GA5523@syed>
Sender: linux-gpio-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: Syed Nayyar Waris <syednwaris@gmail.com>, andriy.shevchenko@linux.intel.com, michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, yamada.masahiro@socionext.com, rui.zhang@intel.com, daniel.lezcano@linaro.org, amit.kucheria@verdurent.com, linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 05:54:07PM +0530, Syed Nayyar Waris wrote:
> This patchset introduces a new generic version of for_each_set_clump.=20
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro=
=20
> in several GPIO drivers.

Regarding the nomenclature, I created the term "clump" to represent an
8-bit value that was not necessarily a byte yet was a contiguous
grouping of bits. With this patchset, we now have a more generic
for_each_set_clump macro that can handle values larger and smaller than
8-bits.

Would it make sense to retire the term "clump" and instead use "nbits"
where applicable, in order to match the existing convention used by the
bitmap functions; for instance, would it be better to name this macro
for_each_set_nbits?

William Breathitt Gray

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6i7qkACgkQhvpINdm7
VJIciBAA4lGCd+eUHQXeYgvLK14UXVfbjASoiUjFVFetkDeXj+GGFQG7W/fVMxrM
LoJV4wXwNl9qyedfdNI8aZmjUwF2Tyy+XEaxo/wa6XyfIXvKrqDYNpESIhvFgMv9
BcxDVlWrMixZ440pQqqFRfGx7bLM2pryn05hh5yr46Y3kZZRISeAlygC+cZfDmzT
O7KXcRIB4ZTeZ0irSlLKsEFpp42YIKUX+gt3zwkxSoRIhfBRToE2KU42oLhez48t
WuUHpZ2TexCV35B+QAjjAXqMdnL3Rg43pRCJG614VuvSleY2hAkED5lqMlt0SIh4
4kEbvK/fea2QInYY/WA5EKxtFka9huXJ1dhqqUUSFFQfUPhqA/GSxpZ+5o7EeWjr
v4d4uzg897E5BwZhrWOJUHBIfA4LXkQMV+ZGL1ijWmNnYy3uigREGZYrNylShQ1O
INlHzTcoqy++g+kETBV/MEZJWGbtqRGqr4/u1UaECO/Ccy0cHDhp9mQ0JmSoXdQe
pIIhBDfm3raffCMVjSqfVToHENxHuwqcTIgxJ+CAR7j2BOAF/oeNULgsKnRZrfMu
UE32VfmG2xXdHiqw4R/fBzK1g/DLF7c04RYBPjY7S1/Tvrox9dTnfJbPA1r4KB35
vIQf2L/hGGV/F/IRYgVdtVVVNaB3qEsrimj0CJjnpQYNkE3fUoM=
=A+Kx
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
