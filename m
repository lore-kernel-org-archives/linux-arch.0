From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 2/3] math128: Introduce {mult,add,cmp}_u128
Date: Wed, 25 Apr 2012 10:11:06 +0200
Message-ID: <1335341466.28150.248.camel@twins>
References: <20120424161039.293018424@chello.nl>
	 <20120424162224.526249106@chello.nl>
	 <20120425102342.45cf5c5e81e8aeb3bec67d0b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:49592 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2DYILb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2012 04:11:31 -0400
In-Reply-To: <20120425102342.45cf5c5e81e8aeb3bec67d0b@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 2012-04-25 at 10:23 +1000, Stephen Rothwell wrote:
> Isn't this what asm-generic is for?  You put the generic version in
> asm-generic/math128.h and then add "generic-y += math128.h" to
> arch/*/include/asm/Kbuild for each arch that wants the generic version.
> Then just include asm/math128.h in linux/math128.h.  Any arch that wants
> to optimise these can then just provide its own math128.h. 

Ah, right. I didn't know that Kbuild trick. /me does:

  ls arch/*/include/asm/Kbuild | while read file; do quilt add $file;
echo "generic-y += math128.h" >> $file; done

Thanks!
