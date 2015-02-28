From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Generic page fault (Was: libsigsegv ....)
Date: Sat, 28 Feb 2015 18:14:06 +1100
Message-ID: <1425107646.4645.109.camel@kernel.crashing.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49475 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbB1HON (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2015 02:14:13 -0500
In-Reply-To: <1425107567.4645.108.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org

On Sat, 2015-02-28 at 18:12 +1100, Benjamin Herrenschmidt wrote:
> 
> Let me know what you think of the approach. It's boot tested on x86_64
> in qemu and 

 ... and powerpc64 LE on qemu as well :-)

Cheers,
Ben.
