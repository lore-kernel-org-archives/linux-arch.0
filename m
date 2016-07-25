From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 5/5] tile: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date: Mon, 25 Jul 2016 20:10:36 +0100
Message-ID: <20160725191036.GA1292@jhogan-linux.le.imgtec.org>
References: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
 <1469462394-8970-6-git-send-email-james.hogan@imgtec.com>
 <ac0ee1bd-572c-5c80-bf29-346c19a3aaa4@mellanox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:59111 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752348AbcGYTKj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jul 2016 15:10:39 -0400
Content-Disposition: inline
In-Reply-To: <ac0ee1bd-572c-5c80-bf29-346c19a3aaa4@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 12:37:50PM -0400, Chris Metcalf wrote:
> On 7/25/2016 11:59 AM, James Hogan wrote:
> > AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
> > NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
> > for tile at all even though ARCH_DLINFO will contain one NEW_AUX_ENT for
> > the VDSO address.
> >
> > This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
> > AT_BASE_PLATFORM which tile doesn't use, but lets define it now and add
> > the comment above ARCH_DLINFO as found in several other architectures to
> > remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
> > date.
> >
> > Fixes: 4a556f4f56da ("tile: implement gettimeofday() via vDSO")
> > Signed-off-by: James Hogan<james.hogan@imgtec.com>
> > Cc: Chris Metcalf<cmetcalf@mellanox.com>
> > ---
> >   arch/tile/include/asm/elf.h         | 1 +
> >   arch/tile/include/uapi/asm/auxvec.h | 2 ++
> >   2 files changed, 3 insertions(+)
>=20
> Thanks, taken into the tile tree.
>=20
> I'm a little dubious that AT_VECTOR_SIZE_ARCH should be being defined
> in the uapi version of auxvec.h, since I don't see why userspace should
> be interested in it, but that does seem to be the current convention.

Yes, I agree.

> Ugh, there are even CONFIG_xxx ifdefs in the x86 and sh uapi/asm/auxvec.h=
 ...
> Maybe the define could be moved to arch/*/include/asm/elf.h?

That sounds like a sensible place for it to me.

Cheers
James

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXlmQsAAoJEGwLaZPeOHZ6Jw0P/jrcUjYjzDFBHl5ES+Q9rPAu
FHjZ9j+MD3DPMK7HwUPkzPvWyjC2boiQjHOvN3JCL6IlzW7R/3cUB3imayMrbfZt
BhhrPm6oZyS9FJlGO3x4NKFn6sk0p2kVHMxycW/TdNpSYIfm4PlOHEb0fnwTPTEr
brFk5l4QDBCU1GaLc7UCg7UOHbKFLEOsmGdDoldyFAclJhLTGmRzuD8iIxbnZCuo
MEH7VFuJqvyVNTpe89tY0/YTPfan4GaKpnyMUzhEuWuzBQKGbmZXRaLY9eY0uk82
W41BM4Z54e/9ZJ65QOVBNGu3sWnG5MGzMKZubSouyNNzj6W2jWVbT8iV+X26u0Bj
5QaS2gdVy/HRP9Js0X91+EteZgfpOzCQYb3gfiVk+ZssR4Hi081hVEK/pxp8h9sY
SMREBsSL4NfyVEvYmrM/7aP/3HcaiUVUAF3EoWqbmPh9LkeaaIgFiZ0lEP166QOP
BiDe5u2C89TszIcc0W9jgmHSf2/KHeWMEps9A0dlz7nMvS7E8e7tao6ygJwzfU3/
HWgkp+/+ZGorRm5nGxllqgdELZT56pzD3cUDN6Y8Rii6gL4RdyWKdc35zHnDHIvl
DsHN28EySdFkzDoz5ZayyX5cihWQYsU9jJ/1hPSvYJwiQu4uFiMJjV/Elj2Rn1kK
sid7058DV43tYCmBOzsP
=0GPk
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
