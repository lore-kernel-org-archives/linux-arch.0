Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.impinj.com ([206.169.229.170]:47182 "EHLO earth.impinj.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751577AbZCBSwX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Mar 2009 13:52:23 -0500
From: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 10:45:20 -0800
References: <1235996477.5330.174.camel@laptop> <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200903021045.20723.vlobanov@speakeasy.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20090302184520.LIfVZOPxxjIzBj5DYoMFIriX68RQgIu-YDpl7T7he60@z>

On Monday 02 March 2009 09:11:54 Linus Torvalds wrote:
> The thing is, with PIO, a 512-byte disk read ends up doing 256 16-bit word
> reads from the controller, each potentially up to 600ns long (PIO0
> timings). That's 150ms - for a single sector!

Out of curiosity, the peanut gallery wishes to ask:
Is the above supposed to be 600us (*1000), or 150us (/1000)? Probably the 
latter.

> For example, Mode2 timings are probably still something we should consider
> realistic, and that's 240ns per word - a single sector now takes ~60ms to
> read off the disk.

Same factor of 1000 question here.

> And we don't do single sectors. Most transfers will be 8 sectors (4k
> contiguos read). So now that 60ms is 480ms per such IDE interrupt. And
> even with the _good_ timings, we're certainly looking at a reduction of
> that to about half.
>
> Imagine what happens when we have interrupts disabled for half a second at
> a time.

-- Vadim Lobanov

