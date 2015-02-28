From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Generic page fault (Was: libsigsegv ....)
Date: Sun, 01 Mar 2015 09:16:36 +1100
Message-ID: <1425161796.4645.149.camel@kernel.crashing.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52311 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbbB1WQq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2015 17:16:46 -0500
In-Reply-To: <1425158083.4645.139.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>

So for error handling, I'm trying to simply return the VM_FAULT_* flags
from generic_page_fault see where that takes us. That's a way to avoid
passing an arch specific struct around. It also allows my hack to
account major faults with the hypervisor to be done outside the generic
code completely (no hook).

We will process generically some of the flags first such as the repeat
logic or major/minor accounting of course.

For that to work, I'm adding a VM_FAULT_ACCESS (that gets OR'ed with
VM_FAULT_SIGSEGV) to differentiate SEGV_MAPERR and SEGV_ACCERR. So far
so good.

However, I noticed a small discrepancy on x86 in the handling of fatal
signals:

I see two path that can be hit on a fatal signal. The "obvious"
one is the one in access_error() which calls no_context() with a 0
signal argument, the other path is in the retry handling, which will in
this case call no_context() with SIGBUS/BUS_ADRERR. 

Now, the only place in there that seems to care about the signal that
gets passed in is the sig_on_uaccess_error case. On one case (0 sig),
that test will be skipped, on the other case (SIGBUS), that test will be
done and might result in a sigbus being generated, which might override
the original deadly signal (or am I missing something ?)

Now I don't completely understand how the x86 vsyscall stuff works so I
don't know precisely in what circumstances that test matters, I'll need
you help there.

Cheers,
Ben.
