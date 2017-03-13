From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] mm, gup: fix typo in gup_p4d_range()
Date: Mon, 13 Mar 2017 20:55:33 +0000
Message-ID: <e020448c790946c2b2edc36c92a8814d@svr-chch-ex1.atlnz.lc>
References: <20170313052213.11411-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53259 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdCMUzi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2017 16:55:38 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 13/03/17 18:22, Kirill A. Shutemov wrote:=0A=
> gup_p4d_range() should call gup_pud_range(), not itself.=0A=
>=0A=
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>=0A=
> Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> Fixes: c2febafc6773 ("mm: convert generic code to 5-level paging")=0A=
> ---=0A=
>  mm/gup.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/mm/gup.c b/mm/gup.c=0A=
> index c74bad1bf6e8..04aa405350dc 100644=0A=
> --- a/mm/gup.c=0A=
> +++ b/mm/gup.c=0A=
> @@ -1455,7 +1455,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long a=
ddr, unsigned long end,=0A=
>  			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,=0A=
>  					 P4D_SHIFT, next, write, pages, nr))=0A=
>  				return 0;=0A=
> -		} else if (!gup_p4d_range(p4d, addr, next, write, pages, nr))=0A=
> +		} else if (!gup_pud_range(p4d, addr, next, write, pages, nr))=0A=
>  			return 0;=0A=
>  	} while (p4dp++, addr =3D next, addr !=3D end);=0A=
=0A=
Fixes the build issue for me. Thanks.=0A=
=0A=
=0A=
=0A=
