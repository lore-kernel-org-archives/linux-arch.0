From: Christoph Hellwig <hch@lst.de>
Subject: Re: two small PCI header cleanups
Date: Sun, 6 Mar 2016 21:52:13 +0100
Message-ID: <20160306205213.GA30838@lst.de>
References: <1457277475-8913-1-git-send-email-hch@lst.de> <201603062147.03753.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201603062147.03753.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 06, 2016 at 09:47:03PM +0100, Arnd Bergmann wrote:
> > Move a header from asm-generic to Linux because it isn't a generic arch
> > implementation, and also implement the pci_dma_* helpers in common code.
> > 
> 
> Nice cleanup!
> 
> Should I take these through the asm-generic tree?

I expected Bjoern to takes this throught the PCI tree, but as far
as I'm concerned your tree is fine as well.
