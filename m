Return-Path: <adsharma@sc.intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:41392 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261411AbUCATgm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Mar 2004 14:36:42 -0500
Date: Mon, 1 Mar 2004 11:33:08 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: SHMLBA and compat tasks
Message-ID: <20040301193308.GA13305@intel.com>
References: <20040228014128.GA6897@intel.com> <20040228155529.64bc0741.davem@redhat.com> <20040229021105.GA6964@intel.com> <20040229215752.3a6f0ce7.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229215752.3a6f0ce7.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Feb 29, 2004 at 09:57:52PM -0800, David S. Miller wrote:
> 
> Why don't we declare that SHM_LBA must be abided by on all platforms?

I assume you're proposing changing the man page to say that SHMLBA will
be forced, in all cases (even though SHM_RND is not specified). Yes,
that would make the implementation consistent with the man page, so it'd
be an improvement over the current situation.

But ia32 on ia64 doesn't match this declaration today.  

shmat(id, 0, ...) 

can return an address that's PAGE_SIZE aligned, but not SHMLBA
aligned. 

David, are you ok with changing this code to force SHMLBA alignment for 
both 32 and 64 bit tasks ?

	-Arun

arch/ia64/kernel/sys_ia64.c:

arch_get_unmapped_area(...)
{
...
       if (map_shared && (TASK_SIZE > 0xfffffffful))
                /*
                 * For 64-bit tasks, align shared segments to 1MB to avoid potential
                 * performance penalty due to virtual aliasing (see ASDM).  For 32-bit
                 * tasks, we prefer to avoid exhausting the address space too quickly by
                 * limiting alignment to a single page.
                 */
                align_mask = SHMLBA - 1;
