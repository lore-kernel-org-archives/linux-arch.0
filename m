From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 22:10:58 +0100
Message-ID: <20090602211057.GA10800@flint.arm.linux.org.uk>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42566 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZFBVLY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 17:11:24 -0400
Content-Disposition: inline
In-Reply-To: <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>

On Tue, Jun 02, 2009 at 11:29:46AM -0600, Grant Likely wrote:
> Embedded PowerPC and Microblaze has tackled this problem with the
> "Flattened Device Tree" data format which is derived from the
> OpenFirmware specifications, and there is some interest and debate (as
> discussed recently on the ARM mailing list) about making flattened
> device tree usable by ARM also (which I'm currently
> proof-of-concepting).

Note that I have to point out that ARM will probably never be in a
situation where you can have a one kernel image boots on everything.
That _is_ practical today (and does happen with all PXA now) with what
we have within a very big restriction - which is that the kernel must
be built to support PXA and not Atmel SoCs.

I really don't think combining SoC support is going to be realistic,
device tree or not.  When we had just four machine types (RiscPC,
EBSA110, EBSA285, Netwinder) I did look into this and came to the
conclusion that it would be far too inefficient for there to be any
win.

The big problem we have is that the only commonality between different
SoCs is that the CPU executes ARM instructions.  Everything else is
entirely up to the SoC designer - eg location of memory, spacing of
memory banks, type of interrupt controller, etc is all highly SoC
specific.  Nothing outside of the ARM CPU itself is standardized.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
