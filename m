From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Fri, 26 Mar 2010 10:45:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003261042580.3721@i5.linux-foundation.org>
References: <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org> <20100326144241.8583.95617.stgit@warthog.procyon.org.uk> <28287.1269625325@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53206 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753226Ab0CZRtm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 13:49:42 -0400
In-Reply-To: <28287.1269625325@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



On Fri, 26 Mar 2010, David Howells wrote:
> 
> Hmmm...  My ancient Borland Assembler dead-tree manual doesn't mention that.

I went back and checked the old Intel 386 docs from -92 or something, and 
it was "undefined" in there too. So at least Intel seems to have been very 
consistent on this.

That said, maybe all implementations actually do the "don't touch" thing. 

But I do have this memory of us doing this ten+ years ago, though, and 
having to check the ZF after all. Which is why I reacted to the patch in 
the first place and checked the documentation.

			Linus
