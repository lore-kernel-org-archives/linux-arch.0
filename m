Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37582 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933502AbXHOSoU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2007 14:44:20 -0400
Date: Wed, 15 Aug 2007 19:43:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFP] atomic[64]_[read|set] asm implementations
Message-ID: <20070815184359.GA7300@flint.arm.linux.org.uk>
References: <46C33E19.3050805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46C33E19.3050805@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 15, 2007 at 01:55:37PM -0400, Chris Snook wrote:
> For architectures whose maintainers aren't worried and whose 
> developers/users aren't bothered enough to submit an inline assembly 
> patch, I'll just keep the inlines with the *(volatile foo *)& casts, 
> unless of course ISO clarifies the C standard to different effect while 
> we're arguing over semantics and micro-optimizations.

I have no problem with your latest patch for ARM.  Moving ARM to
assembly will actually remove some information which the compiler
has when it knows about the access to be performed.

If atomic_read() were converted to inline assembly, we'd prevent the
compiler from knowing that a load has been performed and it should
therefore avoid using the result of the load where possible for the
following few instructions (due to result delays.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
