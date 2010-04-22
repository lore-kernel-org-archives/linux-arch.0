From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 11/14] powerpc: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 14:44:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221442590.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161224.465958039@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:60211 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0DVVod (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 17:44:33 -0400
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id o3MLiQMs014683
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 14:44:26 -0700
Received: from pwi6 (pwi6.prod.google.com [10.241.219.6])
	by wpaz9.hot.corp.google.com with ESMTP id o3MLiP2e018226
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 14:44:25 -0700
Received: by pwi6 with SMTP id 6so5895066pwi.4
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 14:44:25 -0700 (PDT)
In-Reply-To: <20100422161224.465958039@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linuxppc-dev@ozlabs.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/arch/powerpc/mm/fault.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/mm/fault.c
> +++ linux-2.6/arch/powerpc/mm/fault.c
> @@ -359,15 +359,10 @@ bad_area_nosemaphore:
>   */
>  out_of_memory:
>  	up_read(&mm->mmap_sem);
> -	if (is_global_init(current)) {
> -		yield();
> -		down_read(&mm->mmap_sem);
> -		goto survive;
> -	}
> -	printk("VM: killing process %s\n", current->comm);
> -	if (user_mode(regs))
> -		do_group_exit(SIGKILL);
> -	return SIGKILL;
> +	if (!user_mode(regs))
> +		return SIGKILL;
> +	pagefault_out_of_memory();
> +	return 0;

Do we really want to return 0 and indicate that the fault was handled?  It 
seems more consistent to do

	if (user_mode(regs))
		pagefault_out_of_memory();
	return SIGKILL;
