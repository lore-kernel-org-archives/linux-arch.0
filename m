From: Christoph Hellwig <hch@lst.de>
Subject: Re: semantics of dma_map_single()
Date: Mon, 17 Jul 2017 08:42:20 +0200
Message-ID: <20170717064220.GA15807@lst.de>
References: <dc128260-6641-828a-3bb6-c2f0b4f09f78@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <dc128260-6641-828a-3bb6-c2f0b4f09f78@synopsys.com>
Sender: owner-linux-mm@kvack.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>, bart.vanassche@sandisk.com, Alexander Duyck <alexander.h.duyck@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

I would expect that it would support any contiguous range in
the kernel mapping (e.g. no vmalloc and friends).  But it's not
documented anywhere, and if no in kernel users makes use of that
fact at the moment it might be better to document a page size
limitation and add asserts to enforce it.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
