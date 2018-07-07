Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53179 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbeGGTyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jul 2018 15:54:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so17533625wmc.2
        for <linux-arch@vger.kernel.org>; Sat, 07 Jul 2018 12:54:45 -0700 (PDT)
Date: Sat, 7 Jul 2018 21:54:37 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180707195437.GA3225@andrea>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180707074209.GA32147@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707074209.GA32147@guoren>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20180707195437.s4ZvQDLl4GFtPf4Gw3NMV5Wkq3DwgVuWTF1-el6qaw0@z>

Hi Guo,

On Sat, Jul 07, 2018 at 03:42:10PM +0800, Guo Ren wrote:
> On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:
> > 	CPU0			CPU1
> > 
> > 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> > 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> > 
> > must not allow: r1==1 && r2==0
> CPU1 smp_store_release could be finished before WRITE_ONCE, so r1=1 &&
> r2=0?

The emphasis is on the "must": your implementation __must__ prevent this
from happening (say, by inserting memory barriers in smp_store_release());
if your implementation allows the state (r1==1 && r2==0), then the imple-
mentation is incorrect.

I'd suggest you have a look at the Linux-kernel memory consistency model
documentation and the associated tools, starting with:

  Documentation/memory-barriers.txt
  tools/memory-model/

(and please do not hesitate to ask questions about them, if something is
 unclear).

  Andrea
