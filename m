Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55004
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754342AbYBMAc4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 19:32:56 -0500
Date: Tue, 12 Feb 2008 16:33:28 -0800 (PST)
Message-Id: <20080212.163328.210878831.davem@davemloft.net>
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LFD.1.00.0802121037340.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802120945290.2920@woody.linux-foundation.org>
	<1202840682.3137.83.camel@localhost.localdomain>
	<alpine.LFD.1.00.0802121037340.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: James.Bottomley@HansenPartnership.com, jeff@garzik.org, arjan@infradead.org, greg@kroah.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Feb 2008 10:48:38 -0800 (PST)

> On Tue, 12 Feb 2008, James Bottomley wrote:
> > Yes ... I don't do that ... Like I said, I only rebase for an actual
> > conflict.
> 
> And this is how things should work. 

And if conflicts happen every day, what should someone do?

This isn't fantasy, that's exactly how things got with the
networking tree near the end of 2.6.24.
