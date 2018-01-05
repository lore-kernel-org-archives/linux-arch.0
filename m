From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and
 nospec_barrier
Date: Fri, 5 Jan 2018 09:11:59 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1801050906140.4515@hadrien>
References: <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com> <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com> <20180104010754.22ca6a74@alans-desktop> <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien> <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com> <20180104192648.GA10427@amd> <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com> <20180104224455.GA22369@amd>
 <CAPcyv4gVq=F-+8YX6ALUiL61MtOVtDzPrEo18WVsFodZ1YY20A@mail.gmail.com> <20180104233259.GA24680@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64880 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751284AbeAEIMB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jan 2018 03:12:01 -0500
In-Reply-To: <20180104233259.GA24680@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dan.j.williams@intel.com>, Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

It looks like the problem in terms of detection is to find values that
should be annotated as __user.  Poking around a bit, it seems like this
tool is doing just that:

http://www.cs.umd.edu/~jfoster/cqual/

It dates from 2004, but perhaps the developer could be motivated to pick
it up again.

I don't think Coccinelle would be good for doing this (ie implementing
taint analysis) because the dataflow is too complicated.

julia
