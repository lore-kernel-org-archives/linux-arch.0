From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and
 nospec_barrier
Date: Thu, 4 Jan 2018 02:47:51 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801040243300.11852@cbobk.fhfr.pm>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com> <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com> <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm> <20180104014100.3786e686@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104014100.3786e686@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 4 Jan 2018, Alan Cox wrote:

> > If the CPU speculation can cause these kinds of side-effects, it just must 
> > not happen, full stop. 
> 
> At which point your performance will resemble that of a 2012 atom
> processor at best.

You know what? I'd be completely fine with that, if it's traded for "my 
ssh and internet banking keys are JUST MINE, ok?" :)

> Clearly if the CPU must be told then C is going to have to grow some
> syntax for it and some other languages are going to see 'taint' moving
> from a purely software construct to a real processor one.

Again, what is the problem with "yeah, it turned out to speed things up in 
the past, but hey, it has security issues, so we stopped doing it" 
aproach?

Thanks,

-- 
Jiri Kosina
SUSE Labs
