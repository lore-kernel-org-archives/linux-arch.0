From: David Miller <davem@davemloft.net>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 19:29:35 -0400 (EDT)
Message-ID: <20120410.192935.289591767950787447.davem@davemloft.net>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
	<1334097321.3040.62.camel@pasglop>
	<CA+55aFwpX=SG6ECoi958+huLJ=egi3FDLxEeFpFtR8Hn8BJMDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:48917 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759549Ab2DJX3k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 19:29:40 -0400
In-Reply-To: <CA+55aFwpX=SG6ECoi958+huLJ=egi3FDLxEeFpFtR8Hn8BJMDg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: benh@kernel.crashing.org, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Apr 2012 15:50:49 -0700

> For the "strncpy_from_user()", you only have the 'detect zeroes', and
> the loop count is often noticeable (whole pathname), so it might make
> sense to do that outside the loop.

Just wanted to mention that handling the detect zeroes operations on
cpus that require alignment is easy, just rewind the pointer at the
beginning to be aligned and "or" in a mask of 0xff for each alignment
pad byte into the initially loaded word.

That's how we do it in glibc on sparc and powerpc already.

The only reason to go to little-endian is to 1) potentially save a
small number of cycles on the loop exit and frankly I think if you do
another load to accomplish that you'll anihilate up all the gains
and 2) make the "strlen + hash function computation" case eaiser.
