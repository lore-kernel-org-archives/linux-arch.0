From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: PCI: allocate space top-down, not bottom-up
Date: Fri, 24 Sep 2010 15:12:45 -0600
Message-ID: <201009241512.45944.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:27351 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab0IXVNg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2010 17:13:36 -0400
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id A8A22248E8
	for <linux-arch@vger.kernel.org>; Fri, 24 Sep 2010 21:13:35 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

I have a few patches queued up for the next merge window that
change the way we allocate PCI resources.  They are targeted at
x86, but some of the changes will affect other architectures, and
it's possible other arches may want to do something similar to
the x86-specific part.

The LKML posting starts here:
  http://marc.info/?l=linux-kernel&m=128476278029918&w=2

Here's the general description, and the individual patches have
specific examples:

  When we move PCI devices, we currently allocate space bottom-up,
  i.e., we look at PCI bus resources in the order we found them,
  we look at gaps between child resources bottom-up, and we align
  the new space at the bottom of an available region.
  ...

  These patches change Linux to allocate space more like Windows does:

    1) The x86 pcibios_align_resource() will choose space from the
       end of an available area, not the beginning.

    2) In the generic allocate_resource() path, we'll look for space
       between existing children from the top, not from the bottom.

    3) When pci_bus_alloc_resource() looks for available space, it
       will start from the highest window, not the first one we found.

This is just FYI; no action required unless you want to do something
similar in your pcibios_align_resource(), or you see an issue with
the generic changes on your arch.

Bjorn
