Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:7297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265305AbUHAHLS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 03:11:18 -0400
Date: Sun, 1 Aug 2004 00:10:26 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: find_next_bit return type
Message-Id: <20040801001026.68ed7363.davem@redhat.com>
In-Reply-To: <20040801000213.5f01b469.akpm@osdl.org>
References: <20040731232434.7263b50c.akpm@osdl.org>
	<20040731232515.1fead83b.akpm@osdl.org>
	<20040731235824.249ddb23.davem@redhat.com>
	<20040801000213.5f01b469.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 1 Aug 2004 00:02:13 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Kind-of.  But it's also cringeworthy to go slinging 8-byte values around
> when 4-byte values would suffice.  Is it not more efficient to use
> integers?

They all go in registers, the same register that could hold the 4-byte
values too.  There is also no computational cost to doing 64-bit add
subtract and shift (ie. simple ALU's) compared to 32-bit ones.

The int return value is also evil on many 64-bit systems because
it's going to do all of the computations in the native largest natural
word size (64-bits) then chop it down and sign extent it to 'int' (32-bits)

On 32-bitters none of this prototype crap will matter, since both int
and long are 32-bit of course.

I'm not %100 against using unsigned int, it's just that I know it will
crap up the output code a bit for 64-bitters.
