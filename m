From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 01:07:54 +0000
Message-ID: <20180104010754.22ca6a74@alans-desktop>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:42226 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbeADBIX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 20:08:23 -0500
In-Reply-To: <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Wed, 3 Jan 2018 16:39:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jan 3, 2018 at 4:15 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > The 'if_nospec' primitive marks locations where the kernel is disabling
> > speculative execution that could potentially access privileged data. It
> > is expected to be paired with a 'nospec_{ptr,load}' where the user
> > controlled value is actually consumed.  
> 
> I'm much less worried about these "nospec_load/if" macros, than I am
> about having a sane way to determine when they should be needed.
> 
> Is there such a sane model right now, or are we talking "people will
> randomly add these based on strong feelings"?

There are people trying to tune coverity and other tool rules to identify
cases, and some of the work so far was done that way. For x86 we didn't
find too many so far so either the needed pattern is uncommon or ....  8)

Given you can execute over a hundred basic instructions in a speculation
window it does need to be a tool that can explore not just in function
but across functions. That's really tough for the compiler itself to do
without help.

What remains to be seen is if there are other patterns that affect
different processors.

In the longer term the compiler itself needs to know what is and isn't
safe (ie you need to be able to write things like

void foo(tainted __user int *x)

and have the compiler figure out what level of speculation it can do and
(on processors with those features like IA64) when it can and can't do
various kinds of non-trapping loads.

Alan
