From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 23/31] sh: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:42 +0200
Message-ID: <1439363150-8661-24-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
Sender: linux-parisc-owner@vger.kernel.org
To: torvalds@linux-foundation.org, axboe@kernel.dk
Cc: dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com, monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org, alex.williamson@redhat.com, grundler@parisc-linux.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make all cache invalidation conditional on sg_has_page().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/dma-nommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 5b0bfcd..3b64dc7 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -33,9 +33,8 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 	WARN_ON(nents == 0 || sg[0].length == 0);
 
 	for_each_sg(sg, s, nents, i) {
-		BUG_ON(!sg_page(s));
