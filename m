Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:33399 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964903AbXFFVfo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2007 17:35:44 -0400
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
From: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20070606211042.GA7542@uranus.ravnborg.org>
References: <20070606172409.6689.26641.stgit@localhost.localdomain>
	 <20070606182914.GB6303@uranus.ravnborg.org>
	 <20070606204748.GA12482@flint.arm.linux.org.uk>
	 <20070606211042.GA7542@uranus.ravnborg.org>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 22:19:07 +0100
Message-Id: <1181164747.27659.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-06-06 at 23:10 +0200, Sam Ravnborg wrote:
> On Wed, Jun 06, 2007 at 09:47:49PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jun 06, 2007 at 08:29:14PM +0200, Sam Ravnborg wrote:
> > > #define FUNCTION(name)   .type name, %function
> > > Introducing this simple macro in the generic ARM codebase would
> > > bring down the diff significantly
> > 
> > We have such a macro already - ENDPROC().  Recently introduced,
> > we should probably make more use of it.
> Took a short look at include/linux/linkage.h
> There is also ENTRY() that seems resonable to introduce.

The problem is that ENTRY is not used for functions only (I tried this
initially). The linker needs to know which .globl object is a function
because the Thumb-2 function addresses used in branch instructions have
bit 0 set (even if the address is 2 bytes aligned).

-- 
Catalin

