From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Wed, 24 Jun 2009 01:43:17 +0900
Message-ID: <20090623164316.GF26674@linux-sh.org>
References: <20090622140807.25509.54448.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:57287 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbZFWQoQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2009 12:44:16 -0400
Content-Disposition: inline
In-Reply-To: <20090622140807.25509.54448.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
Cc: jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jun 22, 2009 at 08:08:07AM -0600, Alex Chiang wrote:
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

Acked-by: Paul Mundt <lethal@linux-sh.org>
