From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 02:15:53 +0000
Message-ID: <20180104021553.32084de3@alans-desktop>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
        <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
        <alpine.LRH.2.00.1801040253410.27010@gjva.wvxbf.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:42542 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751867AbeADCQX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 21:16:23 -0500
In-Reply-To: <alpine.LRH.2.00.1801040253410.27010@gjva.wvxbf.pm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>

> Disagreed, violently. CPU has to execute the instructions I ask it to 
> execute, and if it executes *anything* else that reveals any information 
> about the instructions that have *not* been executed, it's flawed.

Then stick to in order processors. Just don't be in a hurry to get your
computation finished.

> > Elena has done the work of auditing static analysis reports to a dozen
> > or so locations that need some 'nospec' handling.  
> 
> How exactly is that related (especially in longer-term support terms) to 
> BPF anyway?

If you read the papers you need a very specific construct in order to not
only cause a speculative load of an address you choose but also to then
manage to cause a second operation that in some way reveals bits of data
or allows you to ask questions.

BPF allows you to construct those sequences relatively easily and it's
the one case where a user space application can fairly easily place code
it wants to execute in the kernel. Without BPF you have to find the right
construct in the kernel, prime all the right predictions and measure the
result without getting killed off. There are places you can do that but
they are not so easy and we don't (at this point) think there are that
many.

The same situation occurs in user space with interpreters and JITs,hence
the paper talking about javascript. Any JIT with the ability to do timing
is particularly vulnerable to versions of this specific attack because
the attacker gets to create the code pattern rather than have to find it.

Alan
