From: David Brownell <david-b@pacbell.net>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 14:46:45 -0700
Message-ID: <200808151446.45855.david-b@pacbell.net>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815115308.GA24513@flint.arm.linux.org.uk> <20080815123848.GN16231@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:42551 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754230AbYHOVqs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Aug 2008 17:46:48 -0400
In-Reply-To: <20080815123848.GN16231@frodo>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Friday 15 August 2008, Felipe Balbi wrote:
> So I think until we have a better solution we'll need the attached patch
> to musb_io.h

Probably worth adding AVR32 to the list too.  I happened to
enable musb during avr32 test build; it kablooied there too,
but behaves given the CONFIG_AVR32 #ifdef.

The existing #ifdef was sufficient to get a clean x86 build,
given basic <linux/clk.h> support.  Someone wanting to see this
driver work on the PCI (FPGA?) incarnation of this IP will
have to solve that problem too.

- Dave
