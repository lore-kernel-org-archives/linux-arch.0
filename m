From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 4/4] watchdog: provide watchdog_reconfigure() for arch
 watchdogs
Date: Fri, 26 May 2017 10:21:53 -0400
Message-ID: <20170526142153.wmalzlgbdwutomdj@redhat.com>
References: <20170525082856.21685-1-npiggin@gmail.com>
 <20170525082856.21685-5-npiggin@gmail.com>
 <20170525140833.3qkuvoiavlf5ra6d@redhat.com>
 <20170526103909.04f7710c@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935653AbdEZOVy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 10:21:54 -0400
Content-Disposition: inline
In-Reply-To: <20170526103909.04f7710c@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, May 26, 2017 at 10:39:09AM +1000, Nicholas Piggin wrote:
> On Thu, 25 May 2017 10:08:33 -0400
> Don Zickus <dzickus@redhat.com> wrote:
> 
> > On Thu, May 25, 2017 at 06:28:56PM +1000, Nicholas Piggin wrote:
> > > After reconfiguring watchdog sysctls etc., architecture specific
> > > watchdogs may not get all their parameters updated.
> > > 
> > > watchdog_reconfigure() can be implemented to pull the new values
> > > in and set the arch NMI watchdog.  
> > 
> > I understand the reason for this patch and I don't have any real objection
> > on how it was implemented within the constraints of all the current logic.
> > 
> > I just wonder if the current logic should be adjusted to make the hardlockup
> > detector, namely the perf implementation more separate so it can handle what
> > you would like more cleanly.
> > 
> > The watchdog_nmi_reconfigure is sort of hackish, but it is hard to fault you
> > based on how things are designed.  I am going to poke at it a little bit,
> > but I will probably not find time to do much and accept what you have for
> > now.
> 
> I actually agree with you. These patches are basically an initial bridge
> to get us to decoupling hld-perf from hld-arch, but the code could
> definitely use several more passes to clean things up.

Makes sense. :-)

> 
> One thing we want to be mindful of is some watchdogs are very light weight,
> minimal, and some may not even want to call C code (at least from the NMI

Agreed.

> and touch-watchdog paths). But having said that, it may not be a bad idea
> to have implementations provide a watchdog driver struct with some of the
> methods and reconfiguration they support. E.g., suspend/resume, stop/start
> on CPUs, adjust timeouts, etc.).

Hehe.  I was hoping to avoid doing that, but it may lead there over time.

> 
> I didn't want to go the whole hog and over-engineer something that doesn't
> work though, so I'm hoping we can get the powerpc watchdog in, and then
> keep working on the apis.

Agreed. 

> 
> Let me know what you think after you poke at it though.

I will.

Cheers,
Don
