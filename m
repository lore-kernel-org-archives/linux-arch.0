Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45574 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGTqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Feb 2019 14:46:15 -0500
Date: Thu, 7 Feb 2019 20:45:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH-tip 15/22] locking/rwsem: Merge owner into count on x86-64
Message-ID: <20190207194542.GG32511@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-16-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549566446-27967-16-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190207194542.k8PhQ8S7M0fKnX1Mp7h8pOUOzJrcf7IwLa0AmjHCROw@z>

On Thu, Feb 07, 2019 at 02:07:19PM -0500, Waiman Long wrote:
> On 32-bit architectures, there aren't enough bits to hold both.
> 64-bit architectures, however, can have enough bits to do that. For
> x86-64, the physical address can use up to 52 bits. That is 4PB of
> memory. That leaves 12 bits available for other use. The task structure
> pointer is also aligned to the L1 cache size. That means another 6 bits
> (64 bytes cacheline) will be available. Reserving 2 bits for status
> flags, we will have 16 bits for the reader count.  That can supports
> up to (64k-1) readers.

*groan*...

So take qrwlock's idea for a queue, then make the count value (similar
to the new mutex); that is have a bit0 be a r/w bit, when w bits 6-N are
owner, when r they are reader-count. bit1 can be a pending bit, bit2 a
handoff bit etc..

That should fit and work on 32bit and 64bit without issue.

I have a half-arsed rwsem-atomic.c somewhere that does just that. I just
never got around to doing all the optimistic spin and steal crap that
makes our current rwsem fly.

And that nicely gets rid of that mind bending BIAS crud.
