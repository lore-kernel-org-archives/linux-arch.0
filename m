From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Tue, 23 Jun 2009 12:22:09 +1000
Message-ID: <1245723729.4017.31.camel@pasglop>
References: <20090622140807.25509.54448.stgit@bob.kio>
	 <20090622143431.GT19977@parisc-linux.org>
	 <20090623014322.GA6729@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54328 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbZFWCXh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2009 22:23:37 -0400
In-Reply-To: <20090623014322.GA6729@sequoia.sous-sol.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Alex Chiang <achiang@hp.com>, jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, 2009-06-22 at 18:43 -0700, Chris Wright wrote:
> > I'd like to know what the KVM / Xen / ... people think about this.
> > I don't know if they rely on function 5 being able to show up out of
> > the blue.
> 
> KVM does not rely on this.  Typically a multi-function device's BDF
> gets
> remapped between host and guest (usually becoming a single function,
> function 0).

I'm surprised you don't hit problems with some devices/drivers here,
I have distinct memories of seeing such things as drivers who need
to know their own function number reliably.

Cheers,
Ben.
