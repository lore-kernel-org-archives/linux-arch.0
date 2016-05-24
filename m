From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Enhancing semantics with memremap() - aliasing with memremap()
Date: Tue, 24 May 2016 16:36:42 -0700
Message-ID: <CAB=NE6Wy=V17uwc3GNMYaWk4cOx1a1TtHBgMYii-M5FDuPn_Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38130 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbcEXXhH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 May 2016 19:37:07 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hp.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@infradead.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>

Dan, Toshi, Christoph,

I recall a while ago while memremap() was being introduced we
discussed making stronger semantics for memremap() a desirable future
goal [0], along with removal cleanups of ioremap_cache(). This was
when only 2 types were being considered, WB and WT. I see we now have
WC as well for the memremap() family.

Among one of the semantic topics, on the x86 side of things we seem to
have at least concluded we want to at the very least start by
completely discouraging and warning alias uses for different
conflicting types. A recent patch by Toshi helps to find these at run
time, however it may be possible to do this proactively semantically
with Coccinelle as well, but we first need an example test driver with
all known invalid uses cases to write up some grammar rules for the
hunt.

A much much longer term goal would be properly identify only those
valid uses for aliasing, and have a special API for them. This will
take time for the above reaons. During the memremap() review we seemed
to have agreed that making stronger semantics for memremap() was also
desirable, more aimed towards addressing this as a future goal.

Is it a good time for that now? I would hope identifying proper
aliasing uses for memremap() might be a bit easier now than for
ioremap() given its not used as widely. It may be an easier target to
also write some grammar rules for it as well.

[0] http://lkml.kernel.org/r/CAPcyv4g0-CcFRCWPBdKB7h0zZEO5qzT-N9YLYJw9sb=_HYnXiA@mail.gmail.com>

  Luis
