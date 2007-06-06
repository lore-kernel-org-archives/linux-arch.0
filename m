Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2548 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933546AbXFFWEl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2007 18:04:41 -0400
Date: Wed, 6 Jun 2007 23:04:34 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
Message-ID: <20070606220434.GC12482@flint.arm.linux.org.uk>
References: <20070606172409.6689.26641.stgit@localhost.localdomain> <20070606182914.GB6303@uranus.ravnborg.org> <20070606204748.GA12482@flint.arm.linux.org.uk> <20070606211042.GA7542@uranus.ravnborg.org> <1181164747.27659.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1181164747.27659.7.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 06, 2007 at 10:19:07PM +0100, Catalin Marinas wrote:
> On Wed, 2007-06-06 at 23:10 +0200, Sam Ravnborg wrote:
> > On Wed, Jun 06, 2007 at 09:47:49PM +0100, Russell King - ARM Linux wrote:
> > > On Wed, Jun 06, 2007 at 08:29:14PM +0200, Sam Ravnborg wrote:
> > > > #define FUNCTION(name)   .type name, %function
> > > > Introducing this simple macro in the generic ARM codebase would
> > > > bring down the diff significantly
> > > 
> > > We have such a macro already - ENDPROC().  Recently introduced,
> > > we should probably make more use of it.
> > Took a short look at include/linux/linkage.h
> > There is also ENTRY() that seems resonable to introduce.
> 
> The problem is that ENTRY is not used for functions only (I tried this
> initially). The linker needs to know which .globl object is a function
> because the Thumb-2 function addresses used in branch instructions have
> bit 0 set (even if the address is 2 bytes aligned).

Not suggesting we change ENTRY - that'd be bad.  Just add the relevant
sprinkling of END and ENDPROC statements in the assembly code (which
will add the .size for everything, and .type for functions.)

As I say, for existing ARM support it's merely cosmetic which is why
there isn't a rush to do it yet, but if it's needed for T2 there's no
reason not to.
