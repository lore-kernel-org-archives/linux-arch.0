Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:8129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264885AbUFOAZ4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2004 20:25:56 -0400
Date: Mon, 14 Jun 2004 17:20:22 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [RFC][PATCH 3/3] Convert console list to list_head
Message-Id: <20040614172022.57239426.davem@redhat.com>
In-Reply-To: <20040614140204.GC20511@parcelfarce.linux.theplanet.co.uk>
References: <20040614134502.C14403@flint.arm.linux.org.uk>
	<20040614134538.D14403@flint.arm.linux.org.uk>
	<20040614134623.E14403@flint.arm.linux.org.uk>
	<20040614140204.GC20511@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@debian.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 14 Jun 2004 15:02:04 +0100
Matthew Wilcox <willy@debian.org> wrote:

> This gets into one of the ugliest bits of the parisc patch that I haven't
> figured out how to do cleanly yet.  We have a firmware console (called
> PDC console) that may be printing to screen or serial.  The device
> that's being addressed might be on a PCI bus, so we can't print to it
> while we're walking the PCI busses.  We also can't use it after boot, or
> it'll fight with the serial driver.  So we have the following patch in our
> tree:

Thanks for mentioning this Matthew.  I never considered these kinds
of issues very much on Sparc although it might cause problems
for us too.

When we use the firmware console, it just outputs to whatever
device the firwmare has been configured to use (framebuffer,
serial, etc.) I think we are lucky because if the firmware allocates
resources for a PCI device, we never change things.
