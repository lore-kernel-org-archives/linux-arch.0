Return-Path: <James.Bottomley@steeleye.com>
Received: from stat16.steeleye.com ([209.192.50.48]:60855 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266006AbUHAPFQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Aug 2004 11:05:16 -0400
Subject: Re: find_next_bit return type
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20040731232434.7263b50c.akpm@osdl.org>
References: <20040731232434.7263b50c.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 01 Aug 2004 11:05:07 -0400
Message-Id: <1091372708.10972.3.camel@mulgrave>
Mime-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2004-08-01 at 02:24, Andrew Morton wrote:
> 
> Seems that several 64-bit architectures are returning longs from
> find_next_bit(), find_next_zero_bit(), etc.  x86 returns an int.  wli sent
> me a patch which does
> 
> 	return min(NR_CPUS, find_first_bit(srcp->bits, nbits));
> 
> so these architectures now get a zillion warnings.
> 
> We should be consistent here.  Is there any reason why these functions
> cannot return integers?

This isn't just a prototype change, it would change the actual
implementation on big endian 64 bit machines.

The find_first_bit/find_next_bit macros work fine on LE because the
lowest bit is at the start of the bitmap.  on BE machines, the highest
bit is supposed to be there.  The result is that long bitmaps are
currently implemented LE in BE chunks (the chunk size being an unsigned
long).  If you change to an unsigned int, you reduce our chunk size, and
hence the actual layout of the bitmap, so we'd need to check there were
no unintended consequences of this.

Would it not be easier simply to change the prototype on x86?

James
