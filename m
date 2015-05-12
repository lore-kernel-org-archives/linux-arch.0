Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33114 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932995AbbELVtM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 May 2015 17:49:12 -0400
Date: Tue, 12 May 2015 14:49:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv2 1/2] clone: Support passing tls argument via C rather
 than pt_regs magic
Message-ID: <20150512144910.0b49c9a7a13336773449db33@linux-foundation.org>
In-Reply-To: <20150512213843.GV21418@twins.programming.kicks-ass.net>
References: <20150511192918.GA11361@jtriplet-mobl1>
	<20150512142250.dcb053da81855ae1b5861173@linux-foundation.org>
	<20150512213843.GV21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150512214910.4db_LdGWNCy1ogqZw3PJOHvfr7oL9cpT8-PzxEgRPA0@z>

On Tue, 12 May 2015 23:38:43 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> > What happens quite frequently is that we do something for x86 with the
> > expectation that other architectures will follow along, but this
> > doesn't happen.  The arch maintainers simply didn't know about it or
> > nobody nags them.  Nothing happens and inconsistencies hang around for
> > years.  eg, http://lkml.iu.edu/hypermail/linux/kernel/1504.2/04993.html
> > 
> > I'm thinking we should find a way to do this better.  One way might be
> > to maintain a Documentation/arch-todo which identifies each item, has a
> > little list of what-to-do instructions and perhaps a list of the
> > not-yet-done architectures.  Basically a way for everyone to
> > communicate at the arch maintainers.
> 
> If only there was a linux-arch list to which arch maintainers should
> subscribe... oh wait :-)

It was I who got linux-arch established, so I'm fairly familiar with
it.  (12 years ago, gad).

I don't think it's been very successful, particularly for this purpose.
A whole pile of randomly cc'ed lkml overflow which we're relying on each
individual maintainer to sift through and pluck out particular action
items then later remember to implement them.  It's disorganized and has
too many cracks for things to fall through.


