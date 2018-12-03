From: Christoph Hellwig <hch@lst.de>
Subject: Re: remove the ->mapping_error method from dma_map_ops V3
Date: Mon, 3 Dec 2018 18:27:03 +0100
Message-ID: <20181203172703.GA8240@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Does anyone but Linus and Russell have comments on this series?

I'd like to pull it in fairly quickly as I have a fair amount of
work on top of it that I'd like to get into 4.21 as well.
