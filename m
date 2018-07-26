Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:35991 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388943AbeGZSs3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jul 2018 14:48:29 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 2/2] ARC: add SMP_CACHE_BYTES value validate
Date: Thu, 26 Jul 2018 17:30:40 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08404E@us01wembx1.internal.synopsys.com>
References: <20180726131544.3780-1-Eugeniy.Paltsev@synopsys.com>
 <20180726131544.3780-2-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Message-ID: <20180726173040.BDYV0ZWf9mNfSKjl3y2v210BH6QPGInyTjeSrEQIoi0@z>

On 07/26/2018 06:15 AM, Eugeniy Paltsev wrote:=0A=
> Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger=0A=
> or equal to any cache line length by comparing it with values=0A=
> previously read from ARC cache BCR registers.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> Changes v1->v2:=0A=
>  * None.=0A=
>=0A=
>  arch/arc/mm/cache.c | 10 ++++++++++=0A=
>  1 file changed, 10 insertions(+)=0A=
>=0A=
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c=0A=
> index 9dbe645ee127..b95365e1253a 100644=0A=
> --- a/arch/arc/mm/cache.c=0A=
> +++ b/arch/arc/mm/cache.c=0A=
> @@ -1246,6 +1246,16 @@ void __init arc_cache_init_master(void)=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> +	/*=0A=
> +	 * Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger=
=0A=
> +	 * or equal to any cache line length.=0A=
> +	 */=0A=
> +	BUILD_BUG_ON_MSG(L1_CACHE_BYTES > SMP_CACHE_BYTES,=0A=
> +			 "SMP_CACHE_BYTES must be >=3D any cache line length");=0A=
> +	if (is_isa_arcv2() && (l2_line_sz > SMP_CACHE_BYTES))=0A=
> +		panic("L2 Cache line [%d] > kernel Config [%d]\n",=0A=
> +		      l2_line_sz, SMP_CACHE_BYTES);=0A=
> +=0A=
>  	/* Note that SLC disable not formally supported till HS 3.0 */=0A=
>  	if (is_isa_arcv2() && l2_line_sz && !slc_enable)=0A=
>  		arc_slc_disable();=0A=
=0A=
LGTM. Both applied.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
