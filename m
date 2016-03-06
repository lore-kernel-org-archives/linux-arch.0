From: Christoph Hellwig <hch@lst.de>
Subject: two small PCI header cleanups
Date: Sun,  6 Mar 2016 16:17:52 +0100
Message-ID: <1457277475-8913-1-git-send-email-hch@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42201 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbcCFPR7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Mar 2016 10:17:59 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Move a header from asm-generic to Linux because it isn't a generic arch
implementation, and also implement the pci_dma_* helpers in common code.
