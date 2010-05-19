From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: schedule() && prev/current (Was: [PATCH 3/3] Make
 get_current() __attribute__((const)))
Date: Wed, 19 May 2010 21:07:09 +0800
Message-ID: <20100519130709.GA2216@zhy>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
 <20100518164547.6194.94193.stgit@warthog.procyon.org.uk>
 <20100518212220.GA5092@redhat.com>
 <1274250079.5605.9967.camel@twins>
 <20100519102743.GA10040@redhat.com>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100519102743.GA10040@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 19, 2010 at 12:27:43PM +0200, Oleg Nesterov wrote:
> On 05/19, Peter Zijlstra wrote:
> >
> > On Tue, 2010-05-18 at 23:22 +0200, Oleg Nesterov wrote:
> >
> > > And, looking at this patch I think that schedule() can be simplified
> > > a little bit.
> > >
> > > "sched: Reassign prev and switch_count when reacquire_kernel_lock() fail"
> > > commit 6d558c3ac9b6508d26fd5cadccce51fc9d726b1c says:
> > >
> > > 	Assume A->B schedule is processing,
> > > 	...
> > > 	Then on B's context,
> > > 	...
> > > 	prev and switch_count are related to A
> > >
> > > How so? switch_count - yes, we should change it. But prev must be
> > > equal to B, and it must be equal to current. When we return from
> > > switch_to() registers/stack should be restored correctly, so we
> > > can do
> >
> > What if schedule() got called at a different stack depth than we are
> > now?
> >
> > I don't think we can assume anything about the stack context we just
> > switched to.
> 
> Not sure I understand...
> 
> OK. Firstly, we shouldn't worry about the freshly forked tasks, they
> never "return" from switch_to() but call ret_from_fork()->schedule_tail(),
> right?
> 
> Now suppose that A calls schedule() and we switch to B. When switch_to()
> returns on B's context, this context (register/stack) matches the previous
> context which was used by B when it in turn called schedule(), correct?
> 
> IOW. B calls schedule, prev == B. schedule() picks another task, prev
> is saved on B's stck after switch_to(). A calls schedule(), prev == A
> before context_switch(A, B), but after that switch_to() switches to
> B's stack and prev == B.
> 
> No?

I think you are right.

> 
> 
> I am looking into the git history now... and I guess I understand why
> reacquire_kernel_lock() uses current. Because schedule() did something
> like
> 
> 	prev = context_switch(prev, next);	// prev == last
> 
> 	finish_task_switch(prev);
> 
> 	reacquire_kernel_lock(current);		// prev != current

This is what I think when I wrote that patch. Now the task switch is
entirely finished in context_switch(). So commit log in 6d558c3a has
some flaw in it. The "prev" is also a churn.

Thanks,
Yong
