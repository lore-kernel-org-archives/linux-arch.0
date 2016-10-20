From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] sched/core,x86: make struct thread_info arch
 specific again
Date: Thu, 20 Oct 2016 10:33:53 +0100
Message-ID: <20161020093353.GB10234@leverpostej>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
 <1476901693-8492-2-git-send-email-mark.rutland@arm.com>
 <CALCETrUG06KGckAqr-nkPTsRnowJFJ6JxuYyg3o48t4_MRQang@mail.gmail.com>
 <20161020064045.GA29032@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758503AbcJTJeY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Oct 2016 05:34:24 -0400
Content-Disposition: inline
In-Reply-To: <20161020064045.GA29032@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Oct 20, 2016 at 08:40:45AM +0200, Ingo Molnar wrote:
> 
> * Andy Lutomirski <luto@amacapital.net> wrote:
> 
> > On Wed, Oct 19, 2016 at 11:28 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > >
> > > commit c65eacbe290b ("sched/core: Allow putting thread_info into
> > > task_struct") made struct thread_info a generic struct with only a
> > > single flags member if THREAD_INFO_IN_TASK_STRUCT is selected.
> > >
> > > This change however seems to be quite x86 centric, since at least the
> > > generic preemption code (asm-generic/preempt.h) assumes that struct
> > > thread_info also has a preempt_count member, which apparently was not
> > > true for x86.
> > >
> > > We could add a bit more ifdefs to solve this problem too, but it seems
> > > to be much simpler to make struct thread_info arch specific
> > > again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
> > > bit easier for architectures that have a couple of arch specific stuff
> > > in their thread_info definition.
> > >
> > > The arch specific stuff _could_ be moved to thread_struct. However
> > > keeping them in thread_info makes it easier: accessing thread_info
> > > members is simple, since it is at the beginning of the task_struct,
> > > while the thread_struct is at the end. At least on s390 the offsets
> > > needed to access members of the thread_struct (with task_struct as
> > > base) are too large for various asm instructions.  This is not a
> > > problem when keeping these members within thread_info.
> > 
> > Acked-by: Andy Lutomirski <luto@kernel.org>
> > 
> > Ingo, there's a (somewhat weak) argument for sending this via
> > tip/urgent: it doesn't change generated code at all, and I think it
> > will avoid a silly depedency or possible conflict for the next merge
> > window, since both arm64 and s390 are going to need it.
> 
> Can certainly do it if this is the final version of the patch. Mark?

Yes; this is the final version of this patch.

I can rebase the other two core patches atop, assuming this goes in for
a v4.9-rc* tag soon.

Thanks,
Mark.
