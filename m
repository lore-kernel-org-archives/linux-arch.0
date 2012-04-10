From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Wed, 11 Apr 2012 09:56:51 +1000
Message-ID: <1334102211.2984.4.camel@pasglop>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
	 <1334097321.3040.62.camel@pasglop>
	 <CA+55aFwpX=SG6ECoi958+huLJ=egi3FDLxEeFpFtR8Hn8BJMDg@mail.gmail.com>
	 <20120410.192935.289591767950787447.davem@davemloft.net>
	 <4F84C35C.1020803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55474 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997Ab2DJX4x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Apr 2012 19:56:53 -0400
In-Reply-To: <4F84C35C.1020803@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org, mingo@kernel.org, x86@kernel.org, linux-arch@vger.kernel.org

On Tue, 2012-04-10 at 16:33 -0700, H. Peter Anvin wrote:
> > Just wanted to mention that handling the detect zeroes operations on
> > cpus that require alignment is easy, just rewind the pointer at the
> > beginning to be aligned and "or" in a mask of 0xff for each alignment
> > pad byte into the initially loaded word.
> > 
> 
> Even on machines which don't require alignment it will still be faster
> to do aligned memory references only, not counting the startup cost
> (which is substantial in this case, of course, since the average length
> is so short.)  However, it also neatly avoids the page overrun problem.

I'm leaning toward that too, but I want to do some benches. The main
issues for me are:

  - I have to deal with a reasonably wide range of different cores which
will handle unaligned accesses very differently. Almost all will do it
in HW but with very varying degree of performances and some will
occasionally trap (SW emulation kicks in but that's extremely slow). The
trapping case is generally rare though, depending on the core it will
happen on things like page boundaries or segment boundaries. I also
suspect that the byte-reverse load/store instructions will suck more at
unaligned.

 - The page overrun is an issue. On 64-bit we don't have anything mapped
past the end of the linear mapping and on 32-bit we fall into ioremap
space. That's fixable with a quick hack to add one more page to the
linear mapping, creating a double mapping of either page 0 or any random
page of memory, I don't have cache aliases or anything like that to
worry about but it's gross.

Anyways, I'll try to play around if I get time, might have to wait for
next week tho, I have some more urgent stuff to sort out and I'm off
friday to tuesday.

Cheers,
Ben.
