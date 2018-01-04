From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Wed, 3 Jan 2018 19:12:41 -0800
Message-ID: <20180104031239.f2sat4ozqvqxaatr@ast-mbp.dhcp.thefacebook.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <alpine.LRH.2.00.1801040253410.27010@gjva.wvxbf.pm>
 <20180104021553.32084de3@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:44023 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeADDMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 22:12:46 -0500
Content-Disposition: inline
In-Reply-To: <20180104021553.32084de3@alans-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>

On Thu, Jan 04, 2018 at 02:15:53AM +0000, Alan Cox wrote:
> 
> > > Elena has done the work of auditing static analysis reports to a dozen
> > > or so locations that need some 'nospec' handling.  
> > 
> > How exactly is that related (especially in longer-term support terms) to 
> > BPF anyway?
> 
> If you read the papers you need a very specific construct in order to not
> only cause a speculative load of an address you choose but also to then
> manage to cause a second operation that in some way reveals bits of data
> or allows you to ask questions.
> 
> BPF allows you to construct those sequences relatively easily and it's
> the one case where a user space application can fairly easily place code
> it wants to execute in the kernel. Without BPF you have to find the right
> construct in the kernel, prime all the right predictions and measure the
> result without getting killed off. There are places you can do that but
> they are not so easy and we don't (at this point) think there are that
> many.

for BPF in particular we're thinking to do a different fix.
Instead of killing speculation we can let cpu speculate.
The fix will include rounding up bpf maps to nearest power of 2 and
inserting bpf_and operation on the index after bounds check,
so cpu can continue speculate beyond bounds check, but it will
load from zero-ed memory.
So this nospec arch dependent hack won't be necessary for bpf side,
but may still be needed in other parts of the kernel.

Also note that variant 1 is talking about exploiting prog_array
bpf feature which had 64-bit access prior to
commit 90caccdd8cc0 ("bpf: fix bpf_tail_call() x64 JIT")
That was a fix for JIT and not related to this cpu issue, but
I believe it breaks the existing exploit.

Since it's not clear whether it's still possible to use bpf
with 32-bit speculation only, we're going to do this rounding fix
for unpriv just in case.
