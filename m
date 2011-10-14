From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 15/29] sparc32, leon/PCI: convert to
 pci_scan_root_bus() for correct root bus resources
Date: Fri, 14 Oct 2011 00:43:41 -0400 (EDT)
Message-ID: <20111014.004341.375430413116543198.davem@davemloft.net>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
	<20111014042823.23504.88314.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:34056 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab1JNEoE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2011 00:44:04 -0400
In-Reply-To: <20111014042823.23504.88314.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Oct 2011 22:28:23 -0600

> Convert from pci_scan_bus_parented() to pci_scan_root_bus() and remove root
> bus resource fixups.  This fixes the problem of "early" and "header" quirks
> seeing incorrect root bus resources.
> 
> pci_scan_root_bus() also includes the pci_bus_add_devices() so we don't
> need to do that separately.
> 
> CC: David S. Miller <davem@davemloft.net>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
