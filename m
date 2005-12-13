Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 08:16:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <20051213084926.GN23384@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0512130812020.15597@g5.osdl.org>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
 <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org>
 <20051213084926.GN23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Tue, 13 Dec 2005, Andi Kleen wrote:
> 
> Remove -Wdeclaration-after-statement

Please don't.

It's a coding style issue. We put our variable declarations where people 
can _find_ them, not in random places in the code.

Putting variables in the middle of code only improves readability when you 
have messy code. 

Now, one feature that _may_ be worth it is the loop counter thing:

	for (int i = 10; i; i--)
		...

kind of syntax actually makes sense and is a real feature (it makes "i" 
local to the loop, and can actually help people avoid bugs - you can't use 
"i" by mistake after the loop).

But I think you need "--std=c99" for gcc to take that.

			Linus
