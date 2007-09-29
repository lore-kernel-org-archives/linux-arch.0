Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate8.uk.ibm.com ([195.212.29.141]:16411 "EHLO
	mtagate8.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXI1Tfb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2007 15:35:31 -0400
Date: Sat, 29 Sep 2007 07:06:10 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] Generic compat_sys_fallocate
Message-ID: <20070929050610.GA8880@osiris.ibm.com>
References: <20070928181111.GF22182@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070928181111.GF22182@fattire.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Sep 28, 2007 at 02:11:11PM -0400, Kyle McMartin wrote:
> Basically everyone is using the same sys32_fallocate. Delete a whole bunch of
> archdep code and move the compat wrapper to fs/compat.c
> 
> Signed-off-by: Kyle McMartin <kyle@mcmartin.ca>
> --- a/arch/sparc64/kernel/sys_sparc32.c
> +++ b/arch/sparc64/kernel/sys_sparc32.c
> @@ -1028,9 +1028,3 @@ long compat_sync_file_range(int fd, unsigned long off_high, unsigned long off_lo
>  				   flags);
>  }
> 
> -asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
> -				     u32 lenhi, u32 lenlo)
> -{
> -	return sys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
> -			     ((loff_t)lenhi << 32) | lenlo);
> -}
> diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
> index bee96d6..ca8deac 100644
> --- a/arch/x86_64/ia32/sys_ia32.c
> +++ b/arch/x86_64/ia32/sys_ia32.c
> @@ -880,10 +880,3 @@ asmlinkage long sys32_fadvise64(int fd, unsigned offset_lo, unsigned offset_hi,
>  				len, advice);
>  }
> 
> -asmlinkage long sys32_fallocate(int fd, int mode, unsigned offset_lo,
> -				unsigned offset_hi, unsigned len_lo,
> -				unsigned len_hi)
> -{
> -	return sys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
> -			     ((u64)len_hi << 32) | len_lo);
> -}

These are not identical... the least and most significant parts seem to get
passed in a different way on little and big endian machines.
Maybe it would be worth to have something like compat_merge_64() which does
the right thing?
