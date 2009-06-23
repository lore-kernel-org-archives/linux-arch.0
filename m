From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Mon, 22 Jun 2009 18:43:22 -0700
Message-ID: <20090623014322.GA6729@sequoia.sous-sol.org>
References: <20090622140807.25509.54448.stgit@bob.kio> <20090622143431.GT19977@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sous-sol.org ([216.99.217.87]:49308 "EHLO sequoia.sous-sol.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751464AbZFWBtI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2009 21:49:08 -0400
Content-Disposition: inline
In-Reply-To: <20090622143431.GT19977@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alex Chiang <achiang@hp.com>, jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>

* Matthew Wilcox (matthew@wil.cx) wrote:
> I'd like to know what the KVM / Xen / ... people think about this.
> I don't know if they rely on function 5 being able to show up out of
> the blue.

KVM does not rely on this.  Typically a multi-function device's BDF gets
remapped between host and guest (usually becoming a single function,
function 0).

thanks,
-chris
