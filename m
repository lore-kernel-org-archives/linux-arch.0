Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:51878 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265144AbUHAPH4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 11:07:56 -0400
Date: Sun, 1 Aug 2004 08:07:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: find_next_bit return type
Message-ID: <20040801150751.GX2334@holomorphy.com>
References: <20040731232434.7263b50c.akpm@osdl.org> <1091372708.10972.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091372708.10972.3.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Aug 01, 2004 at 11:05:07AM -0400, James Bottomley wrote:
> This isn't just a prototype change, it would change the actual
> implementation on big endian 64 bit machines.
> The find_first_bit/find_next_bit macros work fine on LE because the
> lowest bit is at the start of the bitmap.  on BE machines, the highest
> bit is supposed to be there.  The result is that long bitmaps are
> currently implemented LE in BE chunks (the chunk size being an unsigned
> long).  If you change to an unsigned int, you reduce our chunk size, and
> hence the actual layout of the bitmap, so we'd need to check there were
> no unintended consequences of this.
> Would it not be easier simply to change the prototype on x86?

I would not be averse to this.
