From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Date: Wed, 5 Feb 2020 10:34:54 +0100
Message-ID: <20200205093454.GG14879@hirez.programming.kicks-ass.net>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgBEJe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 04:34:59 -0500
Content-Disposition: inline
In-Reply-To: <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>

On Wed, Feb 05, 2020 at 04:30:10PM +0900, Hajime Tazaki wrote:
> From: Octavian Purdila <tavi.purdila@gmail.com>
> 
> With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
> are not compiled due to type conflict of atomic64_t defined in
> linux/type.h.
> 
> This commit fixes the issue and allow using generic atomic64 ops.
> 
> Currently, LKL is only the user which defines GENERIC_ATOMIC64
> (lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
> issues before this commit.

Uhhhhh, no.

Not allowing GENERIC_ATOMIC64 on 64BIT is a *feature*.

Any 64bit arch that needs GENERIC_ATOMIC64 is an utter piece of crap.

Please explain more.
