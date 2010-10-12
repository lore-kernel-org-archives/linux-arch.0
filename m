From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/5] bitops: add generic implementation of ext2 atomic
 bitops by test_and_{set,clear}_bit
Date: Tue, 12 Oct 2010 12:39:37 +0900
Message-ID: <AANLkTik95xrOw0Y_=63EiJ-EGh95XZGeqMy_-HXorqCS@mail.gmail.com>
References: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com>
	<20101008102433.GA24208@infradead.org>
	<AANLkTikjb8aTBoXm3+9ULQDB9OvdxwHcQ=BSS4aBJm9i@mail.gmail.com>
	<201010101836.52406.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36598 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab0JLDji (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Oct 2010 23:39:38 -0400
In-Reply-To: <201010101836.52406.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

2010/10/11 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 10 October 2010 17:07:26 Akinobu Mita wrote:
>> Some architectures use spinlock to implement it
>> (asm-generic/bitops/ext2-atomic.h). Most other architectures use
>> test_and_set_bit() and test_and_clear_bit() as this patch shows.
>>
>> Why are there two implementations? test_and_{set,clear}_bit() are more
>> costly operations than spinlock for some architectures?
>
> I would guess that is only true on architectures that implement all atomics
> using a hashed spinlock like cris, sparc32 or parisc. This way the user
> can decide which spinlock to use rather than have the arch code calculate
> a hash on the pointer.

Thanks. It looks quite right.

> This is an ext2 specific micro-optimization that I don't think makes
> sense in the generic le bitops code.

OK, I'll only rename ext2 non-atomic bitops to le bitops and
keep ext2 atomic bitops for now.
