Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753628AbeDSQIa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Apr 2018 12:08:30 -0400
Date: Thu, 19 Apr 2018 18:08:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH] s390: add arch_change_pid for arch updates after
 task pid change
Message-ID: <20180419160827.GB19917@redhat.com>
References: <1524120286-19066-1-git-send-email-schwidefsky@de.ibm.com>
 <20180419140729.GA19917@redhat.com>
 <20180419162056.6b657d71@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419162056.6b657d71@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 04/19, Martin Schwidefsky wrote:
>
> On Thu, 19 Apr 2018 16:07:29 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 04/19, Martin Schwidefsky wrote:
> > >
> > > In a multi-threaded program any thread can call execve(). If this
> > > is not done by the thread group leader, the de_thread() function
> > > replaces the pid of the task that calls execve() with the pid of
> > > thread group leader. If the task reaches user space again without
> > > going over __switch_to() the sampling tag is still set to the old
> > > pid.
> >
> > If this is the only reason for arch_change_pid() hook, then perhaps
> > it would be better/simpler to add it into de_thread() right after
> > change_pid(tsk, PIDTYPE_PID, task_pid(leader)) ?
> >
> > note also that this way arch_change_pid() doesn't need any checks and
> > any arguments, you can simply do
> >
> > void arch_change_pid(void)
> > {
> > 	S390_lowcore.current_pid = current->pid;
> > 	if (test_facility(40))
> > 		lpp(&S390_lowcore.lpp);
> > }
>
> Yeah, the first patch I created to verify that this indeed the problem
> basically looked like your proposal. But then why not make it a more
> general hook for any kind of PID change?

Well, I doubt very much we will ever need an arch-specific hook for
sys_setsid() or setpgid()... plus

> Dunno if this is a worthwhile
> approach, the simpler version for sure works as well.

and perhaps you can make another, even more simple change? can't you just
introduce the s390 version of arch_setup_new_exec, something like

	void arch_setup_new_exec(void)
	{
		if (S390_lowcore.current_pid != current->pid) {
			S390_lowcore.current_pid = current->pid;
			...
		}
	}

?

Oleg.
