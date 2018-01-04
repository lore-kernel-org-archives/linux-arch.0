From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and
 nospec_barrier
Date: Thu, 4 Jan 2018 02:59:47 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1801040253410.27010@gjva.wvxbf.pm>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com> <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com> <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm> <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 3 Jan 2018, Dan Williams wrote:

> Speaking from a purely Linux kernel maintenance process perspective we
> play wack-a-mole with missed endian conversions and other bugs that
> coccinelle, sparse, etc help us catch. 

Fully agreed.

> So this is in that same category, but yes, it's inconvenient.

Disagreed, violently. CPU has to execute the instructions I ask it to 
execute, and if it executes *anything* else that reveals any information 
about the instructions that have *not* been executed, it's flawed.

> Elena has done the work of auditing static analysis reports to a dozen
> or so locations that need some 'nospec' handling.

How exactly is that related (especially in longer-term support terms) to 
BPF anyway?

Thanks,

-- 
Jiri Kosina
SUSE Labs
