From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 07/19] csky: MMU and page table management
Date: Tue, 3 Jul 2018 10:53:50 +0800
Message-ID: <20180703025348.GA32371@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <d07f919cb41ebb500c2e6f6defa6ea5760c22dc5.1530465326.git.ren_guo@c-sky.com>
 <20180702132915.GA6578@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702132915.GA6578@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 02, 2018 at 06:29:15AM -0700, Christoph Hellwig wrote:
> This commit is missing an explanation.
 The patch is for abiv1 & abiv2 CPU series' MMU support.
  - abiv1 CPU (CK610) is VIPT cache and it doesn't support highmem.
  - abiv2 CPUs are all PIPT cache and they could support highmem.
 We seperate abiv1 and abiv2 into two direcotries for coding convention. 

> For the dma-mapping code please use the generic kernel/dma/noncoherent.c
> code instead of duplicating it.
 Thx for the tips and I think you mean the lib/dma-noncoherent.c in the
 lastest kernel source and not in linux-4.16.2.

 I'll rebase on the newest RC version of linux in next version patch and
 reuse the code in lib/dma-noncoherent.c.

 Current csky_dma_alloc implementation is not good, it use 512MB uncached
 area to mirror the Normal cachable-512MB area. In next version patch,
 we will increase the max-Normal memory zone to (1GB + 768MB).
 In csky_dma_alloc we will seperate the atomic_dma and non-atomic_dma
 and reserve the area in fixmap area.

 Here is my memory layout plan in next version patch:
   Fixmap	: 0xffc02000 – 0xfffff000       (4 MB - 12KB) kmap_atomic, dma_atomic ...
   Pkmap	: 0xff800000 – 0xffc00000	(4 MB)        PTR_PER_PTE = 1024
   Vmalloc	: 0xf0200000 – 0xff000000       (238 MB)      max: 238MB + 256MB + 1GB
   Lowmem	: 0x80000000 – 0xf0000000	(1G + 768 MB)

 Guo Ren
