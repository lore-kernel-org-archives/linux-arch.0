From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped by
 host
Date: Fri, 16 Dec 2011 07:31:49 -0200
Message-ID: <20111216093149.GA26982@amt.cnet>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net>
 <4EDF7B0D.4060001@redhat.com>
 <20111214121622.GB18317@amt.cnet>
 <4EE8B53C.6070502@redhat.com>
 <20111214182101.GB21945@amt.cnet>
 <4EE9CA1C.3010801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28736 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756156Ab1LPLGg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Dec 2011 06:06:36 -0500
Content-Disposition: inline
In-Reply-To: <4EE9CA1C.3010801@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Eric B Munson <emunson@mgebm.net>, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 15, 2011 at 12:21:16PM +0200, Avi Kivity wrote:
> On 12/14/2011 08:21 PM, Marcelo Tosatti wrote:
> > On Wed, Dec 14, 2011 at 04:39:56PM +0200, Avi Kivity wrote:
> > > On 12/14/2011 02:16 PM, Marcelo Tosatti wrote:
> > > > > Having this controlled from userspace means it doesn't work for SIGSTOP
> > > > > or for long scheduling delays.  What about doing this automatically
> > > > > based on preempt notifiers?
> > > >
> > > > Long scheduling delays should be considered hangups from the guest
> > > > perspective.
> > > 
> > > Why?  To the guest it looks like slow hardware, but it will interpret it
> > > as a softlockup.
> >
> > Slow enough that progress of the watchdog thread is unable to keep up
> > with timer interrupt processing. This is considered a hang and
> > should be reported.
> 
> It's not a guest hang though!

No, but your host system is in such a load state that for the sake of
system usability you better print out a warning message.

I don't see the advantage of preempt notifiers over the simple, paravirt
solution proposed? Note kvmclock is already paravirt.

What do you want to be done in preempt notifiers? Measure what to
consider setting this flag?
