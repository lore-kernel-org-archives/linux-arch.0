Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60219 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757720AbYD0SZF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Apr 2008 14:25:05 -0400
Date: Sun, 27 Apr 2008 11:24:28 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
In-Reply-To: <20080427181411.GA31667@infradead.org>
Message-ID: <alpine.LFD.1.10.0804271118500.2896@woody.linux-foundation.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
 <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org> <20080427180957.GA25964@uranus.ravnborg.org> <20080427181411.GA31667@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
Message-ID: <20080427182428.3IF9CvwIlyku830DBJPFb8VJQ9jioSc0-K9xdMaCcJc@z>



On Sun, 27 Apr 2008, Christoph Hellwig wrote:
> 
> As Linus mentioned the hint doesn't make any sense because gcc will
> get it wrong anyway.  In fact when you look at kernel code it tends
> to inline the everything and the kitchensink as long as there's just
> one caller and this bloat the stack but doesn't inline where it needs
> to.  Better don't try to mess with that and do it explicit.

The thing is, the "inline" vs "always_inline" thing _could_ make sense, 
but sadly doesn't much.

Part of it is that gcc imnsho inlines too aggressively anyway in the 
absense of "inline", so there's no way "inline" can mean "you might 
inline" this, because gcc will do that anyway even without it. As a 
result, in _practice_ "inline" and "always_inline" end up being very close 
to each other - perhaps more so than they should.

I do obviously think that we're right to move into the direction that 
"inline" should be a hint. In fact, the biggest issue I have with the new 
kconfig option is that I think it should probably be unconditional, but I 
suspect that compiler issues and architecture issues make that not be a 
good idea.

It will take time before we've sorted out all the fall-out, because I bet 
there is still code out there that _should_ use __always_inline, but 
doesn't.

			Linus
