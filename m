From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Date: Wed, 8 Apr 2020 14:21:04 +0200
Message-ID: <20200408122104.GZ20713@hirez.programming.kicks-ass.net>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-18-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-18-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org, Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>, Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org, Sakari Ailus <sakari.ailus@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 08, 2020 at 01:59:15PM +0200, Christoph Hellwig wrote:
> This is always GFP_KERNEL - for long term mappings with other properties
> vmap should be used.

 PAGE_KERNEL != GFP_KERNEL :-)

> -	return vm_map_ram(mock->pages, mock->npages, 0, PAGE_KERNEL);
> +	return vm_map_ram(mock->pages, mock->npages, 0);
