From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 01/10] Use __kernel_long_t in struct timex
Date: Thu, 17 May 2012 15:55:17 -0700
Message-ID: <4FB581D5.9010606@zytor.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-2-git-send-email-hjl.tools@gmail.com> <CA+55aFx98qvVg1JhMV0JjgNGb++xtir5ocseY3xgQNc3qAtWdQ@mail.gmail.com> <4FB57EB2.4050208@zytor.com> <CA+55aFzztct_HzmGiit=9SwwM4_YPuXbjwMdJpM1JHMXGBNqaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38263 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761041Ab2EQWza (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 18:55:30 -0400
In-Reply-To: <CA+55aFzztct_HzmGiit=9SwwM4_YPuXbjwMdJpM1JHMXGBNqaA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On 05/17/2012 03:50 PM, Linus Torvalds wrote:
> Yes, I do think this is closer to the "__u32" kind of usage, and in
> general I tend to think that's true of most of the __kernel_ prefix
> things. There is very little "kernely" things about it.

The only think "kernely" about it is that it describes the kernel ABI.

> Yes, we have to have the double underscore (or single+capitalized),
> but I think that at least personally, I'd be happier with just
> "__long" and "__ulong".

I would suggest __slong and __ulong then, to keep with the __[su]*
namespace, or does the extra "s" look too much like crap?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
