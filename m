From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: two small PCI header cleanups
Date: Sun, 6 Mar 2016 21:47:03 +0100
Message-ID: <201603062147.03753.arnd@arndb.de>
References: <1457277475-8913-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56219 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcCFUrM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Mar 2016 15:47:12 -0500
In-Reply-To: <1457277475-8913-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 06 March 2016, Christoph Hellwig wrote:
> Move a header from asm-generic to Linux because it isn't a generic arch
> implementation, and also implement the pci_dma_* helpers in common code.
> 

Nice cleanup!

Should I take these through the asm-generic tree?

	Arnd
