Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35673 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbEMIer (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 04:34:47 -0400
Date: Wed, 13 May 2015 10:34:41 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH] Documentation/arch: Add Documentation/arch-TODO
Message-ID: <20150513083441.GA17336@gmail.com>
References: <20150511192918.GA11361@jtriplet-mobl1>
 <20150512142250.dcb053da81855ae1b5861173@linux-foundation.org>
 <20150512213843.GV21418@twins.programming.kicks-ass.net>
 <20150512144910.0b49c9a7a13336773449db33@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150512144910.0b49c9a7a13336773449db33@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Josh Triplett <josh@joshtriplett.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Message-ID: <20150513083441.SYT8rWrqVxYOO1msaiFgROibnJXq5bUbaRQ0YeWTTkc@z>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 12 May 2015 23:38:43 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > with the expectation that other architectures will follow along, 
> > > but this doesn't happen.  The arch maintainers simply didn't 
> > > know about it or nobody nags them.  Nothing happens and 
> > > inconsistencies hang around for years.  eg, 
> > > http://lkml.iu.edu/hypermail/linux/kernel/1504.2/04993.html
> > > 
> > > I'm thinking we should find a way to do this better.  One way 
> > > might be to maintain a Documentation/arch-todo which identifies 
> > > each item, has a little list of what-to-do instructions and 
> > > perhaps a list of the not-yet-done architectures.  Basically a 
> > > way for everyone to communicate at the arch maintainers.
> > 
> > If only there was a linux-arch list to which arch maintainers 
> > should subscribe... oh wait :-)
> 
> It was I who got linux-arch established, so I'm fairly familiar with 
> it.  (12 years ago, gad).
> 
> I don't think it's been very successful, particularly for this 
> purpose. A whole pile of randomly cc'ed lkml overflow which we're 
> relying on each individual maintainer to sift through and pluck out 
> particular action items then later remember to implement them.  It's 
> disorganized and has too many cracks for things to fall through.

Yes, a mailing list is indeed not a very good TODO list.

We need a persistent post-it, and Documentation/arch-TODO (note the 
capital letters, we might as well shout?) sounds like a good place.

I'd suggest making it tabular, as per the patch below.

If it gets too large we can split it into multiple tables.

I'd like people to have a good look whether I messed up any entry, and 
I'd be happy to add new items as well.

Thanks,

	Ingo

=======================>
