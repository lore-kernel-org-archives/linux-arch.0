From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Wed, 3 Jan 2018 16:39:31 -0800
Message-ID: <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36941 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeADAjc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 19:39:32 -0500
In-Reply-To: <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Wed, Jan 3, 2018 at 4:15 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> The 'if_nospec' primitive marks locations where the kernel is disabling
> speculative execution that could potentially access privileged data. It
> is expected to be paired with a 'nospec_{ptr,load}' where the user
> controlled value is actually consumed.

I'm much less worried about these "nospec_load/if" macros, than I am
about having a sane way to determine when they should be needed.

Is there such a sane model right now, or are we talking "people will
randomly add these based on strong feelings"?

                    Linus
