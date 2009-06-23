From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Wed, 24 Jun 2009 07:47:44 +1000
Message-ID: <1245793664.10356.25.camel@pasglop>
References: <20090622140807.25509.54448.stgit@bob.kio>
	 <20090622143431.GT19977@parisc-linux.org> <4A3FCB68.3030004@goop.org>
	 <20090622183056.GY19977@parisc-linux.org> <1245714008.4017.7.camel@pasglop>
	 <20090623190826.GJ19977@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39436 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbZFWVtR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jun 2009 17:49:17 -0400
In-Reply-To: <20090623190826.GJ19977@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Alex Chiang <achiang@hp.com>, jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Avi Kivity <avi@redhat.com>

On Tue, 2009-06-23 at 13:08 -0600, Matthew Wilcox wrote:
> 
> I think simply materialising them, either the way the OF code does,
> or the way the IOV code does is the best route forwards.

Agreed. I'm fine with removing pcibios_scan_all_fns() for now anyway,
and leave whatever arch do care with the responsibility of finding a
solution though :-)

Regarding the OF stuff, I'll see what I can do vs. moving it to
drivers/pci some time next week after I'm done fixing the regressions
from this merge window :-)

Cheers,
Ben.
