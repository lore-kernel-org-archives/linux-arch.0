Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:35288 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266186AbUHAWKz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 18:10:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16653.27152.500547.917797@cargo.ozlabs.ibm.com>
Date: Mon, 2 Aug 2004 08:09:20 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: find_next_bit return type
In-Reply-To: <1091372708.10972.3.camel@mulgrave>
References: <20040731232434.7263b50c.akpm@osdl.org>
	<1091372708.10972.3.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

James Bottomley writes:

> On Sun, 2004-08-01 at 02:24, Andrew Morton wrote:
> > 
> > Seems that several 64-bit architectures are returning longs from
> > find_next_bit(), find_next_zero_bit(), etc.  x86 returns an int.  wli sent
> > me a patch which does
> > 
> > 	return min(NR_CPUS, find_first_bit(srcp->bits, nbits));
> > 
> > so these architectures now get a zillion warnings.
> > 
> > We should be consistent here.  Is there any reason why these functions
> > cannot return integers?
> 
> This isn't just a prototype change, it would change the actual
> implementation on big endian 64 bit machines.
> 
> The find_first_bit/find_next_bit macros work fine on LE because the
> lowest bit is at the start of the bitmap.  on BE machines, the highest
> bit is supposed to be there.  The result is that long bitmaps are
> currently implemented LE in BE chunks (the chunk size being an unsigned
> long).  If you change to an unsigned int, you reduce our chunk size, and
> hence the actual layout of the bitmap, so we'd need to check there were
> no unintended consequences of this.

I think Andrew was talking about the return type, not the type of the
bitmap.  The return type could easily be an int or unsigned int, while
still having the bitmap as an array of unsigned longs (with unchanged
layout).

Paul.
