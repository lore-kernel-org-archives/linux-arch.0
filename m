From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 21:23:59 +0000
Message-ID: <20180104212359.0b520868@alans-desktop>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
        <20180104014100.3786e686@alans-desktop>
        <nycvar.YFH.7.76.1801040243300.11852@cbobk.fhfr.pm>
        <20180104193936.GB10427@amd>
        <20180104203246.5ff65328@alans-desktop>
        <nycvar.YFH.7.76.1801042137560.11852@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1801042137560.11852@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 4 Jan 2018 21:39:24 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Thu, 4 Jan 2018, Alan Cox wrote:
> 
> > You never go from one user process to another except via the kernel. We
> > have no hardware scheduling going on. That means that if the kernel
> > and/or CPU imposes the correct speculation barriers you can't attack
> > anyone but yourself.  
> 
> So how does this work on HT with the shared BTB? There is no context 
> switch (and hence no IBPB) happening between the threads sharing it.
> 

If you are paranoid in that case you either need to schedule things that
trust each other together or disable the speculation while that situation
occurs. However the kernel is always in the position to make that
decision.

Alan
