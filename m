Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:41993 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeADByt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 20:54:49 -0500
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2018 17:54:47 -0800
Message-ID: <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
Message-ID: <20180104015447._rjDQB6KKi_a-G_LaDSC2-SnBuSKVtiRuc0Okgpds-E@z>

On Wed, Jan 3, 2018 at 5:51 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Elena has done the work of auditing static analysis reports to a dozen
> or so locations that need some 'nospec' handling.

I'd love to see that patch, just to see how bad things look.

Because I think that really is very relevant to the interface too.

If we're talking "a dozen locations" that are fairly well constrained,
that's very different from having thousands all over the place.

                  Linus
