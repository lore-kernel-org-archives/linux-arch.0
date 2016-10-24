From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] thread_info: include <current.h> for
 THREAD_INFO_IN_TASK
Date: Mon, 24 Oct 2016 10:49:31 +0100
Message-ID: <20161024094931.GB15620@leverpostej>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
 <1476901693-8492-4-git-send-email-mark.rutland@arm.com>
 <20161020102925.GA3529@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936310AbcJXJuD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Oct 2016 05:50:03 -0400
Content-Disposition: inline
In-Reply-To: <20161020102925.GA3529@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, hpa@zytor.com, keescook@chromium.org, luto@kernel.org, mingo@redhat.com, tglx@linutronix.de

On Thu, Oct 20, 2016 at 12:29:26PM +0200, Heiko Carstens wrote:
> On Wed, Oct 19, 2016 at 07:28:13PM +0100, Mark Rutland wrote:
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
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Kees Cook <keescook@chromium.org> 
> > ---
> >  include/linux/thread_info.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> > index c75c6ab..ef1f4b0 100644
> > --- a/include/linux/thread_info.h
> > +++ b/include/linux/thread_info.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/restart_block.h>
> >  
> >  #ifdef CONFIG_THREAD_INFO_IN_TASK
> > +#include <asm/current.h>
> >  #define current_thread_info() ((struct thread_info *)current)
> >  #endif
> 
> FWIW:
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Cheers!

Would you be happy to do the same for patch 2?

Once these have a couple more acks I'll drop these on a (hopefully)
stable branch, tagged so that we can both use them as a base.

Thanks,
Mark.
