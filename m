From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/3] add new strscpy() API for string copy
Date: Mon, 18 May 2015 11:13:31 +1000
Message-ID: <1431911611.13218.1.camel@ellerman.id.au>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
	 <1431645018.2981.3.camel@ellerman.id.au> <55560D8F.60704@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:50392 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbbERBNe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 May 2015 21:13:34 -0400
In-Reply-To: <55560D8F.60704@ezchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Fri, 2015-05-15 at 11:15 -0400, Chris Metcalf wrote:
> On 05/14/2015 07:10 PM, Michael Ellerman wrote:
> > On Thu, 2015-04-30 at 12:01 -0400, Chris Metcalf wrote:
> >>
> >> I tested the implementation with a simple user-space harness, so I
> >> believe it is correct for the corner cases I could think of.  In
> >> particular I pairwise-tested all the unaligned values of source and
> >> dest, and tested the restriction on src page-crossing at all
> >> unaligned offsets approaching the page boundary.
> > Can you please put that in tools/testing/selftests and merge it as part of the
> > series? That way I can run the tests and be confident it works on powerpc.
> 
> Unfortunately, the strscpy patch series only changes the one previous
> user of the API, which is a tile-architecture-only driver piece, not
> particularly useful for anyone else for testing.
> 
> The testing I did pulled strscpy() and word-at-a-time out into a
> separate, standalone userspace implementation, and tested it there,
> rather than doing tests through the syscall API like 
> tools/testing/selftests.

Not everything in selftests has to or does go through the syscall API.

We (powerpc) have tests of our memcpy/memcmp/load_unaligned_zeropad that are
built as standalone test programs.

Doing that for stuff in lib/string.c does look a bit complicated, because you'd
need to pull in a bunch of kernel headers.

Do you mind posting your test code somewhere so I can run it, and maybe I can
work out how to fold it into a selftest.

cheers
