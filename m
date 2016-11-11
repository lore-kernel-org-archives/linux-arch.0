From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCHv2 0/2] THREAD_INFO_IN_TASK prep work for arm64+s390
Date: Fri, 11 Nov 2016 10:16:22 +0100
Message-ID: <20161111091622.GA4019@osiris>
References: <1477503787-25537-1-git-send-email-mark.rutland@arm.com>
 <20161102155020.GA17547@remoulade>
 <20161110181307.GC10137@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110181307.GC10137@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, linux-arch@vger.kernel.org, akpm@linux-foundation.org, keescook@chromium.org, luto@kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Hi Mark,

> On Wed, Nov 02, 2016 at 03:56:26PM +0000, Mark Rutland wrote:
> > On Wed, Oct 26, 2016 at 06:43:05PM +0100, Mark Rutland wrote:
> > > Heiko and I have been working on THREAD_INFO_IN_TASK for s390 and arm64
> > > respectively, and we're both targetting v4.10.
> > > 
> > > These are the common core changes which we both require. I've put together a
> > > branch [1,2] based on v4.9-rc2. I intend to tag this at some point next week so
> > > that Heiko and I have a stable base.
> > 
> > As a heads-up, I've collated the tags I've received in the last few days, along
> > with the comment Andy requested in the v1 thread, and tagged this as
> > core-ti-stack-split [1].
> > 
> > Thanks,
> > Mark.
> > 
> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core-ti-stack-split
> 
> I believe that Catalin's hoping to take my arm64 patches for v4.10,
> using the above tag as a base.
> 
> What's the plan for s390? Are you happy to do the same?

We intend to merge the s390 variant also for v4.10. Our approach has
changed however: we came to the conclusion that having a per-cpu preempt
count will generate better code on s390; so Martin implemented that.

And while being at it he also moved the rest of the s390 specific stuff out
of our struct thread_info. The corresponding patches will be pushed to

git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features

branch soon.

In result we will have a struct thread_info that only contains the flags
field like x86 does.
So we don't depend an any other patches anymore...
