Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:59402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1753898AbWKGJgy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Nov 2006 04:36:54 -0500
Date: Tue, 7 Nov 2006 09:36:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Which architectures need 64-bit resources?
Message-ID: <20061107093641.GA2570@flint.arm.linux.org.uk>
References: <20061106122337.GK27140@parisc-linux.org> <20061106160206.GA10447@linux-mips.org> <20061106163243.GN27140@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106163243.GN27140@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Nov 06, 2006 at 09:32:43AM -0700, Matthew Wilcox wrote:
> On Mon, Nov 06, 2006 at 04:02:06PM +0000, Ralf Baechle wrote:
> > On Mon, Nov 06, 2006 at 05:23:37AM -0700, Matthew Wilcox wrote:
> > 
> > > +       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && (ARM || X86 || MIPS || PPC) && EXPERIMENTAL)
> > 
> > For MIPS at least it would be needed for a few platforms only, so I'd
> > like to do "select RESOURCES_64BIT" as suitable for a platform. in the
> > big machine selection menu in arch/mips/Kconfig.
> 
> I don't see why you shouldn't do that anyway ... seems like ARM wants to
> do the same thing.  In fact, I'd go so far as to say this isn't an option
> that users should ever be asked.  You can tell by the help text for it:

For the ARM bits...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
