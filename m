From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/7] locking: qspinlock
Date: Wed, 12 Mar 2014 17:23:28 +0100
Message-ID: <20140312162328.GH27965@twins.programming.kicks-ass.net>
References: <20140310154236.038181843@infradead.org>
 <20140312023153.GW13647@dastard>
 <20140311231159.25a0d8dc@gandalf.local.home>
 <20140312042616.GX13647@dastard>
 <20140312060730.435122f0@gandalf.local.home>
 <20140312155754.GG27965@twins.programming.kicks-ass.net>
 <20140312121933.40f63087@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140312121933.40f63087@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dave Chinner <david@fromorbit.com>, Waiman Long <waiman.long@hp.com>, arnd@arndb.de, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, walken@google.com, andi@firstfloor.org, riel@redhat.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, oleg@redhat.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 12, 2014 at 12:19:33PM -0400, Steven Rostedt wrote:
> On Wed, 12 Mar 2014 16:57:54 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> 
> > I build and booted these patches against tip/master as of this morning.
> > It build ~50 defconfig kernels on my WSM-EP.
> > 
> > I've not managed to reproduce the hang as reported by Dave, but then I
> > doubt building kernels has anywhere near the lock contention he
> > generated.
> > 
> 
> Have you tried hackbench? That usually gives rq spinlocks a bit of
> contention.

Ha!, bang it goes. I suppose my userspace contention is too nice or
something for not triggering this.

Lemme try and put it together again :-)
