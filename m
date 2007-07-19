Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:39028 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbXGSUJY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2007 16:09:24 -0400
Date: Thu, 19 Jul 2007 21:08:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 055/209] define new percpu interface for shared data
Message-ID: <20070719200837.GA32040@flint.arm.linux.org.uk>
References: <200707190848.l6J8mCkl023086@imap1.linux-foundation.org> <20070719200253.GB15186@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070719200253.GB15186@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, fenghua.yu@intel.com, ak@suse.de, clameter@sgi.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, suresh.b.siddha@intel.com, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jul 19, 2007 at 10:02:53PM +0200, Sam Ravnborg wrote:
> On Thu, Jul 19, 2007 at 01:48:12AM -0700, akpm@linux-foundation.org wrote:
> > 
> > Moves the remotely accessed per cpu data (which is currently marked
> > as ____cacheline_aligned_in_smp) into a different section, where all the data
> > elements are cacheline aligned. And as such, this differentiates the local
> > only data and remotely accessed data cleanly.
> > 
> > --- a/arch/arm/kernel/vmlinux.lds.S~define-new-percpu-interface-for-shared-data-version-4
> > +++ a/arch/arm/kernel/vmlinux.lds.S
> > @@ -66,6 +66,7 @@ SECTIONS
> >  		. = ALIGN(4096);
> >  		__per_cpu_start = .;
> >  			*(.data.percpu)
> > +			*(.data.percpu.shared_aligned)
> >  		__per_cpu_end = .;
> >  #ifndef CONFIG_XIP_KERNEL
> >  		__init_begin = _stext;
> 
> Why is PERCPU not suitable for arm?

You can't put an output section inside an output section.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
