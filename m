From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix ARM PIC problems with new decompressor code
Date: Tue, 2 Mar 2010 14:43:04 -0800
Message-ID: <20100302144304.928df4c5.akpm@linux-foundation.org>
References: <20100226081926.GA3511@flint.arm.linux.org.uk>
	<4B87907B.7080008@knaff.lu>
	<20100228154908.GB11343@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55375 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab0CBWnP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2010 17:43:15 -0500
In-Reply-To: <20100228154908.GB11343@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alain Knaff <alain@knaff.lu>, linux-arch@vger.kernel.org

On Sun, 28 Feb 2010 15:49:08 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> On Fri, Feb 26, 2010 at 10:12:27AM +0100, Alain Knaff wrote:
> > Yes, that should be fine. So it would be static in full kernel context
> > (initrd decompression) but global in preboot. As long as it doesn't clash
> > with other variables of the same name, but I think that's rather unlikely
> > in the "small" preboot environment.
> 
> Here's a patch to this end.  I decided to change the name of the
> define to something more sensible.
> 
> Are we happy with this?  Shall I queue it for merging?

I grabbed it, but you can preempt that by merging it if that's more
convenient.

>  I'd be nice
> to get this into -stable as well as some other fixes for this feature.
> 

I don't think I've seen any other fixes.
