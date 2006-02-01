Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57352 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750724AbWBAIcu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Feb 2006 03:32:50 -0500
Date: Wed, 1 Feb 2006 08:32:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Fw: [PATCH] abstract type/size specification for assembly
Message-ID: <20060201083243.GB24893@flint.arm.linux.org.uk>
References: <20060131143149.35db2e02.akpm@osdl.org> <200602010836.09932.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602010836.09932.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 01, 2006 at 08:36:09AM +0100, Andi Kleen wrote:
> On Tuesday 31 January 2006 23:31, Andrew Morton wrote:
> > 
> > OK?
> 
> Yes.

No.

> > +#define ENDPROC(name) \
> > +  .type name, @function; \
> > +  END(name)
> > +#define END(name) \
> > +  .size name, .-name

@ is the comment character on ARM, so this can't go here - we use

	.type name, %function

instead.  Interestingly, the info pages for as seem to indicate that
there's a number of alternatives - maybe the most benign one should
be used, iow:

	.type name, "function"

or alternatively make ENDPROC arch-overridable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
