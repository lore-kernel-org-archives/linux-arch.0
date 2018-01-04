From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and
 nospec_barrier
Date: Thu, 4 Jan 2018 02:27:54 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
References: <20180103223827.39601-1-mark.rutland@arm.com>        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104010754.22ca6a74@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 4 Jan 2018, Alan Cox wrote:

> There are people trying to tune coverity and other tool rules to identify
> cases, 

Yeah, but that (and *especially* Coverity) is so inconvenient to be 
applied to each and every patch ... that this is not the way to go.

If the CPU speculation can cause these kinds of side-effects, it just must 
not happen, full stop. OS trying to work it around is just a whack-a-mole 
(which we can apply for old silicon, sure ... but not something that 
becomes a new standard) that's never going to lead to any ultimate 
solution.

-- 
Jiri Kosina
SUSE Labs
