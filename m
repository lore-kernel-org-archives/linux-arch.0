From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Date: Fri, 24 Apr 2020 11:09:26 -0400
Message-ID: <20200424150828.GA5034@icarus>
References: <20200424122521.GA5552@syed>
 <20200424141037.ersebbfe7xls37be@wunner.de>
 <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
 <20200424150058.xadjxaga3csh3br6@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727017AbgDXPJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 11:09:42 -0400
Content-Disposition: inline
In-Reply-To: <20200424150058.xadjxaga3csh3br6@wunner.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>, akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com, arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 05:00:58PM +0200, Lukas Wunner wrote:
> On Fri, Apr 24, 2020 at 08:22:38PM +0530, Syed Nayyar Waris wrote:
> > On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> > > > +static inline void bitmap_set_value(unsigned long *map,
> > > > +                                 unsigned long value,
> > > > +                                 unsigned long start, unsigned lon=
g nbits)
> > > > +{
> > > > +     const size_t index =3D BIT_WORD(start);
> > > > +     const unsigned long offset =3D start % BITS_PER_LONG;
> > > > +     const unsigned long ceiling =3D roundup(start + 1, BITS_PER_L=
ONG);
> > > > +     const unsigned long space =3D ceiling - start;
> > > > +
> > > > +     value &=3D GENMASK(nbits - 1, 0);
> > > > +
> > > > +     if (space >=3D nbits) {
> > > > +             map[index] &=3D ~(GENMASK(nbits + offset - 1, offset)=
);
> > > > +             map[index] |=3D value << offset;
> > > > +     } else {
> > > > +             map[index] &=3D ~BITMAP_FIRST_WORD_MASK(start);
> > > > +             map[index] |=3D value << offset;
> > > > +             map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + nb=
its);
> > > > +             map[index + 1] |=3D (value >> space);
> > > > +     }
> > > > +}
> > >
> > > Sorry but what's the advantage of using this complicated function
> > > as a replacement for the much simpler bitmap_set_value8()?
> > >
> > > The drivers calling bitmap_set_value8() *know* that 8-bit accesses
> > > are possible and take advantage of that knowledge by using a small,
> > > speed-optimized function.  Replacing that with a more complicated
> > > (potentially less performant) function doesn't seem to be a step
> > > forward.
> >=20
> > Actually this generic function can work with n-bits of any size (less
> > than equal to BITS_PER_LONG), while the earlier bitmap_set_value8
> > worked with n-bits having size of 8 bits only.
> >=20
> > In the case when n-bits is 8-bits, this new bitmap_set_value()
> > function would behave very similar to the earlier bitmap_set_value8()
> > function. For example,  in case of n-bits being 8-bits it will always
> > execute the 'if' condition and not the 'else' condition, hence
> > offering the same performance (because of encountering similar code
> > statements) as earlier bitmap_set_value8() function, most probably.
> >=20
> > There is an additional advantage (this can happen when n-bits is not 8
> > bits): during setting value of n-bit in bitmap, if a situation arise
> > that the width of next n-bit is exceeding the word boundary, then it
> > will divide itself such that some portion of it is stored in that
> > word, while the remaining portion is stored in the next higher word.
> >=20
> > So, this function preserves the behaviour of earlier
> > bitmap_set_value8() function and also adds extra functionality to
> > that.
>=20
> Please leave drivers as is which use exclusively 8-bit accesses,
> e.g. gpio-max3191x.c and gpio-74x164.c.  I'm fearing a performance
> regression if your new generic variant is used.  They work perfectly
> fine the way they are and I don't see any benefit this series may have
> for them.
>=20
> If there are other drivers which benefit from the flexibility of your
> generic variant then I'm not opposed to changing those.
>=20
> Thanks,
>=20
> Lukas

We can leave of course bitmap_set_value8 alone, but for 8-bit values the
difference in latency I suspect is primarily due to the conditional test
for the word boundaries. This latency is surely overshadowed by the I/O
latency of the GPIO drivers, so I don't think there's much harm in
changing those to use the generic function when the bottleneck will not
be due to the bitmap_set_value/bitmap_get_value operations.

William Breathitt Gray

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6jASYACgkQhvpINdm7
VJK6Pg/+KKvrnl2mkz+WQRqeUtC2vT7B96V67NjNLkDgAR2WUj35kia4ooNFeGD1
e2tRjz/yAmdX3XhGnNfA2ec6O14y/IjRzN1WKijRKgiAGM8Lxa2XZC02a+IfYak1
QsEk66u6CHN9hDdRf/TQl/slYKn7C2lz5mJZKmR9v+S7T4818xX1FxfB44sUEwzf
x6eFnlA/flrrfH89bF++bVRO8UZqUurcejW4P1jFM8o5NbIna8S9zChxIwBFVPmh
1Ng3VlCXYFihIdsLlXvegY/ZRr28MDr5J/JDSP5ZPVFDkYxnCeQUlAvJeXa8vZ8N
01LX+JkhquzbPJns8mxnUZ1y9FZL5Zzz4yKZzS0zf+QQqiCDsnEl5eyjwXR/2sO9
ahd/69eJaidwMiYtVLOj3z7qxgEvegxjp72mrYmGkfB88j9wjKly4z2P+wQlqXyz
tJuZCBpJJSpBXe0lKNIjD+kNLhRHzoxQpN3bvNHby7N7P5L1OL2P4Js6yQ8N3fv0
T5D/AHr1aC8wlVd2ULc5101dYpAxsqOZYMsZQ6AoIwXELTInyuNWKSkMZqh1uQZw
EE8jzl5k0l37C4nbxlfxO8xrorGavE/R1NxV2iIqD2+4U80HnRgjaKiA/zy3BAZ0
gPCEd/T/tXVx5glx5Hu9xrpQYFSm3kvoySNsZ7tbrFUQPx5z+kM=
=Dh6C
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
