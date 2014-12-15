From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 03/18] arm64/uaccess: fix sparse errors
Date: Mon, 15 Dec 2014 11:17:16 +0000
Message-ID: <20141215111716.GG20738@arm.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
 <1418575877-21488-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:49683 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLOLRX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Dec 2014 06:17:23 -0500
Content-Disposition: inline
In-Reply-To: <1418575877-21488-4-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Christopher Covington <cov@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Dec 14, 2014 at 04:52:09PM +0000, Michael S. Tsirkin wrote:
> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 3bf8f4e..8d66bcf 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -147,7 +147,7 @@ do {									\
>  	default:							\
>  		BUILD_BUG();						\
>  	}								\
> -	(x) = (__typeof__(*(ptr)))__gu_val;				\
> +	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
>  } while (0)
>  
>  #define __get_user(x, ptr)						\

Acked-by: Will Deacon <will.deacon@arm.com>

Will
