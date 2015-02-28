From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Generic page fault (Was: libsigsegv ....)
Date: Sun, 01 Mar 2015 09:50:29 +1100
Message-ID: <1425163829.4645.152.camel@kernel.crashing.org>
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
	 <CA+55aFy5UvzSgOMKq09u4psz5twtC4aowuK6tofGKDEu-KFMJQ@mail.gmail.com>
	 <1425158083.4645.139.camel@kernel.crashing.org>
	 <1425161796.4645.149.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45151 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbbB1Wuh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2015 17:50:37 -0500
In-Reply-To: <1425161796.4645.149.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>

On Sun, 2015-03-01 at 09:16 +1100, Benjamin Herrenschmidt wrote:
> So for error handling, I'm trying to simply return the VM_FAULT_* flags
> from generic_page_fault see where that takes us. That's a way to avoid
> passing an arch specific struct around. It also allows my hack to
> account major faults with the hypervisor to be done outside the generic
> code completely (no hook).

I suspect sparc64 will defeat the "not passing an arch struct around"
though... oh well.

Ben.
