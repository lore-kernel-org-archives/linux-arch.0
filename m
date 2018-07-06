Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43948 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFMRp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 08:17:45 -0400
Date: Fri, 6 Jul 2018 14:17:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706121716.GO2512@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706115614.GV2476@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20180706121716.AD-A6ewqzDei-ryzrMac_-RRzdl8hxK5W1dhTNI4Jq0@z>

On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:

> > But I couldn't undertand what's wrong without the 1th smp_mb()?
> > 1th smp_mb will make all ld/st finish before ldex.w. Is it necessary?
> 
> Yes.
> 
> 	CPU0			CPU1
> 
> 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> 
> must not allow: r1==1 && r2==0

Also, since you said "SYNC.IS" is a pipeline flush, those
instruction-sync primitives normally do not imply a store-buffer flush,
does yours? If not it is not a valid smp_mb() implementation.

Notably:

	CPU0				CPU1

	WRITE_ONCE(x, 1);		WRITE_ONCE(y, 1);
	smp_mb();			smp_mb();
	r0 = READ_ONCE(y);		r1 = READ_ONCE(x);

must not allow: r0==0 && r1==0

Which would be possible with a regular instruction-sync barrier, but
must absolutely not be true with a full memory barrier.

(and you can replace the smp_mb(); r = READ_ONCE(); with r = xchg() to
again see why you need that first smp_mb()).
