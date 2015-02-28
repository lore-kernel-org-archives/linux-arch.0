From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Generic page fault (Was: libsigsegv ....)
Date: Sat, 28 Feb 2015 21:36:54 +1100
Message-ID: <1425119814.4645.114.camel@kernel.crashing.org>
References: <1422361485.6648.71.camel@opensuse.org>
	 <54C78756.9090605@suse.cz>
	 <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	 <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
	 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	 <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
	 <CAMo8BfLsKCV_2NfgMH4k9jGOHs_-3=NKjCD3o3KK1uH23-6RRg@mail.gmail.com>
	 <CA+55aFzQ5QEZ1AYauWviq1gp5j=mqByAtt4fpteeK7amuxcyjw@mail.gmail.com>
	 <1422836637.17302.9.camel@au1.ibm.com>
	 <CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
	 <1425107567.4645.108.camel@kernel.crashing.org>
	 <1425107646.4645.109.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58959 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbbB1KhE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2015 05:37:04 -0500
In-Reply-To: <1425107646.4645.109.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org

On Sat, 2015-02-28 at 18:14 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2015-02-28 at 18:12 +1100, Benjamin Herrenschmidt wrote:
> > 
> > Let me know what you think of the approach. It's boot tested on x86_64
> > in qemu and 
> 
>  ... and powerpc64 LE on qemu as well :-)

One thing I'd like to do is fold handle_kernel_fault() into
handle_bad_area() (and in fact fold do_sigbus as well).

Basically have a single handle_bad_fault() that takes sig and si_code as
arguments which we call from the generic code for all faults. It will
test for kernel vs. user mode and do the right thing (and we could
handle the sigbus special case by simply comparing sig to sigbus).

The one reason I haven't done it so far is that x86 handle_bad_area()
has the is_f00f_bug() call which isn't do for other cases of
no_context() and I'm not sure generalizing it is safe for all cases (or
maybe I can call it only when sig is SIGSEGV ?) ... I don't actually
understand what it does :)

Cheers,
Ben.
