Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58875 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753749AbYBMCfj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 21:35:39 -0500
Date: Tue, 12 Feb 2008 18:35:12 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
In-Reply-To: <1202869550.3137.182.camel@localhost.localdomain>
Message-ID: <alpine.LFD.1.00.0802121832000.2920@woody.linux-foundation.org>
References: <47B1CB08.4020101@garzik.org>  <20080212.155853.193190548.davem@davemloft.net>  <alpine.LFD.1.00.0802121610220.2920@woody.linux-foundation.org>  <20080212.172051.58554658.davem@davemloft.net> <1202869550.3137.182.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Miller <davem@davemloft.net>, jeff@garzik.org, arjan@infradead.org, greg@kroah.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org



On Tue, 12 Feb 2008, James Bottomley wrote:
> 
> Yes, this is exactly the feature I'm looking for.  It would allow the
> downstream users of a rebased tree to rebase themselves correctly.
> 
> All the information about the rebase is in the reflog ... it can't be
> too difficult to pass it through on a pull and allow the downstream tree
> to do the right thing.

Guys, you simply have no idea what you're talking about.

Those downstream trees can have done things themselves. They *depended* on 
the state you gave them.

You can't just say "oops, I lied, this is the state you should have used, 
now it's _your_ mess to sort out".

OF COURSE it's what you'd like to use - it absolves you of any and all 
actual responsibility. But dammit, that's not what anybody else wants than 
the irresponsible person who cannot be bothered to stand up for his work!

If you're not confident enough about your work, don't push it out! It's 
that simple. Pushing out to a public branch is a small "release".

Have the f*cking back-bone to be able to stand behind what you did!

		Linus
