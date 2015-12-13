From: Chen Gang <chengang@emindsoft.com.cn>
Subject: Re: [PATCH] include/asm-generic/pgtable.h: Check once and return
 for pgprot_modify
Date: Sun, 13 Dec 2015 23:46:01 +0800
Message-ID: <566D92B9.7040805@emindsoft.com.cn>
References: <566D3662.6080804@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out21.biz.mail.alibaba.com ([205.204.114.132]:33657 "EHLO
	out21.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751924AbbLMPno (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Dec 2015 10:43:44 -0500
In-Reply-To: <566D3662.6080804@emindsoft.com.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Gang <gang.chen.5i5j@gmail.com>, chenwei@emindsoft.com.cn, james.hogan@imgtec.com


Oh, after check again, it looks my original comments are not precise:
they check oldprot, but set newprot.

After check pgprot_noncached, pgprot_writecombine, and pgprot_device
again, for me, if still in order: 1st noncached, 2nd writecombine, 3rd
device, we can still treate them exclusive with each other:

 - For pgprot_device, Only amd64 redefine it, which is exclusive with
   the others (or the precisely same as one of the others).

 - For pgprot_writecombine, except metag and x86, all the other archs
   are exclusive with (or same as) pgprot_noncached.

   for metag arch, pgprot_writecombine is the part of pgprot_noncached.

   for x86 arch, it has its own pgprot_modify.


Thanks.

On 12/13/15 17:12, Chen Gang wrote:
>=20
> pgprot_val() likes an empty operation, and all three checking stateme=
nts
> are related with oldprot, so only check once is enough, the reason is=
:
>=20
>  - if both "oldprot =3D=3D pgprot_noncached(oldprot)" and "oldprot =3D=
=3D
>    pgprot_writecombine(oldprot)" are satisfied.
>=20
>  - So "pgprot_noncached(oldprot) =3D=3D pgprot_writecombine(oldprot)"=
, too.
>=20
>  - So as the result, it is still equal to check once (for pgprot_devi=
ce
>    can get the same result).
>=20
> Then can return directly.
>=20
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  include/asm-generic/pgtable.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgta=
ble.h
> index 069536a..cd9e7c4 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -306,11 +306,11 @@ static inline int pmd_same(pmd_t pmd_a, pmd_t p=
md_b)
>  static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newp=
rot)
>  {
>  	if (pgprot_val(oldprot) =3D=3D pgprot_val(pgprot_noncached(oldprot)=
))
> -		newprot =3D pgprot_noncached(newprot);
> +		return pgprot_noncached(newprot);
>  	if (pgprot_val(oldprot) =3D=3D pgprot_val(pgprot_writecombine(oldpr=
ot)))
> -		newprot =3D pgprot_writecombine(newprot);
> +		return pgprot_writecombine(newprot);
>  	if (pgprot_val(oldprot) =3D=3D pgprot_val(pgprot_device(oldprot)))
> -		newprot =3D pgprot_device(newprot);
> +		return pgprot_device(newprot);
>  	return newprot;
>  }
>  #endif
>=20

--=20
Chen Gang (=E9=99=88=E5=88=9A)

Open, share, and attitude like air, water, and life which God blessed
