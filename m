Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266617AbUHYXrt@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:24013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266525AbUHYXpY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 19:45:24 -0400
Date: Wed, 25 Aug 2004 16:49:00 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/8] signal handling race fix
Message-Id: <20040825164900.727422e1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
	<Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Wed, 25 Aug 2004 akpm@osdl.org wrote:
> > 
> > The patch:
> > 
> >   You have to get the sigaction information that will be delivered while
> >   holding sighand->siglock in get_signal_to_deliver().
> 
> I'm ok with the patch, but I _hate_ the renaming of "ka" to "ka_copy". 
> There's no real point except for the initial change (to make sure the 
> compiler warns about any missed entries), and once that has been done it 
> just makes the patches horribly noisy and not at all more readable.

OK, I edited all the diffs.  I'll let this cook for a bit longer.

> Oh, and ia64 suddenly does the "force_sigsegv()" right, while at least the 
> regular x86 port is not fixed. Shouldn't we just do the "force_sigsegv()" 
> right for everybody, and put that one into kernel/signal.c?

hm.  What does "right" mean?  It newly takes that lock, and cleans things
up a bit.  And it adds two different implementations of force_sigsegv().

This an area in which I do not normally dabble...
