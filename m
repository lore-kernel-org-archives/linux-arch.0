From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Tue, 11 Jul 2017 06:55:28 -0700
Message-ID: <20170711135528.GA11417@infradead.org>
References: <20170706154512.GD15574@arm.com>
 <mhng-f92ef7c4-049a-4a71-be12-c600d1d7858b@palmer-si-x1c4>
 <20170711132215.GD13977@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36611 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755513AbdGKNzm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2017 09:55:42 -0400
Content-Disposition: inline
In-Reply-To: <20170711132215.GD13977@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, hch@infradead.org, peterz@infradead.org, mingo@redhat.com, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, tklauser@distanz.ch, james.hogan@imgtec.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mathieu.desnoyers@efficios.com

On Tue, Jul 11, 2017 at 02:22:15PM +0100, Will Deacon wrote:
> The problem is that by supporting these hypothetical designs that can't do
> atomics, you hurt sensible designs that *can* do the atomics because you
> force them to take an additional indirection that could otherwise be
> avoided.

Agreed.  But the new patchset seems to remove it already, so I guess
we're fine on the kernel side.  Now we just need to make sure the
glibc API doesn't use any indirections.

Note that it might make sense to emit these for very low end nommu
designs.  Maybe even running Linux, but in that case they'll just need
a special non-standard ABI for very limited use cases.
