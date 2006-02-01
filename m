Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21264 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932421AbWBAJJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Feb 2006 04:09:44 -0500
Date: Wed, 1 Feb 2006 09:09:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Fw: [PATCH] abstract type/size specification for assembly
Message-ID: <20060201090938.GA27735@flint.arm.linux.org.uk>
References: <20060131143149.35db2e02.akpm@osdl.org> <200602010836.09932.ak@suse.de> <20060201083243.GB24893@flint.arm.linux.org.uk> <200602010949.19428.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602010949.19428.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 01, 2006 at 09:49:18AM +0100, Andi Kleen wrote:
> On Wednesday 01 February 2006 09:32, Russell King wrote:
> 
> > @ is the comment character on ARM, so this can't go here - we use
> > 
> > 	.type name, %function
> > 
> > instead.  Interestingly, the info pages for as seem to indicate that
> > there's a number of alternatives - maybe the most benign one should
> > be used, iow:
> > 
> > 	.type name, "function"
> > 
> > or alternatively make ENDPROC arch-overridable.
> 
> Actually it could be just per architecture. Or do you see ARM specific
> assembly code using ENDPROC() any time soon? And there are no portable
> assembly files.

I do have a number of .type and .size stuff in the ARM assembly files -
it aids objdump in working out whether it should dump the contents as
data or code.  IOW, it might be useful to have.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
