Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3215 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbXFFWBO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2007 18:01:14 -0400
Date: Wed, 6 Jun 2007 23:01:03 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
Message-ID: <20070606220102.GB12482@flint.arm.linux.org.uk>
References: <20070606172409.6689.26641.stgit@localhost.localdomain> <20070606182914.GB6303@uranus.ravnborg.org> <20070606204748.GA12482@flint.arm.linux.org.uk> <20070606211042.GA7542@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070606211042.GA7542@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 06, 2007 at 11:10:42PM +0200, Sam Ravnborg wrote:
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
> 
> And btw. if arm in any way could benefit from using @function
> it is obvious why we should not split it up. Becasue this pathset
> did only add @function for one architecture.

The advantage is purely cosmetic for non-T2 ARM - it means that objdump
knows whether to disassemble stuff as code or data, which makes its
output very much easier to read.

Since it is merely cosmetic for non-T2, I've not been in a rush to
produce patches for it, but I've no objection to applying any such
patches during a merge window.  (I do have some open coded .type's
scattered around which should also be cleaned up at the same time,
particularly the head and entry code.)
