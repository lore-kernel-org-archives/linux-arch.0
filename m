Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37011 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfAIXTC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 18:19:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so8707993edb.4
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 15:19:01 -0800 (PST)
Date: Thu, 10 Jan 2019 00:18:53 +0100
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Message-ID: <20190109231852.GA4494@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
Message-ID: <20190109231853.6RgXhnj3NGNtjv-k7b1qPz4-070SOiVAr6UUtEnM7CQ@z>

On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> This series contains updates for the Linux-kernel memory model:
> 
> 1-3.	Add SRCU support, courtesy of Alan Stern.
> 
> 4.	Update README for adding of SRCU support.
> 
> 5.	Update memory-barriers.txt on enforcing heavy ordering for
> 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> 	an ack, preferably by someone from Intel.  Matthew Wilcox
> 	posted some feedback from an Intel manual here, which might
> 	be considered to be a close substitute, but...  ;-)
> 
> 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> 
> 6.	Update Documentation/explanation.txt to include SRCU support,
> 	courtesy of Alan Stern.
> 
> 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> 	Luc Maranget.  This needs an ack.

It seems that

  1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
  
from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
considered that, IIRC, you introduced the primitive and RCU is currently
its only user.)

  Andrea


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  Documentation/memory-barriers.txt                |    6 
>  tools/memory-model/Documentation/explanation.txt |  289 ++++++++++++-----------
>  tools/memory-model/README                        |   25 +
>  tools/memory-model/linux-kernel.bell             |   37 ++
>  tools/memory-model/linux-kernel.cat              |   55 ++--
>  tools/memory-model/linux-kernel.def              |    7 
>  6 files changed, 250 insertions(+), 169 deletions(-)
> 
