Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:11814 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab2JQU2K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2012 16:28:10 -0400
Date: Wed, 17 Oct 2012 16:28:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] percpu-rwsem: use barrier in unlock path
Message-ID: <20121017202806.GA7282@home.goodmis.org>
References: <Pine.LNX.4.64.1210151716310.10685@file.rdu.redhat.com>
 <Pine.LNX.4.64.1210161924350.20581@file.rdu.redhat.com>
 <CA+55aFyZ9uq_yfHn9PwpmM77X3xVd+xseEbjJmeCCqbFddtjWA@mail.gmail.com>
 <507E48ED.8060809@cn.fujitsu.com>
 <Pine.LNX.4.64.1210171046130.26481@file.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1210171046130.26481@file.rdu.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <20121017202806.6hmy_rTMijP4lc-6APpapxP-lMp91lqcHPTeu5tG7fM@z>

On Wed, Oct 17, 2012 at 11:07:21AM -0400, Mikulas Patocka wrote:
> > 
> > Even the previous patch is applied, percpu_down_read() still
> > needs mb() to pair with it.
> 
> percpu_down_read uses rcu_read_lock which should guarantee that memory 
> accesses don't escape in front of a rcu-protected section.

You do realize that rcu_read_lock() does nothing more that a barrier(),
right?

Paul worked really hard to get rcu_read_locks() to not call HW barriers.

> 
> If rcu_read_unlock has only an unlock barrier and not a full barrier, 
> memory accesses could be moved in front of rcu_read_unlock and reordered 
> with this_cpu_inc(*p->counters), but it doesn't matter because 
> percpu_down_write does synchronize_rcu(), so it never sees these accesses 
> halfway through.

Looking at the patch, you are correct. The read side doesn't need the
memory barrier as the worse thing that will happen is that it sees the
locked = false, and will just grab the mutex unnecessarily.

> > 
> > I suggest any new synchronization should stay in -tip for 2 or more cycles
> > before merged to mainline.
> 
> But the bug that this synchronization is fixing is quite serious (it 
> causes random crashes when block size is being changed, the crash happens 
> regularly at multiple important business sites) so it must be fixed soon 
> and not wait half a year.

I don't think Lai was suggesting to wait on this fix, but instead to
totally rip out the percpu_rwsems and work on them some more, and then
re-introduce them in a half a year.

-- Steve

