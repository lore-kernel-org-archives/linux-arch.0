From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Date: Wed, 5 Feb 2020 13:49:08 +0100
Message-ID: <20200205124908.GL14879@hirez.programming.kicks-ass.net>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
 <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEMtM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 07:49:12 -0500
Content-Disposition: inline
In-Reply-To: <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <tavi.purdila@gmail.com>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>

On Wed, Feb 05, 2020 at 02:24:38PM +0200, Octavian Purdila wrote:
> I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I

It might not have been, but presented with this patch, I feel like it
should've been :-)

> understand your point that a 64 bit architecture that can't handle 64
> bit atomic operation is broken.

(sadly they actually exist, I shall name no names)

> One way to deal with this in LKL would be to use GCC atomic builtins
> or if that doesn't work expose them as host operations. This would
> keep LKL as a meta-arch that can run on multiple physical
> architectures. I'll give it a try.

What is this LKL you speak of and how does it do the 32bit atomics?

One thing to keep in mind is that the C11 atomics (_Atomic) don't
trivially map to the LKMM -- although I keep forgetting the exact
details, there is a paper on it somewhere.  Also, once you're limited to
a specific arch the issue also becomes much easier than C11 vs LKMM in
general.
