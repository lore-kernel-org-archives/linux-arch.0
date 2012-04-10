From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Wed, 11 Apr 2012 08:35:21 +1000
Message-ID: <1334097321.3040.62.camel@pasglop>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59755 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072Ab2DJWf3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Apr 2012 18:35:29 -0400
In-Reply-To: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-arch@vger.kernel.org

On Fri, 2012-04-06 at 14:32 -0700, Linus Torvalds wrote:
> Ok, as some of you are aware, one of the things that got merged very
> early in the 3.4 merge window was the "word-at-a-time" filename lookup
> patches I had been working on. They only get enabled on x86, but when
> they do, they do speed things up by quite a noticeable bit (mainly on
> x86-64, which ends up doing things 8 bytes at a time - it's much less
> noticeable on x86-32).

Talking of which ... I haven't had much time to look but any reason that
wouldn't work on BE platforms as well when they have a fast
byteswap-load ? Now powerpc sadly only have up to 32-bit byteswap loads
so doing 64-bit requires a bit of shifting around but the result might
still be faster than loading individual bytes especially since we do
have a bunch of registers to spare....

Something lines of

-		a = *(unsigned long *)name;
+		a = le64_to_cpup((__le64 *)name);

(etc...)

Maybe ?

I might have a chance to actually test later today (chasing some
regressions goes first)

Cheers,
Ben.
