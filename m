From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 04/10] ARM: dma-mapping: remove offset parameter to
 prepare for generic dma_ops
Date: Tue, 10 Apr 2012 11:43:27 +0000
Message-ID: <201204101143.27915.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334055852-19500-5-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joerg Roedel <joro@8bytes.org>, Kyungmin Park <kyungmin.park@samsung.com>, Subash Patel <subashrp@gmail.com>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, KyongHo Cho <pullip.cho@samsung.com>, Chunsang Jeong <chunsang.jeong@linaro.org>, linux-arm-kernel@lists.infradead.org, Hiroshi Doyu <hdoyu@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch removes the need for offset parameter in dma bounce
> functions. This is required to let dma-mapping framework on ARM
> architecture use common, generic dma-mapping helpers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

This one worries me a little. I always thought that the range sync 
functions were specifically needed for the dmabounce code. At the
very least, I would expect the changeset comment to have an explanation
of why this was initially done this way and why it's now safe to do
do it otherwise.

	Arnd
