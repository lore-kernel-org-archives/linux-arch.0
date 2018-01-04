From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Wed, 3 Jan 2018 17:51:09 -0800
Message-ID: <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 3, 2018 at 5:27 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Thu, 4 Jan 2018, Alan Cox wrote:
>
>> There are people trying to tune coverity and other tool rules to identify
>> cases,
>
> Yeah, but that (and *especially* Coverity) is so inconvenient to be
> applied to each and every patch ... that this is not the way to go.
>
> If the CPU speculation can cause these kinds of side-effects, it just must
> not happen, full stop. OS trying to work it around is just a whack-a-mole
> (which we can apply for old silicon, sure ... but not something that
> becomes a new standard) that's never going to lead to any ultimate
> solution.

Speaking from a purely Linux kernel maintenance process perspective we
play wack-a-mole with missed endian conversions and other bugs that
coccinelle, sparse, etc help us catch. So this is in that same
category, but yes, it's inconvenient.

Alan already mentioned potential compiler changes and annotating
variables so that the compiler can help in the future, but until then
we need these explicit checks.

Elena has done the work of auditing static analysis reports to a dozen
or so locations that need some 'nospec' handling.

The point of this RFC is to level set across architectures on the
macros/names/mechanisms that should be used for the first round of
fixes.
