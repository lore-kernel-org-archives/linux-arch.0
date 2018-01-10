From: Christoph Hellwig <hch@lst.de>
Subject: consolidate swiotlb dma_map implementations
Date: Wed, 10 Jan 2018 09:09:10 +0100
Message-ID: <20180110080932.14157-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

A lot of architectures have essentially identical dma_map_ops
implementations to use swiotlb.  This series adds new generic
swiotlb_alloc/free helpers that take the attrs argument exposed
in dma_map_ops, and which do an enhanced direct allocation
modelled after x86 and reused from the dma-direct code, and
then switches most architectures over to it.  The only exceptions
are mips, which requires additional cache flushing which will
need a new abstraction, and x86 itself which will be handled in
a later series with other x86 dma mapping changes.

To support the generic code a few architectures that currently
use ZONE_DMA/GFP_DMA for <= 32-bit allocations are switched to
implement ZONE_DMA32 instead.

This series is based on the previously sent series to consolidate
the direct dma mapping implementation.  A git tree with this
series as well as the prerequisites is available here:

   git://git.infradead.org/users/hch/misc.git swiotlb

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb
