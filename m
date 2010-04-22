From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 02/14] avr32: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:45:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221345350.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161222.953856396@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:28113 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758617Ab0DVUqI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:46:08 -0400
Received: from kpbe12.cbf.corp.google.com (kpbe12.cbf.corp.google.com [172.25.105.76])
	by smtp-out.google.com with ESMTP id o3MKk663004042
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 22:46:06 +0200
Received: from pvh1 (pvh1.prod.google.com [10.241.210.193])
	by kpbe12.cbf.corp.google.com with ESMTP id o3MKjp6I032196
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:46:05 -0700
Received: by pvh1 with SMTP id 1so753492pvh.33
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:46:04 -0700 (PDT)
In-Reply-To: <20100422161222.953856396@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/arch/avr32/mm/fault.c
> ===================================================================
> --- linux-2.6.orig/arch/avr32/mm/fault.c
> +++ linux-2.6/arch/avr32/mm/fault.c
> @@ -211,15 +211,10 @@ no_context:
>  	 */
>  out_of_memory:
>  	up_read(&mm->mmap_sem);
> -	if (is_global_init(current)) {
> -		yield();
> -		down_read(&mm->mmap_sem);
> -		goto survive;
> -	}
> -	printk("VM: Killing process %s\n", tsk->comm);
> -	if (user_mode(regs))
> -		do_group_exit(SIGKILL);
> -	goto no_context;
> +	pagefault_out_of_memory();
> +	if (!user_mode(regs))
> +		goto no_context;

We want to test for !user_mode(regs) before calling 
pagefault_out_of_memory().

> +	return;
>  
>  do_sigbus:
>  	up_read(&mm->mmap_sem);
