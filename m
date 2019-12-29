Return-Path: <SRS0=EoGw=2T=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39492 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbfL2Bbk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Dec 2019 20:31:40 -0500
Message-ID: <1577583097.5661.6.camel@HansenPartnership.com>
Subject: Re: [PATCH] mm/hugetlb: ensure signedness of large numbers
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 28 Dec 2019 17:31:37 -0800
In-Reply-To: <20191228103357.23904-1-batuhanosmantaskaya@gmail.com>
References: <20191228103357.23904-1-batuhanosmantaskaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: isidentical <batuhanosmantaskaya@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191229013137.md0uPoLH4qJKFs_d-hletmx5l6E01MmdfoO1X5qCUOU@z>

On Sat, 2019-12-28 at 13:33 +0300, isidentical wrote:
> This change introduces a sanitity helper for
> numbers that are larger than 2^5.

What's the rationale for this ... i.e. what problem are you trying to
solve?  left to its own devices, gcc will assume int size for all
literals, so 34<<26 doesn't appear to have a problem, except that it
will be sign extended as a negative number into a 64 bit variable. 
However, it's designed use is for an int flags in mmap, so its current
definition seems to be fine.

> Signed-off-by: isidentical <batuhanosmantaskaya@gmail.com>
> ---
>  include/uapi/asm-generic/hugetlb_encode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/asm-generic/hugetlb_encode.h
> b/include/uapi/asm-generic/hugetlb_encode.h
> index b0f8e87235bd..42c06c62ae17 100644
> --- a/include/uapi/asm-generic/hugetlb_encode.h
> +++ b/include/uapi/asm-generic/hugetlb_encode.h
> @@ -31,6 +31,6 @@
>  #define HUGETLB_FLAG_ENCODE_512MB	(29 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_1GB		(30 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_2GB		(31 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
> -#define HUGETLB_FLAG_ENCODE_16GB	(34 <<
> HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_16GB	(UINT32_C(34) <<
> HUGETLB_FLAG_ENCODE_SHIFT)

And if there is a literal problem here, it can't be solved like this:
UINT32_C is a Cism which has no analogue in the kernel because we don't
pull in the /usr/include headers where it is defined.  Usually in the
kernel we solve this by making the literal type explicit, like 34U, but
as I said above, I don't see a problem that this would solve.

James
