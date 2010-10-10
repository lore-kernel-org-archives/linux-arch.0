From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] bitops: add generic implementation of ext2 atomic bitops by test_and_{set,clear}_bit
Date: Sun, 10 Oct 2010 18:36:52 +0200
Message-ID: <201010101836.52406.arnd@arndb.de>
References: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com> <20101008102433.GA24208@infradead.org> <AANLkTikjb8aTBoXm3+9ULQDB9OvdxwHcQ=BSS4aBJm9i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55175 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab0JJQhs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 Oct 2010 12:37:48 -0400
In-Reply-To: <AANLkTikjb8aTBoXm3+9ULQDB9OvdxwHcQ=BSS4aBJm9i@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sunday 10 October 2010 17:07:26 Akinobu Mita wrote:
> Some architectures use spinlock to implement it
> (asm-generic/bitops/ext2-atomic.h). Most other architectures use
> test_and_set_bit() and test_and_clear_bit() as this patch shows.
> 
> Why are there two implementations? test_and_{set,clear}_bit() are more
> costly operations than spinlock for some architectures?

I would guess that is only true on architectures that implement all atomics
using a hashed spinlock like cris, sparc32 or parisc. This way the user
can decide which spinlock to use rather than have the arch code calculate
a hash on the pointer.

This is an ext2 specific micro-optimization that I don't think makes
sense in the generic le bitops code.

	Arnd
