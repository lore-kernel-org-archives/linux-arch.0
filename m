From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Mon, 22 Jun 2009 15:26:02 +0100
Message-ID: <20090622142602.GA25289@linux-mips.org>
References: <20090622140807.25509.54448.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34253 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbZFVOaS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2009 10:30:18 -0400
Content-Disposition: inline
In-Reply-To: <20090622140807.25509.54448.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
Cc: jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jun 22, 2009 at 08:08:07AM -0600, Alex Chiang wrote:

> This was #define'd as 0 on all platforms, so let's get rid of it.
> 
> This change makes pci_scan_slot() slightly easier to read.

I don't see why one would want to have a non-zero pcibios_scan_all_fns()
anyway.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
