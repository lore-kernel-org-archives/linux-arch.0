From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Thu, 1 Apr 2010 13:12:36 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004011310210.3707@i5.linux-foundation.org>
References: <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org> <4BB3B4DB.7040904@kernel.org> <20100331135220.c6695a51.akpm@linux-foundation.org> <4BB3BAD6.50308@zytor.com> <alpine.LFD.2.00.1004010904540.3707@i5.linux-foundation.org>
 <20100401102744.a4e6f24d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37105 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758775Ab0DAURu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2010 16:17:50 -0400
In-Reply-To: <20100401102744.a4e6f24d.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, cl@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>



On Thu, 1 Apr 2010, Andrew Morton wrote:
>
> > So making the slow-path do the spin_[un]lock_irq{save,restore}() versions 
> > sounds like the right thing. It won't be a performance issue: it _is_ the 
> > slow-path, and we're already doing the expensive part (the spinlock itself 
> > and the irq thing).
> 
> It's actually on the fastpath for lib/rwsem-spinlock.c.

Ahh, yes. In this case, that doesn't likely change anything. The 
save/restore versions of the irq-safe locks shouldn't be appreciably more 
expensive than the non-saving ones. And architectures that really care 
should have done their own per-arch optimized version anyway.

Maybe we should even document that - so that nobody else makes the mistake 
x86-64 did of thinking that the "generic spinlock" version of the rwsem's 
is anything but a hacky and bad fallback case.

				Linus
