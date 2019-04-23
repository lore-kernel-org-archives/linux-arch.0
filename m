Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22943 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbfDWAcN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Apr 2019 20:32:13 -0400
Date: Tue, 23 Apr 2019 08:31:15 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <201904230815.Qe1Manfd%lkp@intel.com>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <1555947870-23014-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: kbuild-all@01.org, ren_guo@c-sky.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tech-privileged@lists.riscv.org, Andrew Waterman <andrew@sifive.com>, Anup Patel <anup.patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Greentime Hu <green.hu@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@sifive.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, Vincent Chen <vincentc@andestech.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>
Message-ID: <20190423003115.dxxylPChDTyDIsBT3gtJABRrB5g0iG9lcjRKmlJt37Q@z>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.1-rc6 next-20190418]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/riscv-Support-non-coherency-memory-model/20190423-075013
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


All errors (new ones prefixed by >>):

   arch/riscv/mm/dma-mapping.c: In function 'arch_dma_prep_coherent':
>> arch/riscv/mm/dma-mapping.c:15:2: error: implicit declaration of function 'sbi_fence_dma' [-Werror=implicit-function-declaration]
     sbi_fence_dma(page_to_phys(page), size, DMA_BIDIRECTIONAL);
     ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/sbi_fence_dma +15 arch/riscv/mm/dma-mapping.c

    10	
    11	void arch_dma_prep_coherent(struct page *page, size_t size)
    12	{
    13		memset(page_address(page), 0, size);
    14	
  > 15		sbi_fence_dma(page_to_phys(page), size, DMA_BIDIRECTIONAL);
    16	}
    17	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wIM4mGTHq75zUUXx/w/k6e36XjwAAA==

--ZGiS0Q5IWpPtfppv--
