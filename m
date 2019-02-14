Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407169AbfBNNvz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 08:51:55 -0500
Subject: Re: [PATCH 2/8] initramfs: free initrd memory if opening
 /initrd.image fails
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-3-hch@lst.de>
From: Steven Price <steven.price@arm.com>
Message-ID: <e4246b25-628e-de5e-56ba-8d45ad9c9fa6@arm.com>
Date: Thu, 14 Feb 2019 13:51:51 +0000
MIME-Version: 1.0
In-Reply-To: <20190213174621.29297-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org
Message-ID: <20190214135151.rl08gSlb3p82bdycZvxH9MpS_QC2JQlCFUo0XIDLCLs@z>

On 13/02/2019 17:46, Christoph Hellwig wrote:
> We free the initrd memory for all successful or error cases except
> for the case where opening /initrd.image fails, which looks like an
> oversight.

This also changes the behaviour when CONFIG_INITRAMFS_FORCE is enabled -
specifically it means that the initrd is freed (previously it was
ignored and never freed). But that seems like reasonable behaviour and
the previous behaviour looks like another oversight. FWIW:

Reviewed-by: Steven Price <steven.price@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  init/initramfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 7cea802d00ef..1cba6bbeeb75 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -610,13 +610,12 @@ static int __init populate_rootfs(void)
>  		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
>  		err = unpack_to_rootfs((char *)initrd_start,
>  			initrd_end - initrd_start);
> -		if (!err) {
> -			free_initrd();
> +		if (!err)
>  			goto done;
> -		} else {
> -			clean_rootfs();
> -			unpack_to_rootfs(__initramfs_start, __initramfs_size);
> -		}
> +
> +		clean_rootfs();
> +		unpack_to_rootfs(__initramfs_start, __initramfs_size);
> +
>  		printk(KERN_INFO "rootfs image is not initramfs (%s)"
>  				"; looks like an initrd\n", err);
>  		fd = ksys_open("/initrd.image",
> @@ -630,7 +629,6 @@ static int __init populate_rootfs(void)
>  				       written, initrd_end - initrd_start);
>  
>  			ksys_close(fd);
> -			free_initrd();
>  		}
>  	done:
>  		/* empty statement */;
> @@ -642,9 +640,9 @@ static int __init populate_rootfs(void)
>  			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
>  			clean_rootfs();
>  		}
> -		free_initrd();
>  #endif
>  	}
> +	free_initrd();
>  	flush_delayed_fput();
>  	return 0;
>  }
> 
