From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and
 nospec_barrier
Date: Thu, 4 Jan 2018 21:39:24 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801042137560.11852@cbobk.fhfr.pm>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com> <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com> <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm> <20180104014100.3786e686@alans-desktop> <nycvar.YFH.7.76.1801040243300.11852@cbobk.fhfr.pm> <20180104193936.GB10427@amd> <20180104203246.5ff65328@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45565 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753154AbeADUj2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 15:39:28 -0500
In-Reply-To: <20180104203246.5ff65328@alans-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>

On Thu, 4 Jan 2018, Alan Cox wrote:

> You never go from one user process to another except via the kernel. We
> have no hardware scheduling going on. That means that if the kernel
> and/or CPU imposes the correct speculation barriers you can't attack
> anyone but yourself.

So how does this work on HT with the shared BTB? There is no context 
switch (and hence no IBPB) happening between the threads sharing it.

-- 
Jiri Kosina
SUSE Labs
