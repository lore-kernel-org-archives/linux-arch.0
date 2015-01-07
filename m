From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 09/40] metag/uaccess: fix sparse errors
Date: Wed, 7 Jan 2015 09:47:24 +0000
Message-ID: <54AD00AC.2030801@imgtec.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com> <1420558883-10131-10-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wG9dUoEoOim5rPkFTQRge26B0AnONhSbC"
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420558883-10131-10-git-send-email-mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

--wG9dUoEoOim5rPkFTQRge26B0AnONhSbC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Machael,

On 06/01/15 15:43, Michael S. Tsirkin wrote:
> virtio wants to read bitwise types from userspace using get_user.  At t=
he
> moment this triggers sparse errors, since the value is passed through a=
n
> integer.
>=20
> Fix that up using __force.
>=20
> Signed-off-by: Michael S. Tsirkin <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/metag/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/metag/include/asm/uaccess.h b/arch/metag/include/asm/=
uaccess.h
> index 0748b0a..c314b45 100644
> --- a/arch/metag/include/asm/uaccess.h
> +++ b/arch/metag/include/asm/uaccess.h
> @@ -135,7 +135,7 @@ extern long __get_user_bad(void);
>  ({                                                              \
>  	long __gu_err, __gu_val;                                \
>  	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
> -	(x) =3D (__typeof__(*(ptr)))__gu_val;                     \
> +	(x) =3D (__force __typeof__(*(ptr)))__gu_val;                     \

As I mentioned before, can you please adjust the position of the \ to
line up.

>  	__gu_err;                                               \
>  })
> =20
> @@ -145,7 +145,7 @@ extern long __get_user_bad(void);
>  	const __typeof__(*(ptr)) __user *__gu_addr =3D (ptr);		\
>  	if (access_ok(VERIFY_READ, __gu_addr, size))			\
>  		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
> -	(x) =3D (__typeof__(*(ptr)))__gu_val;                             \
> +	(x) =3D (__force __typeof__(*(ptr)))__gu_val;                        =
     \

same here (this one causes checkpatch error due to 80 column limit).

>  	__gu_err;                                                       \
>  })
> =20
>=20

With those changes,
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Cheers
James


--wG9dUoEoOim5rPkFTQRge26B0AnONhSbC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrQCzAAoJEGwLaZPeOHZ6ho8P/ij5ANUeelvOYnmpKda00EsN
YgLDZzZg+meMDzDoBp1jpqeJYSCPL3lV2Ln5/prbdlXXEX4CGeS8K/DfnRX4v7TL
r4Oc3u8ei2Q7MRPOB5hGuUS5Qj23QlSP599Jq7sUhF7FKGgcIJ9/xFhXlktG61GF
CE1z7QroVNhQpv2va/Xasgc07qVN+X9h105aEb9TjPi+BcCfs6Gldg2jLpxrpx8/
6RbCWXKchrVD9NILdTqzG3ZxVyZnhO5BFb9ko5/Di+7SEdQU70ZsBVYhoEoZjLqZ
8891LmYli7pqW4nFV28uQw5yVJMlSzhdIqHugDAvRaw8VPgwO6ZmoH/XovaHk4Dz
4tNoVjMkjT2Mh3tOgfJVe6B3x97g6iIIvbumnGNNUI9LEX4zlmLVhe8eiG0cs3iu
b4nxpAmZjt32PZHBBRTGjgCrj06UpZNsTSdmztKme8wSIQe+YrEWyva/PtMBLrbI
33HYra5g4HIv9oHGb5VPLf2kGhKRBAuAdrhrcz61+VdoZ72Mz20Rk5j9y+lOR7cN
Ix98BCttozR/Ik7C/YmyjKoeM80YTGri1rGgCtyB+no/F6nuhlbiH1C1obW/Wymq
lCf/JoQ2hS1FHITPMpMj+fzf+bs1PzvXRDwKIYLYCDJ5RCA4sxbclbmj2i68yneF
a4DjAMOF7+jDBqk+js4M
=Xkhs
-----END PGP SIGNATURE-----

--wG9dUoEoOim5rPkFTQRge26B0AnONhSbC--
--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
