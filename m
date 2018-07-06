Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeGFNB2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 09:01:28 -0400
Date: Fri, 6 Jul 2018 15:01:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706130110.GP2512@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
 <20180706114402.GB27148@guoren>
 <20180706120323.GW2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706120323.GW2476@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706130110.6TYXa7xWQgslE8f1XG-RjCCjnRmCLVFC2CQ5HeUTpQs@z>

On Fri, Jul 06, 2018 at 02:03:23PM +0200, Peter Zijlstra wrote:
> > Ok, I'll try to implement ticket lock in next version patch.
> 
> If you need inspiration, look at:
> 

My bad, just look at the arm (not arm64) version.
