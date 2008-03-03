Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49543 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYCCGiP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Mar 2008 01:38:15 -0500
Message-ID: <47CB9A77.60708@zytor.com>
Date: Sun, 02 Mar 2008 22:28:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <20080303023851.GF24386@parisc-linux.org> <47CB81EA.8070802@zytor.com> <20080303062007.GY27894@ZenIV.linux.org.uk> <47CB96D5.3030509@zytor.com> <20080303063216.GA27894@ZenIV.linux.org.uk>
In-Reply-To: <20080303063216.GA27894@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
Message-ID: <20080303062807.6fv8iyOIvYhfuWvm93YKCC2tFMLC1ELe_Z6nUGk2FAY@z>

Al Viro wrote:
> 
> Oh, for...  It's not as if we _had_ anything better for u64 than %ull and
> convert the argument to unsigned long long for that family.
> 
> Unless you are seriously suggesting the use of vomit-inducing atrocity of
> PRIu64 and constant concatenation in there, that is.  I would rather move
> typechecking for printk-style functions to sparse and tell gcc to STFU
> completely on that class of warnings.  Making it extensible, while we are
> at it - i.e. telling sparse that this conversion is to be used for dma_addr_t,
> etc.

No, I'm not suggesting that.  I'd rather have the Windoze extension of 
%I64u, which of course gcc doesn't recognize.

	-hpa
