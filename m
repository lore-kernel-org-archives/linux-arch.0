Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752949AbeADLrh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 06:47:37 -0500
Date: Thu, 4 Jan 2018 11:47:32 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Message-ID: <20180104114732.utkixumxt7rfuf3g@salmiak>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
 <1515035438.20588.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515035438.20588.4.camel@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180104114732.4cUHfB-h53Ba1adcUTPO8wG5-zxSjAnlWxiRLcYY6Nk@z>

Hi Dan,

Thanks for these examples.

On Thu, Jan 04, 2018 at 03:10:51AM +0000, Williams, Dan J wrote:
> Note, the following is Elena's work, I'm just helping poke the upstream
> discussion along while she's offline.
> 
> Elena audited the static analysis reports down to the following
> locations where userspace provides a value for a conditional branch and
> then later creates a dependent load on that same userspace controlled
> value.
> 
> 'osb()', observable memory barrier, resolves to an lfence on x86. My
> concern with these changes is that it is not clear what content within
> the branch block is of concern. Peter's 'if_nospec' proposal combined
> with Mark's 'nospec_load' would seem to clear that up, from a self
> documenting code perspective, and let archs optionally protect entire
> conditional blocks or individual loads within those blocks.

I'm a little concerned by having to use two helpers that need to be paired. It
means that we have to duplicate the bounds information, and I suspect in
practice that they'll often be paired improperly.

I think that we can avoid those problems if we use nospec_ptr() on its own. It
returns NULL if the pointer would be out-of-bounds, so we can use it in the
if-statement.

On x86, that can contain the bounds checks followed be an OSB / lfence, like
if_nospec(). On arm we can use our architected sequence. In either case,
nospec_ptr() returns NULL if the pointer would be out-of-bounds.

Then, rather than sequences like:

	if_nospec(idx < max) {
		val = nospec_array_load(array, idx, max);
		...
	}

... we could have:

	if ((elem_ptr = nospec_array_ptr(array, idx, max)) {
		val = *elem_ptr;
		...
	}

... which also means we don't have to annotate every single load in the branch
if the element is a structure with multiple fields.

Does that sound workable to you?
