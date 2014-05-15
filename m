Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [217.156.133.130] ([217.156.133.130]:15757 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751052AbaEOI7j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 May 2014 04:59:39 -0400
Message-ID: <537481F8.50809@imgtec.com>
Date: Thu, 15 May 2014 09:59:36 +0100
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 14/27] metag: Use common bits from generic tlb.h
References: <1400093999-18703-1-git-send-email-richard@nod.at> <1400093999-18703-15-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-15-git-send-email-richard@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6c7aqJUCE21fWNhW84WX85CBuO0gjtfEp"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: linux-metag@vger.kernel.org
Message-ID: <20140515085936.iGysWqWSxj3RXAtL1XXBR8BQPnqsG0aW2fwOPi2mZB8@z>

--6c7aqJUCE21fWNhW84WX85CBuO0gjtfEp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/05/14 19:59, Richard Weinberger wrote:
> It is no longer needed to define them on our own.
>=20
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-metag@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  arch/metag/include/asm/tlb.h | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/arch/metag/include/asm/tlb.h b/arch/metag/include/asm/tlb.=
h
> index 048282f1..0fb0b46 100644
> --- a/arch/metag/include/asm/tlb.h
> +++ b/arch/metag/include/asm/tlb.h
> @@ -19,18 +19,8 @@
>  		if (!tlb->fullmm)					      \
>  			flush_tlb_range(vma, vma->vm_start, vma->vm_end);     \
>  	} while (0)
> -
> -
> -#else
> -
> -#define tlb_start_vma(tlb, vma)			do { } while (0)
> -#define tlb_end_vma(tlb, vma)			do { } while (0)
> -
>  #endif
> =20
> -#define __tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)
> -#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
> -
>  #include <asm-generic/tlb.h>
> =20
>  #endif
>=20


--6c7aqJUCE21fWNhW84WX85CBuO0gjtfEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdIH4AAoJEGwLaZPeOHZ6y4wP/jgyrDKgmMPz4A5QH7SRG471
bKGXA23n0aMZrXEecJN0b6Vi941PVvb8J6Z7zazEsrNGDuVCHXacOoLc3/Yv/FvZ
u/m+GXMwA0rB8sms3M+7Lf+HSdTwnuqAiLLLymMKSEycR1d6hlqS6kC7iNqxCc2f
32zuLADp2YeV5W3nuieOzijUih+r8Rim6nakfgQplZ84oZhTFTDDycErYGYSDRXE
JA9/F4r7y9pGNCdeRIdrPEBkOqGUM0zT4diwrmZVF4RoBAh6l3SvAuWlHAj3IKd4
ELji3I0ECu535nEd0ney94d9nQ/aila5lNYis4TR9zdmAFWjDDBnF9L3x9+m5fRn
BTAzsexr3ObT+17n4xRY13cFDf4bm7VfEmYBofhWSpAYSh8PfraZ31d5G9nnretp
4w0lJl20jgk+FnMjFRA5K+vtyngNSkebkWEZL+m89uJtfZUyIaOiLaK6kcMrCq0V
qVISyj+RP57G217K08oI/PcOHidaC7Ql02+o42qVy3K/dK6rgU2oJFQifG9hRoKt
fI7i+6US4qA+QF9gApbkFnse89YBbWvP3X0XRlt/S1D9NJJ2XscSNSABh/krimaI
woYuYmC0HIAvhcgHYukM1/UuuFAz6i0xq0ZKKemRu2g11uLOcCm5R2zHMeuABqC8
b1f604UBj/10z3jb6QaF
=iYPb
-----END PGP SIGNATURE-----

--6c7aqJUCE21fWNhW84WX85CBuO0gjtfEp--
