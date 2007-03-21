Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:57851 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbXCUXAK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Mar 2007 19:00:10 -0400
Date: Wed, 21 Mar 2007 15:59:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + move-die-notifier-handling-to-common-code.patch added to -mm
 tree
Message-Id: <20070321155953.6352e29f.akpm@linux-foundation.org>
In-Reply-To: <20070321221748.GD28239@flint.arm.linux.org.uk>
References: <200703212211.l2LMB08x005006@shell0.pdx.osdl.net>
	<20070321221748.GD28239@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: hch@lst.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Mar 2007 22:17:48 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> On Wed, Mar 21, 2007 at 03:11:00PM -0700, akpm@linux-foundation.org wrote:
> > ------------------------------------------------------
> > Subject: move die notifier handling to common code
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > This patch moves the die notifier handling to common code.  Previous
> > various architectures had exactly the same code for it.  Note that the new
> > code is compiled unconditionally, this should be understood as an appel to
> > the other architecture maintainer to implement support for it aswell (aka
> > sprinkling a notify_die or two in the proper place)
> > 
> > arm had a notifiy_die that did something totally different, I renamed it to
> > arm_notify_die as part of the patch and made it static to the file it's
> > declared and used at.  avr32 used to pass slightly less information through
> > this interface and I brought it into line with the other architectures.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Cc: <linux-arch@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> NAK.  This will, as seems to be the current favourite past time, break
> ARM.  A simple grep command will show why; I leave it as an exercise for
> those to run this command to discover the details.
> 
> $ grep notify_die arch/arm -r

There seems to be one missed conversion in
arch/arm/mm/fault.c:do_DataAbort().  If that's not what you mean then
perhaps you can give us another hint.

I'm not presently cross-building ARM due to utrace.
