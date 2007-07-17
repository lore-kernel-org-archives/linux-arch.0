Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48589 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753729AbXGQTIk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Jul 2007 15:08:40 -0400
Date: Tue, 17 Jul 2007 12:08:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
Message-Id: <20070717120820.86a50e75.akpm@linux-foundation.org>
In-Reply-To: <20070717181843.GB16147@flint.arm.linux.org.uk>
References: <200707170748.l6H7m1so005969@imap1.linux-foundation.org>
	<20070717005551.cdb9504e.akpm@linux-foundation.org>
	<20070717010324.833fee7e.akpm@linux-foundation.org>
	<1184680583.21357.67.camel@localhost>
	<20070717181843.GB16147@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, 17 Jul 2007 19:18:43 +0100 Russell King <rmk@arm.linux.org.uk> wrote:

> On Tue, Jul 17, 2007 at 03:56:23PM +0200, Martin Schwidefsky wrote:
> > On Tue, 2007-07-17 at 01:03 -0700, Andrew Morton wrote:
> > > OK, I don't understand how this patch works - from a quick glance it
> > > appears to be forgetting to flush stuff altogether on arm and arm26 at
> > > least and I see no sign that Russell, Tony and Ian have even seen it.
> > 
> > Added linux-arch so that affected arch-maintainers can comment.
> 
> Having a little more information about Andrew's concern would be nice.
> Under what circumstances do you think we're forgetting to flush stuff?
> 

"quick glance".  ARM's tlb_flush_mmu() becomes a no-op and I though that
some real tlb_finish_mmu() got replaced by that.  But I didn't look very
closely.
