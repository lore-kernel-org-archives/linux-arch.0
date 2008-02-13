Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55011
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1763655AbYBMAfw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 19:35:52 -0500
Date: Tue, 12 Feb 2008 16:36:23 -0800 (PST)
Message-Id: <20080212.163623.132476636.davem@davemloft.net>
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LFD.1.00.0802121051341.2920@woody.linux-foundation.org>
References: <1202840682.3137.83.camel@localhost.localdomain>
	<alpine.LFD.1.00.0802121037340.2920@woody.linux-foundation.org>
	<alpine.LFD.1.00.0802121051341.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: James.Bottomley@HansenPartnership.com, jeff@garzik.org, arjan@infradead.org, greg@kroah.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Feb 2008 10:59:00 -0800 (PST)

> That sure as hell would put the pain on API changes solidly where it
> belongs.

If a person does a driver API change and does all the work to sweep
the entire tree updating all the drivers, doesn't it penalize that
person a bit much to stick a new driver in front of that work?

People write code on top of infrastructure, both new and old, not the
other way around.  At least to me, that seems how the merging ought to
work too.
