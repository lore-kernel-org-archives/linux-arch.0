From: David Miller <davem@davemloft.net>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 13:21:09 -0400 (EDT)
Message-ID: <20120523.132109.1153947222019508621.davem@davemloft.net>
References: <CAMuHMdUdxrGqn9sRgwrNgX4teV_ivHSeBn3hKnvgxZRxQE_krQ@mail.gmail.com>
	<1337766025.3013.3.camel@dabdike.int.hansenpartnership.com>
	<CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:60272 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab2EWRWP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 13:22:15 -0400
In-Reply-To: <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2012 08:15:42 -0700

> Btw, the x86 version these days actually zeroes the last bytes of the
> word-at-a-time copy.

I noticed, and that was the bug in the version I posted.

I decided in the end to not do what x86 does because there's no
cheap way to do it on big-endian.  I simply moved the 'dst'
store before the has_zero() test.
