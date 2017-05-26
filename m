From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 2/4] watchdog: introduce arch_touch_nmi_watchdog()
Date: Fri, 26 May 2017 10:05:30 -0400
Message-ID: <20170526140530.s2rvwklbzoygppkm@redhat.com>
References: <20170525082856.21685-1-npiggin@gmail.com>
 <20170525082856.21685-3-npiggin@gmail.com>
 <20170525135559.ltu4coxjghx2ovce@redhat.com>
 <20170526103103.31fd6801@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936276AbdEZOFc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 10:05:32 -0400
Content-Disposition: inline
In-Reply-To: <20170526103103.31fd6801@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, May 26, 2017 at 10:31:03AM +1000, Nicholas Piggin wrote:
> On Thu, 25 May 2017 09:55:59 -0400
> Don Zickus <dzickus@redhat.com> wrote:
> 
> > On Thu, May 25, 2017 at 06:28:54PM +1000, Nicholas Piggin wrote:
> > > For architectures that define HAVE_NMI_WATCHDOG, instead of having
> > > them provide the complete touch_nmi_watchdog() function, just have
> > > them provide arch_touch_nmi_watchdog().
> > > 
> > > This gives the generic code more flexibility in implementing this
> > > function, and arch implementations don't miss out on touching the
> > > softlockup watchdog or other generic details.  
> > 
> > The idea makes sense.  I don't think you can have hld_touch_nmi_watchdog
> > defined with arch_touch_nmi_watchdog, so I am wondering if it makes sense to
> > combine them somehow.  Though renaming hld_touch_nmi_watchdog to
> > arch_touch_nmi_watchdog sounds odd, I think it mimics the idea.
> 
> Yeah I agree it's not quite right, and I think using
> arch_touch_nmi_watchdog would be fine for the hld, which makes sense
> if you think of it as a utility or library function for architectures
> that want a hardlockup watchdog and can use perf for it.

Yeah, if you wouldn't mind trying that.  Over the last year it seems there
is a push to make the hld more of a separate thing if folks want to use
perf.  I have been trying to tweak it so it can be used in-place of the arch
solution or just use the arch solution.  And still retain the same function
calls.

Cheers,
Don

> 
> I can change that if you prefer. BTW the 0day picked up another
> Kconfig compile bug, so I'll respin the series and include any changes
> you like.
> 
> Thanks,
> Nick
