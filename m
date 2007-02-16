Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54073 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946145AbXBPUn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Feb 2007 15:43:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] killing the NR_IRQS arrays.
Date: Fri, 16 Feb 2007 21:43:24 +0100
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com> <200702162045.58857.arnd@arndb.de> <20070216195256.GE2572@flint.arm.linux.org.uk>
In-Reply-To: <20070216195256.GE2572@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200702162143.25130.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>

On Friday 16 February 2007 20:52, Russell King wrote:
> On Fri, Feb 16, 2007 at 08:45:58PM +0100, Arnd Bergmann wrote:
> > We did something like this a few years back on the s390 architecture, which
> > happens to be lucky enough not to share any interrupt based drivers with
> > any of the other architectures.
> 
> What you're proposing is looking similar to a proposal I put forward some
> 4 years ago, but was rejected.  Maybe times have changed and there's a
> need for it now.

Yes, I think times have changed, with the increased popularity of MSI
and paravirtualized devices. A few points on your old proposal though:

- Doing it per architecture no longer sounds feasible, I think it would
  need to be done per subsystem so that the drivers can be adapted to
  a new interface, and most drivers are used across multiple architectures.
- struct irq sounds much more fitting than struct irq_desc
- creating new irq_foo() functions to replace foo_irq() also sounds right.
- I don't see the point in splitting request_irq into irq_request and
  irq_register.
- doing subsystem specific abstractions ideally allows the drivers to
  not even need to worry about the irq pointer, significantly simplifying
  the interface for register/unregister.

	Arnd <><
