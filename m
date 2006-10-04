Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:24002 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161070AbWJDDOs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2006 23:14:48 -0400
Subject: Re: [PATCH] update generic irq for parisc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1157827893.3462.19.camel@mulgrave.il.steeleye.com>
References: <1157827893.3462.19.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 13:14:38 +1000
Message-Id: <1159931678.8469.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2006-09-09 at 13:51 -0500, James Bottomley wrote:
> We have had a specific problem with the current generic linux IRQ code
> for ages, in that indirection via function pointers is horribly
> expensive for us (basically, the CPU pipes stall).  We'd like to use the
> new genirq infrastructure to mitigate some of the problem.
> 
> I didn't want simply to move the irq handlers back into our arch code
> again, since that would remove all the benefits of common handling code.
> What I did was template out the common code in a way that keeps it
> common but allows an architecture to modify it (for us to put our acks
> and eoi's in as functions instead of function pointers).
> 
> If everyone is OK with this, I'll introduce a new type of interrupt with
> a specific handler (so for our heavily called interrupts like timer and
> IPI we don't even need to indirect through action->handler()).

I don't have any objection to this patch as long as the current
behaviour with function pointers still works fine (which seems to be the
case from a quick look through the patch). On PowerPC, we have a huge
variety of interrupt controllers and cascaded controllers and thus we
can't really apply your shortcut.

Ben.


