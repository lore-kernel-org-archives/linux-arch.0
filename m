From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 10 Jun 2008 12:19:34 -0700
Message-ID: <200806101219.34995.jbarnes@virtuousgeek.org>
References: <1211852026.3286.36.camel@pasglop> <1213121426.8536.7.camel@localhost.localdomain> <adaskvl3yb0.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-11.bluehost.com ([69.89.18.111]:54716 "HELO
	outbound-mail-11.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755240AbYFJTU3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jun 2008 15:20:29 -0400
In-Reply-To: <adaskvl3yb0.fsf@cisco.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Trent Piepho <tpiepho@freescale.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org

On Tuesday, June 10, 2008 12:05 pm Roland Dreier wrote:
>  > me too.  That's the whole basis for readX_relaxed() and its cohorts: we
>  > make our weirdest machines (like altix) conform to the x86 norm.  Then
>  > where it really kills us we introduce additional semantics to selected
>  > drivers that enable us to recover I/O speed on the abnormal platforms.
>
> Except as I pointed out before, Altix doesn't conform to the norm and
> many (most?) drivers are missing mmiowb()s that are needed for Altix.
> Just no one has plugged most devices into an Altix (or haven't stressed
> the driver in a way that exposes problems of IO ordering between CPUs).
>
> It would be a great thing to use the powerpc trick of setting a flag
> that is tested by spin_unlock()/mutex_unlock() and automatically doing
> the mmiowb() if needed, and then killing off mmiowb() entirely.

Yeah I think that's what Nick's guidelines would guarantee.  And Jes is 
already working on the spin_unlock change you mentioned, so mmiowb() should 
be history soon (in name only, assuming Nick also introduces the I/O barriers 
he talked about for ordering the looser accessors it would still be there but 
would be called io_wmb or something).

Jesse
