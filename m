From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 01:41:00 +0000
Message-ID: <20180104014100.3786e686@alans-desktop>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:42376 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbeADBl1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 20:41:27 -0500
In-Reply-To: <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>

On Thu, 4 Jan 2018 02:27:54 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Thu, 4 Jan 2018, Alan Cox wrote:
> 
> > There are people trying to tune coverity and other tool rules to identify
> > cases,   
> 
> Yeah, but that (and *especially* Coverity) is so inconvenient to be 
> applied to each and every patch ... that this is not the way to go.

Agreed enitely - and coverity is non-free which is even worse as a
dependancy. Right now we are in the 'what could be done quickly by a few
people' space. The papers are now published, so the world can work on
better solutions and extending more convenient tooling.

> If the CPU speculation can cause these kinds of side-effects, it just must 
> not happen, full stop. 

At which point your performance will resemble that of a 2012 atom
processor at best.

> OS trying to work it around is just a whack-a-mole 
> (which we can apply for old silicon, sure ... but not something that 
> becomes a new standard) that's never going to lead to any ultimate 
> solution.

In the ideal world it becomes possible for future processors to resolve
such markings down to no-ops. Will that be possible or will we get more
explicit ways to tell the processor what is unsafe - I don't
personally know but I do know that turning off speculation is not the
answer.

Clearly if the CPU must be told then C is going to have to grow some
syntax for it and some other languages are going to see 'taint' moving
from a purely software construct to a real processor one.

Alan
