From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] percpu-rwsem: use barrier in unlock path
Date: Thu, 18 Oct 2012 00:13:39 -0400
Message-ID: <1350533619.19292.59.camel@pippen.local.home>
References: <Pine.LNX.4.64.1210151716310.10685@file.rdu.redhat.com>
	 <Pine.LNX.4.64.1210161924350.20581@file.rdu.redhat.com>
	 <CA+55aFyZ9uq_yfHn9PwpmM77X3xVd+xseEbjJmeCCqbFddtjWA@mail.gmail.com>
	 <507E48ED.8060809@cn.fujitsu.com>
	 <Pine.LNX.4.64.1210171046130.26481@file.rdu.redhat.com>
	 <20121017202806.GA7282@home.goodmis.org>  <507F66F6.20704@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14125 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2JRENu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2012 00:13:50 -0400
In-Reply-To: <507F66F6.20704@cn.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Eric Dumazet <eric.dumazet@gmail.com>

On Thu, 2012-10-18 at 10:18 +0800, Lai Jiangshan wrote:
> > 
> > Looking at the patch, you are correct. The read side doesn't need the
> > memory barrier as the worse thing that will happen is that it sees the
> > locked = false, and will just grab the mutex unnecessarily.
> 
> ---------------------
> A memory barrier can be added iff these two things are known:
> 	1) it disables the disordering between what and what.
> 	2) what is the corresponding mb() that it pairs with.
> 

OK, I was just looking at the protection and actions of the locked flag,
but I see what you are saying with the data itself.

> You tried to add a mb() in percpu_up_write(), OK, I know it disables the disordering
> between the writes to the protected data and the statement "p->locked = false",
> But I can't find out the corresponding mb() that it pairs with.
> 
> percpu_down_read()					writes to the data
> 	The cpu cache/prefetch the data			writes to the data
> 	which is chaos					writes to the data
> 							percpu_up_write()
> 								mb()
> 								p->locked = false;
> 	unlikely(p->locked)
> 		the cpu see p->lock = false,
> 		don't discard the cached/prefetch data
> 	this_cpu_inc(*p->counters);
> 	the code of read-access to the data
> 	****and we use the chaos data*****
> 
> So you need to add a mb() after "unlikely(p->locked)".

Does it need a full mb() or could it be just a rmb()? The down_read I
wouldn't think would need to protect against stores, would it? The
memory barrier should probably go in front of the unlikely() too. The
write to p->counters is handled by the synchronized sched, and adding a
rmb() in front of the unlikely check would keep prefetched data from
passing this barrier.

This is a perfect example why this primitive should be vetted outside of
mainline before it gets merged.

-- Steve
