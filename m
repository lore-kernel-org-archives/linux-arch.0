From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Fri, 29 May 2020 17:31:11 -0400
Message-ID: <20200529213111.GA25882@shinobu>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com>
 <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com>
 <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE2Vb3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 17:31:29 -0400
Content-Disposition: inline
In-Reply-To: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2020 at 01:32:44AM +0530, Syed Nayyar Waris wrote:
> On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wro=
te:
> >
> > ...
> >
> > > >    579  static inline unsigned long bitmap_get_value(const unsigned=
 long *map,
> > > >    580                                                unsigned long=
 start,
> > > >    581                                                unsigned long=
 nbits)
> > > >    582  {
> > > >    583          const size_t index =3D BIT_WORD(start);
> > > >    584          const unsigned long offset =3D start % BITS_PER_LON=
G;
> > > >    585          const unsigned long ceiling =3D roundup(start + 1, =
BITS_PER_LONG);
> > > >    586          const unsigned long space =3D ceiling - start;
> > > >    587          unsigned long value_low, value_high;
> > > >    588
> > > >    589          if (space >=3D nbits)
> > > >  > 590                  return (map[index] >> offset) & GENMASK(nbi=
ts - 1, 0);
> > > >    591          else {
> > > >    592                  value_low =3D map[index] & BITMAP_FIRST_WOR=
D_MASK(start);
> > > >    593                  value_high =3D map[index + 1] & BITMAP_LAST=
_WORD_MASK(start + nbits);
> > > >    594                  return (value_low >> offset) | (value_high =
<< space);
> > > >    595          }
> > > >    596  }
> >
> > > Regarding the above compilation warnings. All the warnings are because
> > > of GENMASK usage in my patch.
> > > The warnings are coming because of sanity checks present for 'GENMASK'
> > > macro in include/linux/bits.h.
> > >
> > > Taking the example statement (in my patch) where compilation warning
> > > is getting reported:
> > > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > >
> > > 'nbits' is of type 'unsigned long'.
> > > In above, the sanity check is comparing '0' with unsigned value. And
> > > unsigned value can't be less than '0' ever, hence the warning.
> > > But this warning will occur whenever there will be '0' as one of the
> > > 'argument' and an unsigned variable as another 'argument' for GENMASK.
> > >
> > > This warning is getting cleared if I cast the 'nbits' to 'long'.
> > >
> > > Let me know if I should submit a next patch with the casts applied.
> > > What do you guys think?
> >
> > Proper fix is to fix GENMASK(), but allowed workaround is to use
> >         (BIT(nbits) - 1)
> > instead.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
>=20
> Hi Andy. Thank You for your comment.
>=20
> When I used BIT macro (earlier), I had faced a problem. I want to tell
> you about that.
>=20
> Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
> clump size) is BITS_PER_LONG, unexpected calculation happens.
>=20
> Explanation:
> Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my compute=
r),
> (BIT(nbits) - 1)
> gives a value of zero and when this zero is ANDed with any value, it
> makes it full zero. This is unexpected and incorrect calculation happenin=
g.
>=20
> What actually happens is in the macro expansion of BIT(64), that is 1
> << 64, the '1' overflows from leftmost bit position (most significant
> bit) and re-enters at the rightmost bit position (least significant
> bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> subtracted from this, the final result becomes 0.
>=20
> Since this macro is being used in both bitmap_get_value and
> bitmap_set_value functions, it will give unexpected results when nbits or=
 clump
> size is BITS_PER_LONG (32 or 64 depending on arch).
>=20
> William also knows about this issue:
>=20
> "This is undefined behavior in the C standard (section 6.5.7 in the N1124=
)"
>=20
> Andy, William,
> Let me know what do you think ?
>=20
> Regards
> Syed Nayyar Waris

We can't use BIT here because nbits could be equal to BITS_PER_LONG in
some cases. Casting to long should be fine because the nbits will never
be greater than BITS_PER_LONG, so long should be safe to use.

However, I agree with Andy that the proper solution is to fix GENMASK so
that this warning does not come up. What's the actual line of code in
the GENMASK macro that is throwing this warning? I'd like to understand
better the logic of this sanity check.

William Breathitt Gray

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl7RfwsACgkQhvpINdm7
VJJhlw//e+7H6kFZycy9xd7K62j4lqCx7Afz2mOmeY3hJ7X2gZhYUZZFh1e8yXYM
PRGOW738gyQWXWVdHyuhBSQvzfRmWYFxseBzXtOzxrZSUbUXCI1HPOoAP1SobKzW
XhbYgG8r3GgWOnDtidmn1jEEPmzfsG+6AV6sJ5U8KtXAjrn+hSG7PQPAWbTkEHVU
qX9FQsJez4GNARzxIFmOcZpJ8nhiOzhojRMdLrD4t2tdDXmd1ijdeG9FraiMqERw
0M+FzNabBYrmh/rxsc3PG6Yq6QOe94L1jOjrdnRqzaSR6Y1zJ9aZuzwaozryUgke
ZkoQVgn6QIvvTaBa7WtFNYw6LXFFH5Tx2tOv8YWjN52LamW6zTyOhzoQZCyjK+kD
C1w3DMHGqi+V7AjB6EMNQOvCnJgtPw43y0LVxOGugM9S1D/BgcMmZAn0cV0+E7pS
mFeCdBanWrJeZ8xE/dVm4+Y2jOIIsPH2iAr1il8sBgdZXvXqGeRrB4uoF7CJECNQ
vsn2ExxWHDh4jiVWMaDkF7131sdg/ffJApkJkaIpkq2WJAS88RrOJY6yuyTPyhi/
f8HUBq6XBQVQlnnRD+zhIf28oLHvePx6gqyIAtVdHJy9OKj0sSUfWxgZvb1xnwZ7
rQ5lwovxRku8mCoi80TBsDTWMnBUjDLlSZHSLhVNKs2Raa01Akw=
=vqfY
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
