From: Christoph Hellwig <hch@lst.de>
Subject: Re: fix various asm-generic abuses
Date: Tue, 6 Oct 2015 10:38:05 +0200
Message-ID: <20151006083805.GA28030@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de> <22516156.tfGZvl13aG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22516156.tfGZvl13aG@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 28, 2015 at 09:16:51PM +0200, Arnd Bergmann wrote:
> with asm-generic patches is to have changes go through the tree of
> whichever maintainer needs the changes for their own work with my
> Ack, but I guess in this case you don't actually have other patches
> depending on them, right?
> 
> If driver maintainers want to pick individual patches from this series,
> please add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> otherwise let me know if I should put them into my asm-generic git
> tree (which is currently empty, but part of linux-next).

Seems like none of them made it into 4.3-rc - was that intentional or an
oversight?
