Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:54230 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbXKTQ6O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Nov 2007 11:58:14 -0500
Date: Tue, 20 Nov 2007 09:58:12 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Message-ID: <20071120165812.GH12494@parisc-linux.org>
References: <20071120160220.GA22196@wotan.suse.de> <4680.1195577182@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4680.1195577182@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Nov 20, 2007 at 04:46:22PM +0000, David Howells wrote:
> > The best way to do this is with
> > +io_lock and io_unlock barriers, which directs the critical section to order
> > +IO access as well. For example:
> 
> Should there be a spin_lock_io() for example?

Then we need ...

spin_lock_irqsave_io()
spin_lock_irq_io()
spin_lock_bh_io()

spin_trylock_io()
spin_trylock_irqsave_io()
spin_trylock_irq_io()
spin_trylock_bh_io()

ditto with write_ and read_.  Maybe double_spin_lock_io too.  That's an
extra 25 primitives (oh, plus the unlocks; 28).

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
