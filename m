From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 06/14] m32r: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:52:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221352000.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161223.608103837@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:30453 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab0DVUw6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:52:58 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [10.3.21.3])
	by smtp-out.google.com with ESMTP id o3MKqrmj014363
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 22:52:53 +0200
Received: from pxi17 (pxi17.prod.google.com [10.243.27.17])
	by hpaq3.eem.corp.google.com with ESMTP id o3MKqptZ009892
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 22:52:52 +0200
Received: by pxi17 with SMTP id 17so742172pxi.19
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:52:51 -0700 (PDT)
In-Reply-To: <20100422161223.608103837@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-m32r@ml.linux-m32r.org, Hirokazu Takata <takata@linux-m32r.org>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: Hirokazu Takata <takata@linux-m32r.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/arch/m32r/mm/fault.c
> ===================================================================
> --- linux-2.6.orig/arch/m32r/mm/fault.c
> +++ linux-2.6/arch/m32r/mm/fault.c
> @@ -271,15 +271,10 @@ no_context:
>   */
>  out_of_memory:
>  	up_read(&mm->mmap_sem);
> -	if (is_global_init(tsk)) {
> -		yield();
> -		down_read(&mm->mmap_sem);
> -		goto survive;
> -	}
> -	printk("VM: killing process %s\n", tsk->comm);
>  	if (error_code & ACE_USERMODE)

This should be !(error_code & ACE_USERMODE) instead.

> -		do_group_exit(SIGKILL);
> -	goto no_context;
> +		goto no_context;
> +	pagefault_out_of_memory();
> +	return;
>  
>  do_sigbus:
>  	up_read(&mm->mmap_sem);
> 
> 
> 
