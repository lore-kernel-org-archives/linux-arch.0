From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] thread_info: include <current.h> for
 THREAD_INFO_IN_TASK
Date: Fri, 28 Oct 2016 11:48:06 +0100
Message-ID: <20161028104806.GF5806@leverpostej>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
 <1476901693-8492-4-git-send-email-mark.rutland@arm.com>
 <CALCETrUqApnWBwFPwkToTp1_Wm68tbPAW=UH+X5mZrNS+3rHjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbcJ1Ksl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Oct 2016 06:48:41 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrUqApnWBwFPwkToTp1_Wm68tbPAW=UH+X5mZrNS+3rHjA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Oct 27, 2016 at 04:13:49PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 19, 2016 at 11:28 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > When CONFIG_THREAD_INFO_IN_TASK is selected, the current_thread_info()
> > macro relies on current having been defined prior to its use. However,
> > not all users of current_thread_info() include <asm/current.h>, and thus
> > current is not guaranteed to be defined.
> >
> > When CONFIG_THREAD_INFO_IN_TASK is not selected, it's possible that
> > get_current() / current are based upon current_thread_info(), and
> > <asm/current.h> includes <asm/thread_info.h>. Thus always including
> > <asm/current.h> would result in circular dependences on some platforms.
> >
> > To ensure both cases work, this patch includes <asm/current.h>, but only
> > when CONFIG_THREAD_INFO_IN_TASK is selected.
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>

Cheers!

> although it would be nice if you moved your description of why the
> include is conditional into a comment.

Agreed. I've folded in the below:

#ifdef CONFIG_THREAD_INFO_IN_TASK
/*
 * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
 * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
 * including <asm/current.h> can cause a circular dependency on some platforms.
 */
#include <asm/current.h>
#define current_thread_info() ((struct thread_info *)current)
#endif

Thanks,
Mark.
