Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:45045 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbXA0IZA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 27 Jan 2007 03:25:00 -0500
Date: Sat, 27 Jan 2007 00:24:53 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 10/26] Dynamic kernel command-line - ia64
Message-Id: <20070127002453.57b1e071.akpm@osdl.org>
In-Reply-To: <200701230014.06793.alon.barlev@gmail.com>
References: <200701230010.34323.alon.barlev@gmail.com>
	<200701230014.06793.alon.barlev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Bernhard Walle <bwalle@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 23 Jan 2007 00:14:06 +0200
Alon Bar-Lev <alon.barlev@gmail.com> wrote:

> 
> 1. Rename saved_command_line into boot_command_line.
> 2. Set command_line as __initdata.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> 
> ---
> 
> diff -urNp linux-2.6.20-rc4-mm1.org/arch/ia64/kernel/efi.c linux-2.6.20-rc4-mm1/arch/ia64/kernel/efi.c
> --- linux-2.6.20-rc4-mm1.org/arch/ia64/kernel/efi.c	2007-01-07 07:45:51.000000000 +0200
> +++ linux-2.6.20-rc4-mm1/arch/ia64/kernel/efi.c	2007-01-22 23:32:30.000000000 +0200
> @@ -413,11 +413,11 @@ efi_init (void)
>  	efi_char16_t *c16;
>  	u64 efi_desc_size;
>  	char *cp, vendor[100] = "unknown";
> -	extern char saved_command_line[];
> +	extern char __initdata boot_command_line[];
>  	int i;
>  
>  chk_nointroute_opt(void)
>  {
>  	char *cp;
> -	extern char saved_command_line[];
> +	extern char __initdata boot_command_line[];

no no no no no no no.  Just because some whacked-out weenie went and put
extern declarations in .c files doesn't mean that we should copy them.

It doesn't even compile.

arch/ia64/kernel/efi.c: In function `efi_init':
arch/ia64/kernel/efi.c:416: error: section attribute cannot be specified for local variables

Please.  Go through the entire patchset, yank all those wrong private
declarations of boot_command_line[] and put a *single, kernel-wide*
declaration into a single, shared header file.

Thanks.
