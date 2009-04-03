Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35683 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbZDCRAI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2009 13:00:08 -0400
Message-ID: <49D6400D.7040001@zytor.com>
Date: Fri, 03 Apr 2009 09:57:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 143/166] preadv/pwritev: Add preadv and pwritev system
 calls.
References: <200904022359.n32NxNYu022834@imap1.linux-foundation.org> <alpine.LFD.2.00.0904021839390.15441@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0904021839390.15441@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, kraxel@redhat.com, arnd@arndb.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, ralf@linux-mips.org, tglx@linutronix.de, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20090403165749.TI25c72dWVaHVdn9q8EbF9si9ZNswvuwJxbWVdanZRA@z>

Linus Torvalds wrote:
> 
> Grr. That may make sense on 32-bit architectures, but makes no sense 
> what-so-ever on 64-bit ones.
> 
> Why not just say that it's two "unsigned long" arguments, and split it by 
> "sizeof unsigned long". And then, on 64-bit architectures, the high bits 
> can be ignored. You can even get gcc to optimize it all away by doing 
> something like
> 
> 	#define HALF_LONG (BITS_IN_LONG / 2)
> 
> 	offset = (((loff_t)high << HALF_LONG) << HALF_LONG) | low;
> 
> and then gcc should automaticaly notice that shifting up that way is just 
> a fancy way of saying "0", and ignore the high bits.
> 
> How married are people to this crazy 2x "32 bits" model?
> 

I certainly am *not* happy with it, and said so when it was first
posted.  My main complaint with it is that it introduces yet another
special case in the kernel<->userspace ABI, because although we've had
this problem before, it has been hacked around a different way every time.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

