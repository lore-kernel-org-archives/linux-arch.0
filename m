From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: decruft the vmalloc API
Date: Wed, 8 Apr 2020 14:25:01 +0200
Message-ID: <20200408122501.GA20713@hirez.programming.kicks-ass.net>
References: <20200408115926.1467567-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
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

On Wed, Apr 08, 2020 at 01:58:58PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Peter noticed that with some dumb luck you can toast the kernel address
> space with exported vmalloc symbols.
> 
> I used this as an opportunity to decruft the vmalloc.c API and make it
> much more systematic.  This also removes any chance to create vmalloc
> mappings outside the designated areas or using executable permissions
> from modules.  Besides that it removes more than 300 lines of code.
> 

Looks great, thanks for doing this!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
