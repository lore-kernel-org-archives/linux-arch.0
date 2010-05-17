From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2]: atomic_t: Remove volatile from atomic_t
 definition
Date: Mon, 17 May 2010 13:20:51 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005171314590.4195@i5.linux-foundation.org>
References: <20100517043353.GA22127@kryten> <20100517043457.GA22416@kryten> <alpine.LFD.2.00.1005170800100.4195@i5.linux-foundation.org> <20100517201339.GJ20356@shareable.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38248 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751782Ab0EQUXm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2010 16:23:42 -0400
In-Reply-To: <20100517201339.GJ20356@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Anton Blanchard <anton@samba.org>, akpm@linux-foundation.org, willy@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



On Mon, 17 May 2010, Jamie Lokier wrote:
> 
> I wonder if
> 
>    extern unsigned long __nv_jiffies;
>    #define jiffies (*(volatile unsigned long *)*__nv_jiffies)
> 
> would improve any code in the same way as this atomic_t change.

We effectively already do that. The full 64-bit jiffies isn't volatile. 
But for legacy reasons, we have that "word-sized subpart" of the full 
counter that is volatile - and we're using linker tricks rather the the C 
preprocessor to do the above thing.

So no, there's no room for improvement for jiffies - the only people who 
ever use the volatile jiffies are things that read it. There are no 
initializers that matter, and the updates (which also tend to suck with 
"volatile" because gcc just doesn't do even the obvious optimizations) are 
all done locked and to the non-volatile jiffies_64.

		Linus
