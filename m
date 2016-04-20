From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] asm-generic: wire up preadv2/pwritev2
Date: Wed, 20 Apr 2016 10:28:22 +0100
Message-ID: <20160420092822.GD30601@arm.com>
References: <1461077954-13015-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45624 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbcDTJ2V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Apr 2016 05:28:21 -0400
Content-Disposition: inline
In-Reply-To: <1461077954-13015-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 19, 2016 at 10:59:14AM -0400, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/uapi/asm-generic/unistd.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 2622b33..6e0f5f0 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -717,9 +717,13 @@ __SYSCALL(__NR_membarrier, sys_membarrier)
>  __SYSCALL(__NR_mlock2, sys_mlock2)
>  #define __NR_copy_file_range 285
>  __SYSCALL(__NR_copy_file_range, sys_copy_file_range)
> +#define __NR_preadv2 286
> +__SYSCALL(__NR_preadv2, sys_preadv2)
> +#define __NR_pwritev2 287
> +__SYSCALL(__NR_pwritev2, sys_pwritev2)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 286
> +#define __NR_syscalls 288

We could do with this for arm64:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
