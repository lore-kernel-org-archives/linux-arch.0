From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Mon, 29 Jun 2009 13:33:50 -0700
Message-ID: <20090629133350.66024000@jbarnes-g45>
References: <20090622140807.25509.54448.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49006 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbZF2Udt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Jun 2009 16:33:49 -0400
In-Reply-To: <20090622140807.25509.54448.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
Cc: linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, 22 Jun 2009 08:08:07 -0600
Alex Chiang <achiang@hp.com> wrote:

> This was #define'd as 0 on all platforms, so let's get rid of it.
> 
> This change makes pci_scan_slot() slightly easier to read.
> 
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kyle McMartin <kyle@mcmartin.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alex Chiang <achiang@hp.com>
> ---

Applied this to my linux-next tree, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
