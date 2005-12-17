Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 16 Dec 2005 23:34:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org>
References: <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
 <20051215112115.7c4bfbea.akpm@osdl.org> <1134678532.13138.44.camel@localhost.localdomain>
 <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be>
 <1134769269.2806.17.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org>
 <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org>
 <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org>
 <20051217002929.GA7151@tsunami.ccur.com> <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org>
 <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joe Korty <joe.korty@ccur.com>, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx, arjan@infradead.org, Christoph Hellwig <hch@infradead.org>, mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>, nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
List-ID: <linux-arch.vger.kernel.org>



On Fri, 16 Dec 2005, Steven Rostedt wrote:
> 
> So how does one handle real-time tasks that must contend with locks within
> the kernel that is shared with low priority tasks?  Do you prefer the RTAI
> approach?

If you want hard real-time, either that, or just make sure you don't get 
locks that might be slow (for one reason or another). Finer granularities 
help there.

For example, to make things really concrete, please just name a semaphore 
that is relevant to a real-time task and that isn't fine enough grain that 
a careful and controlled environment can't avoid it being a bottle-neck 
for a real-time task.

The real problems often end up happening in things like memory management, 
and waiting for IO, where it's not about the locking at all, it's about 
event scheduling. And you just have to avoid those (through pre-allocation 
and buffering) in those kinds of real-time situations.

I really can't think of any blocking kernel lock where priority 
inheritance would make _any_ sense at all. Please give me an example. 

			Linus
