Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S265287AbUHYWmj@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:19097 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266201AbUHYWk5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 18:40:57 -0400
Date: Wed, 25 Aug 2004 15:40:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/8] signal handling race fix
In-Reply-To: <200408252140.i7PLeL131496@mail.osdl.org>
Message-ID: <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 25 Aug 2004 akpm@osdl.org wrote:
> 
> The patch:
> 
>   You have to get the sigaction information that will be delivered while
>   holding sighand->siglock in get_signal_to_deliver().

I'm ok with the patch, but I _hate_ the renaming of "ka" to "ka_copy". 
There's no real point except for the initial change (to make sure the 
compiler warns about any missed entries), and once that has been done it 
just makes the patches horribly noisy and not at all more readable.

As far as I can tell, the patch would be just a few lines long without 
that renaming. Can we _please_ reconsider?

Oh, and ia64 suddenly does the "force_sigsegv()" right, while at least the 
regular x86 port is not fixed. Shouldn't we just do the "force_sigsegv()" 
right for everybody, and put that one into kernel/signal.c?

What do you guys say?

		Linus
