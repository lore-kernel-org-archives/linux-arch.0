Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54870 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759449AbXFWQ5H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 23 Jun 2007 12:57:07 -0400
Date: Sat, 23 Jun 2007 09:55:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PARISC] Handle wrapping in expand_upwards()
Message-Id: <20070623095548.a7117833.akpm@linux-foundation.org>
In-Reply-To: <20070621091104.GA10043@fattire.cabal.ca>
References: <20070621091104.GA10043@fattire.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, torvalds@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

> On Thu, 21 Jun 2007 05:11:04 -0400 Kyle McMartin <kyle@parisc-linux.org> wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Function expand_upwards() did not guarded against wrapping
> around to address 0. This fixes the adjtimex02 testcase from
> the Linux Test Project on a 32bit PARISC kernel.
> 
> [expand_upwards is only used on parisc and ia64; it looks like it does
>  the right thing on both. --kyle]
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
> ---
> 
> Index: linux-2.6/mm/mmap.c
> ===================================================================
> --- linux-2.6.orig/mm/mmap.c	2007-05-19 13:30:10.000000000 -0400
> +++ linux-2.6/mm/mmap.c	2007-06-21 05:18:46.000000000 -0400
> @@ -1536,9 +1536,14 @@
>  	 * vma->vm_start/vm_end cannot change under us because the caller
>  	 * is required to hold the mmap_sem in read mode.  We need the
>  	 * anon_vma lock to serialize against concurrent expand_stacks.
> +	 * Also guard against wrapping around to address 0.
>  	 */
> -	address += 4 + PAGE_SIZE - 1;
> -	address &= PAGE_MASK;
> +	if (address < PAGE_ALIGN(address+4))
> +		address = PAGE_ALIGN(address+4);
> +	else {
> +		anon_vma_unlock(vma);
> +		return -ENOMEM;
> +	}
>  	error = 0;
>  

You did't really provide enough information for us to be able to decide
whether this change is needed in 2.6.22, let alone 2.6.21.

I will magically infer from your To: line that you consider it 2.6.22
material, but if so I think that we'll need suitable reviewing, testing and
acking from Tony, please.  If he's offline (ols, perhaps?) then we might
have a problem.  Perhaps find a suitable ia64-enabled alternate?


As for 2.6.21: I'll assume it's needed there as well.  Please advise if
otherwise.

