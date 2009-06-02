From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 22:48:40 +0100
Message-ID: <20090602214840.GB10800@flint.arm.linux.org.uk>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com> <20090602211057.GA10800@flint.arm.linux.org.uk> <20090602214005.GL32630@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60000 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbZFBVtc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 17:49:32 -0400
Content-Disposition: inline
In-Reply-To: <20090602214005.GL32630@pengutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>

On Tue, Jun 02, 2009 at 11:40:05PM +0200, Robert Schwebel wrote:
> And even with the cpu core, we usually build kernels with optimized
> toolchains for their cpu family.

I'm afraid that doesn't make a blind bit of difference to the kernel -
it passes the relevent optimization flags to gcc which tell the compiler
which instructions to use (based upon the CPU architecture) and how to
schedule those instructions (based upon the CPU type(s) chosen in the
kernel configuration.)

All that an "optimized" toolchain is is a toolchain with a different
default optimization selected.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
