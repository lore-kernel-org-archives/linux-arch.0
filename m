Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:50938 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993003AbXCIG4B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Mar 2007 01:56:01 -0500
Subject: Re: [PATCH] [POWERPC] Wire up sys_sync_file_range
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
References: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 06:55:41 +0000
Message-Id: <1173423341.3461.548.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: paulus@samba.org, ppc-dev <linuxppc-dev@ozlabs.org>, ralf@linux-mips.org, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-03-09 at 15:22 +1100, Stephen Rothwell wrote:
> This requires an architecture specific compat routine as u64s are passed
> in odd/even (high/low) register pairs on ppc32.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Doesn't that apply to ARM and to 32-bit MIPS too? And perhaps others?

> --- a/arch/powerpc/kernel/sys_ppc32.c
> +++ b/arch/powerpc/kernel/sys_ppc32.c
> @@ -814,3 +814,12 @@ asmlinkage long compat_sys_request_key(const char __user *_type,
>  	return sys_request_key(_type, _description, _callout_info, destringid);
>  }
>  
> +asmlinkage long compat_sys_sync_file_range(int fd, u32 unused,
> +		u32 offset_high, u32 offset_low,
> +		u32 nbytes_high, u32 nbytes_low,
> +		compat_uint_t flags)
> +{
> +	return sys_sync_file_range(fd, (loff_t)offset_high << 32 | offset_low,
> +			(loff_t)nbytes_high << 32 | nbytes_low,
> +			(unsigned int)flags);
> +}

-- 
dwmw2

