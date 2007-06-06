Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:58355 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765392AbXFFVJk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Jun 2007 17:09:40 -0400
Date: Wed, 6 Jun 2007 23:10:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
Message-ID: <20070606211042.GA7542@uranus.ravnborg.org>
References: <20070606172409.6689.26641.stgit@localhost.localdomain> <20070606182914.GB6303@uranus.ravnborg.org> <20070606204748.GA12482@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070606204748.GA12482@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 06, 2007 at 09:47:49PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 06, 2007 at 08:29:14PM +0200, Sam Ravnborg wrote:
> > #define FUNCTION(name)   .type name, %function
> > Introducing this simple macro in the generic ARM codebase would
> > bring down the diff significantly
> 
> We have such a macro already - ENDPROC().  Recently introduced,
> we should probably make more use of it.
Took a short look at include/linux/linkage.h
There is also ENTRY() that seems resonable to introduce.

And btw. if arm in any way could benefit from using @function
it is obvious why we should not split it up. Becasue this pathset
did only add @function for one architecture.

	Sam
