Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34686 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757646Ab3FLBE7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Jun 2013 21:04:59 -0400
Date: Tue, 11 Jun 2013 17:56:05 -0700
From: Greg KH <greg@kroah.com>
Subject: Re: Get rid of cpuinit?
Message-ID: <20130612005605.GA7469@kroah.com>
References: <519AA53F.1020107@zytor.com>
 <20130520231203.GA21682@kroah.com>
 <20130528092038.GC32068@gmail.com>
 <CAP=VYLo047g+U3GJhkObJtNPubFNpHuGUJAF7oOh_7dPtSFd9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP=VYLo047g+U3GJhkObJtNPubFNpHuGUJAF7oOh_7dPtSFd9A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20130612005605.zsEPkfXd3FMrB9bTDgfpfZsblNo-Ttzw3xqRqJ6tnm0@z>

On Tue, Jun 11, 2013 at 08:31:55PM -0400, Paul Gortmaker wrote:
> On Tue, May 28, 2013 at 5:20 AM, Ingo Molnar <mingo@kernel.org> wote:
> >
> > * Greg KH <greg@kroah.com> wrote:
> >
> >> On Mon, May 20, 2013 at 03:35:43PM -0700, H. Peter Anvin wrote:
> >> > We have gotten rid of devinit markup.  A recent patch of Linus' makes me
> >> > wonder if we similarly should get rid of cpuinit markup?
> >> >
> >> > Just as with devices, the CPU hotplug machinery has been leveraged to
> >> > support a number of pieces of functionality such as suspend, which means
> >> > that on anything but the most embedded systems this functionality is
> >> > likely needed anyway.
> >> >
> >> > On x86-64, for an "allyesconfig" build, the total amount of space in all
> >> > the .cpu* sections combined is 100K.
> >>
> >> No objection from me on removing it, it just causes problems from what I
> >> can tell.
> >
> > Indeed, there's a steady trickle of mis-annotated cpuinit sections, and no
> > real tooling to make the annotations automatic or so in most of the cases.
> > Manual simply does not seem to work in this case.
> 
> Is anyone actively working on weeding this out?  If not, it is probably
> one of those tree-wide kind of changes that I can volunteer to tackle...

I say go for it.

greg k-h
