From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Mon, 12 Jun 2017 16:41:56 -0400
Message-ID: <20170612204156.ov7ka2765t4gdakl@redhat.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170530012659.16791-4-npiggin@gmail.com>
 <20170602201500.urllmug33bjtuzen@redhat.com>
 <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
 <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
 <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
 <20170608160502.uzp7vmr7s4fj6hjm@redhat.com>
 <20170612180739.1aa4b123@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752903AbdFLUl6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jun 2017 16:41:58 -0400
Content-Disposition: inline
In-Reply-To: <20170612180739.1aa4b123@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jun 12, 2017 at 06:07:39PM +1000, Nicholas Piggin wrote:
> > > This would probably be the right direction to go in, but it will take
> > > slightly more I think. We first need to remove HAVE_NMI_WATCHDOG from
> > > meaning that an arch has its own watchdog and does not want any HLD
> > > stuff. I think with arch_touch_nmi_watchdog(), we can probably get there.
> > > 
> > > While transitioning, we could add a new option instead,
> > > 
> > > HAVE_ARCH_HARDLOCKUP_DETECTOR
> > > 
> > > I think HAVE_PERF_EVENTS_NMI is sufficient to imply it will use the PERF
> > > HLD. Possibly you could just change the name to be a bit more regular,
> > > HAVE_PERF_NMI_HARDLOCKUP_DETECTOR  
> > 
> > Actually, I don't think I can just rename it as it has a specific use to let
> > OPROFILE know the perf events are being NMI triggered as opposed to IRQ
> > triggered.
> > 
> > Though I like the direction you are going.  Then arches either have one or
> > the other.  Or in the ppc case it is dependent on what ppc platform is being
> > used.
> 
> Okay, glad we're on the same page conceptually :)
> 
> > 
> > Then the HARDLOCKUP_DETECTOR needs one or the other to work correctly with
> > the arch/<arch>/Kconfig explicitly stating which one to use?
> 
> Yeah I guess the arch would advertise it has the PERF_HLD or ARCH_HLD if
> it provides its own. HARDLOCKUP_DETECTOR option would then depend on
> one of the two being defined.
> 
> I could try redoing the series with those changes to Kconfig and see how
> it looks?

Yeah, if you wouldn't mind.  Sorry for dragging this out, but I feel like we
are getting close to have this defined properly which would allow us to
split the code up correctly in the future.

Cheers,
Don
