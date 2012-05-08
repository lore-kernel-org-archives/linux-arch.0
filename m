From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/6] get_unmapped_area checks for TASK_SIZE before
	MAP_FIXED on sparc32
Date: Tue, 8 May 2012 18:27:22 +0200
Message-ID: <20120508162722.GA11624@merkur.ravnborg.org>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com> <1336488022-3723-4-git-send-email-murzin.v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:25872 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223Ab2EHQ1Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 12:27:24 -0400
Content-Disposition: inline
In-Reply-To: <1336488022-3723-4-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <murzin.v@gmail.com>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk

On Tue, May 08, 2012 at 06:40:19PM +0400, Vladimir Murzin wrote:
> Move check for TASK_SIZE before MAP_FIXED in sparc32's arch_get_unmapped_area().

I would be good to copy relevant parts of your cover letter into each patch.
when the patches are applied we looses the cover letter...


> 
> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> ---
>  arch/sparc/kernel/sys_sparc_32.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
> index 42b282f..7bf30de 100644
> --- a/arch/sparc/kernel/sys_sparc_32.c
> +++ b/arch/sparc/kernel/sys_sparc_32.c
> @@ -40,6 +40,11 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
>  {
>  	struct vm_area_struct * vmm;
>  
> +	if (len > TASK_SIZE - PAGE_SIZE)
> +		return -ENOMEM;
This is not the same as the check it replaces - what is going on here?

	Sam
