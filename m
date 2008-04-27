Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51917 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753825AbYD0RHU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Apr 2008 13:07:20 -0400
Date: Sun, 27 Apr 2008 10:06:41 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
In-Reply-To: <20080427113158.GY2252@cs181133002.pp.htv.fi>
Message-ID: <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
Message-ID: <20080427170641.Xg0iBCFDvj0EGgK1pw6D4sP1plvbGR_KeNFPLNKzXTw@z>



On Sun, 27 Apr 2008, Adrian Bunk wrote:
> 
> My opinion on this is still:
> "OPTIMIZE" means "work around bugs in the kernel".

No.

It means that

 - gcc used to (long ago) always honor "inline", and we had kernel code 
   that depended on that in various ways (ie required that there was no 
   return etc).

   We've been mostly replacing the ones we know about with 
   "__always_inline", but there may be some that remain. We'll find out, I 
   guess.

 - gcc was a total and utter piece of horrible crap in the inlining 
   department, doign insane things and changing their documentation to 
   match the new behaviour (and some people then claimed that it was 
   always documented that way).

   It would not inline big functions even when they statically collapsed 
   to nothing, etc.

As a result, we really couldn't afford to let gcc make any inlining 
decisions, because the compiler was simply *broken*.

			Linus

