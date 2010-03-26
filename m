From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Fri, 26 Mar 2010 10:23:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org>
References: <20100326144241.8583.95617.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55196 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751671Ab0CZR2e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 13:28:34 -0400
In-Reply-To: <20100326144241.8583.95617.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



On Fri, 26 Mar 2010, David Howells wrote:
>
> fls(N), ffs(N) and fls64(N) can be optimised on x86/x86_64.  Currently they
> perform checks against N being 0 before invoking the BSR/BSF instruction, or
> use a CMOV instruction afterwards.  Either the check involves a conditional
> jump which we'd like to avoid, or a CMOV, which we'd also quite like to avoid.
> 
> Instead, we can make use of the fact that BSR/BSF doesn't modify its output
> register if its input is 0.  By preloading the output with -1 and incrementing
> the result, we achieve the desired result without the need for a conditional
> check.

This is totally incorrect.

Where did you find that "doesn't modify its output" thing? It's not true. 
The truth is that the destination is undefined. Just read the dang Intel 
documentation, it's very clearly stated right there.

If you can show otherwise, feel free. But I'm pretty sure there are 
actually x86 chips out there that _do_ modify the destination. I have a 
pretty strong memory of us trying this at some point, and it not working.

		Linus
