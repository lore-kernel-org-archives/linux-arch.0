Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A063358DA;
	Thu,  5 Feb 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330403; cv=none; b=QNoZ04m0xgxMlEHv8bWkzmei//iu+qeLFt1eQKRXoLDc++rg8aOX+1ng9QyHnNuvIJRoVxrzwTvzrDhFXcnMNBquho2CPdjD8Byg2Orn2YDtuBoz1i8xX6Xdc2pmDexiH1Trr69e6q9RNxDwoq5YWizOOra84bHJkVMD/AscNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330403; c=relaxed/simple;
	bh=KfhvFJCEiYU8ibu2onwLPmE5nmIIqNX6E5IYpPaWj5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueO8hjTxwQ31+PsdiCokmvwnwHS9BMtOMZwyCErNUxj/hGuTnECq16xM4wtruEYr5g9oFQbYnZj9UhdkLoongbdJjk1G+w2CqeAkZNUmpbA8UzZ88r36xkPCFiVgivvAfHNFQ+5i81iGcmLsxvOiQ+OZTlMAubukJbjCf8itWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlZcw1fe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlZcw1fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770330403; x=1801866403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KfhvFJCEiYU8ibu2onwLPmE5nmIIqNX6E5IYpPaWj5g=;
  b=TlZcw1feW8I60XSkq54DEG3w/VQNbntwccTyCJGb4SXLyEwoDWk/7ie0
   J8KL2rem0RD9PhGbWs16KIbm99uL52P1IGEDmXi8ACdR8vJLnuQdl/UDu
   8aoB6pMlZb9gHdBYV6IsqA1htEoxF+XoJ7zOQ+F+lD+GaPLBq5fbAQofs
   GOEMDZ1TAXlCy1gcG1xnvj69Sk2APs3tkuaQ8one7B/QD4+OvP7k4eQaq
   bCm+vGOczODJFJn274BrtQGjO50073eDK85jVW+O+NBccjT1PBqicG4iB
   DRLhvFg1VeGf/FoCtatw91tvZQxm76eLx4eBjOUsMVUYEIP36hWdjSJPX
   A==;
X-CSE-ConnectionGUID: 8aX3ohQPSSmmU6NTzc4GUw==
X-CSE-MsgGUID: 1LbQrPpTTb+Zw+M5k5NM8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="74141580"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="74141580"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 14:26:42 -0800
X-CSE-ConnectionGUID: A1OHIjxpQpGQFlpkLKgWGg==
X-CSE-MsgGUID: wuZAjYwCQ0WQDvfh69HTBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="214855220"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 14:26:35 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo7o0-00000000kG0-0Owz;
	Thu, 05 Feb 2026 22:26:32 +0000
Date: Fri, 6 Feb 2026 06:26:28 +0800
From: kernel test robot <lkp@intel.com>
To: Hui Min Mina Chou <minachou@andestech.com>, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	arnd@arndb.de, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tim609@andestech.com,
	ben717@andestech.com, minachou@andestech.com, az70021@gmail.com,
	Randolph <randolph@andestech.com>
Subject: Re: [PATCH] riscv: Fix __kernel_off_t to 64 Bits in RV32
Message-ID: <202602060639.0bNNrmAg-lkp@intel.com>
References: <20260205055800.586458-1-minachou@andestech.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205055800.586458-1-minachou@andestech.com>

Hi Hui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on soc/for-next linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hui-Min-Mina-Chou/riscv-Fix-__kernel_off_t-to-64-Bits-in-RV32/20260205-140215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20260205055800.586458-1-minachou%40andestech.com
patch subject: [PATCH] riscv: Fix __kernel_off_t to 64 Bits in RV32
config: riscv-randconfig-r052-20260206 (https://download.01.org/0day-ci/archive/20260206/202602060639.0bNNrmAg-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602060639.0bNNrmAg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602060639.0bNNrmAg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/dw-edma/dw-edma-pcie.c:305:22: warning: format specifies type 'unsigned long' but the argument has type 'off_t' (aka 'long long') [-Wformat]
     304 |         pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
         |                                                  ~~~~~
         |                                                  %.8llx
     305 |                 vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
         |                                    ^~~~~~~~~~~~~~~~~
   include/linux/pci.h:2829:65: note: expanded from macro 'pci_dbg'
    2829 | #define pci_dbg(pdev, fmt, arg...)      dev_dbg(&(pdev)->dev, fmt, ##arg)
         |                                                               ~~~    ^~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:285:19: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/dma/dw-edma/dw-edma-pcie.c:312:4: warning: format specifies type 'unsigned long' but the argument has type 'off_t' (aka 'long long') [-Wformat]
     310 |                 pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
         |                                                                      ~~~~~
         |                                                                      %.8llx
     311 |                         i, vsec_data->ll_wr[i].bar,
     312 |                         vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2829:65: note: expanded from macro 'pci_dbg'
    2829 | #define pci_dbg(pdev, fmt, arg...)      dev_dbg(&(pdev)->dev, fmt, ##arg)
         |                                                               ~~~    ^~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:285:19: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/dma/dw-edma/dw-edma-pcie.c:317:4: warning: format specifies type 'unsigned long' but the argument has type 'off_t' (aka 'long long') [-Wformat]
     315 |                 pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
         |                                                                   ~~~~~
         |                                                                   %.8llx
     316 |                         i, vsec_data->dt_wr[i].bar,
     317 |                         vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2829:65: note: expanded from macro 'pci_dbg'
    2829 | #define pci_dbg(pdev, fmt, arg...)      dev_dbg(&(pdev)->dev, fmt, ##arg)
         |                                                               ~~~    ^~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:285:19: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/dma/dw-edma/dw-edma-pcie.c:324:4: warning: format specifies type 'unsigned long' but the argument has type 'off_t' (aka 'long long') [-Wformat]
     322 |                 pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
         |                                                                     ~~~~~
         |                                                                     %.8llx
     323 |                         i, vsec_data->ll_rd[i].bar,
     324 |                         vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2829:65: note: expanded from macro 'pci_dbg'
    2829 | #define pci_dbg(pdev, fmt, arg...)      dev_dbg(&(pdev)->dev, fmt, ##arg)
         |                                                               ~~~    ^~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:285:19: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/dma/dw-edma/dw-edma-pcie.c:329:4: warning: format specifies type 'unsigned long' but the argument has type 'off_t' (aka 'long long') [-Wformat]
     327 |                 pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",


vim +305 drivers/dma/dw-edma/dw-edma-pcie.c

1aef6ffe999eec Gustavo Pimentel   2021-02-18  159  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  160  static int dw_edma_pcie_probe(struct pci_dev *pdev,
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  161  			      const struct pci_device_id *pid)
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  162  {
1aef6ffe999eec Gustavo Pimentel   2021-02-18  163  	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
3df63fa8f2afd0 Abinash Singh      2025-07-05  164  	struct dw_edma_pcie_data *vsec_data __free(kfree) = NULL;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  165  	struct device *dev = &pdev->dev;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  166  	struct dw_edma_chip *chip;
e0c1d53891c43a Gustavo Pimentel   2021-02-18  167  	int err, nr_irqs;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  168  	int i, mask;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  169  
3df63fa8f2afd0 Abinash Singh      2025-07-05  170  	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
3df63fa8f2afd0 Abinash Singh      2025-07-05  171  	if (!vsec_data)
3df63fa8f2afd0 Abinash Singh      2025-07-05  172  		return -ENOMEM;
3df63fa8f2afd0 Abinash Singh      2025-07-05  173  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  174  	/* Enable PCI device */
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  175  	err = pcim_enable_device(pdev);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  176  	if (err) {
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  177  		pci_err(pdev, "enabling device failed\n");
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  178  		return err;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  179  	}
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  180  
3df63fa8f2afd0 Abinash Singh      2025-07-05  181  	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
1aef6ffe999eec Gustavo Pimentel   2021-02-18  182  
1aef6ffe999eec Gustavo Pimentel   2021-02-18  183  	/*
1aef6ffe999eec Gustavo Pimentel   2021-02-18  184  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
1aef6ffe999eec Gustavo Pimentel   2021-02-18  185  	 * for the DMA, if one exists, then reconfigures it.
1aef6ffe999eec Gustavo Pimentel   2021-02-18  186  	 */
3df63fa8f2afd0 Abinash Singh      2025-07-05  187  	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
1aef6ffe999eec Gustavo Pimentel   2021-02-18  188  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  189  	/* Mapping PCI BAR regions */
3df63fa8f2afd0 Abinash Singh      2025-07-05  190  	mask = BIT(vsec_data->rg.bar);
3df63fa8f2afd0 Abinash Singh      2025-07-05  191  	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
3df63fa8f2afd0 Abinash Singh      2025-07-05  192  		mask |= BIT(vsec_data->ll_wr[i].bar);
3df63fa8f2afd0 Abinash Singh      2025-07-05  193  		mask |= BIT(vsec_data->dt_wr[i].bar);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  194  	}
3df63fa8f2afd0 Abinash Singh      2025-07-05  195  	for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
3df63fa8f2afd0 Abinash Singh      2025-07-05  196  		mask |= BIT(vsec_data->ll_rd[i].bar);
3df63fa8f2afd0 Abinash Singh      2025-07-05  197  		mask |= BIT(vsec_data->dt_rd[i].bar);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  198  	}
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  199  	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  200  	if (err) {
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  201  		pci_err(pdev, "eDMA BAR I/O remapping failed\n");
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  202  		return err;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  203  	}
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  204  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  205  	pci_set_master(pdev);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  206  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  207  	/* DMA configuration */
ecb8c88bd31cce Wang Qing          2021-10-07  208  	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  209  	if (err) {
1ffc6f359f7ab1 Christophe JAILLET 2021-11-09  210  		pci_err(pdev, "DMA mask 64 set failed\n");
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  211  		return err;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  212  	}
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  213  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  214  	/* Data structure allocation */
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  215  	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  216  	if (!chip)
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  217  		return -ENOMEM;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  218  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  219  	/* IRQs allocation */
3df63fa8f2afd0 Abinash Singh      2025-07-05  220  	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  221  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  222  	if (nr_irqs < 1) {
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  223  		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  224  			nr_irqs);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  225  		return -EPERM;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  226  	}
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  227  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  228  	/* Data structure initialization */
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  229  	chip->dev = dev;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  230  
3df63fa8f2afd0 Abinash Singh      2025-07-05  231  	chip->mf = vsec_data->mf;
203184571388a9 Frank Li           2022-05-24  232  	chip->nr_irqs = nr_irqs;
487517557f9780 Cai Huoqing        2023-05-20  233  	chip->ops = &dw_edma_pcie_plat_ops;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  234  
3df63fa8f2afd0 Abinash Singh      2025-07-05  235  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
3df63fa8f2afd0 Abinash Singh      2025-07-05  236  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  237  
3df63fa8f2afd0 Abinash Singh      2025-07-05  238  	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
e51b3048116a6e Frank Li           2022-05-24  239  	if (!chip->reg_base)
203184571388a9 Frank Li           2022-05-24  240  		return -ENOMEM;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  241  
6951ee96c649f6 Frank Li           2022-05-24  242  	for (i = 0; i < chip->ll_wr_cnt; i++) {
203184571388a9 Frank Li           2022-05-24  243  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
203184571388a9 Frank Li           2022-05-24  244  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
3df63fa8f2afd0 Abinash Singh      2025-07-05  245  		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
3df63fa8f2afd0 Abinash Singh      2025-07-05  246  		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  247  
16f8a08643b6d6 Serge Semin        2023-01-13  248  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
16f8a08643b6d6 Serge Semin        2023-01-13  249  		if (!ll_region->vaddr.io)
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  250  			return -ENOMEM;
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  251  
16f8a08643b6d6 Serge Semin        2023-01-13  252  		ll_region->vaddr.io += ll_block->off;
002bbaa2f60e07 Serge Semin        2023-01-13  253  		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  254  		ll_region->paddr += ll_block->off;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  255  		ll_region->sz = ll_block->sz;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  256  
16f8a08643b6d6 Serge Semin        2023-01-13  257  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
16f8a08643b6d6 Serge Semin        2023-01-13  258  		if (!dt_region->vaddr.io)
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  259  			return -ENOMEM;
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  260  
16f8a08643b6d6 Serge Semin        2023-01-13  261  		dt_region->vaddr.io += dt_block->off;
002bbaa2f60e07 Serge Semin        2023-01-13  262  		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  263  		dt_region->paddr += dt_block->off;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  264  		dt_region->sz = dt_block->sz;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  265  	}
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  266  
6951ee96c649f6 Frank Li           2022-05-24  267  	for (i = 0; i < chip->ll_rd_cnt; i++) {
203184571388a9 Frank Li           2022-05-24  268  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
203184571388a9 Frank Li           2022-05-24  269  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
3df63fa8f2afd0 Abinash Singh      2025-07-05  270  		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
3df63fa8f2afd0 Abinash Singh      2025-07-05  271  		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  272  
16f8a08643b6d6 Serge Semin        2023-01-13  273  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
16f8a08643b6d6 Serge Semin        2023-01-13  274  		if (!ll_region->vaddr.io)
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  275  			return -ENOMEM;
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  276  
16f8a08643b6d6 Serge Semin        2023-01-13  277  		ll_region->vaddr.io += ll_block->off;
002bbaa2f60e07 Serge Semin        2023-01-13  278  		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  279  		ll_region->paddr += ll_block->off;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  280  		ll_region->sz = ll_block->sz;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  281  
16f8a08643b6d6 Serge Semin        2023-01-13  282  		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
16f8a08643b6d6 Serge Semin        2023-01-13  283  		if (!dt_region->vaddr.io)
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  284  			return -ENOMEM;
84b0aa2e0d91d7 Gustavo Pimentel   2021-02-18  285  
16f8a08643b6d6 Serge Semin        2023-01-13  286  		dt_region->vaddr.io += dt_block->off;
002bbaa2f60e07 Serge Semin        2023-01-13  287  		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  288  		dt_region->paddr += dt_block->off;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  289  		dt_region->sz = dt_block->sz;
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  290  	}
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  291  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  292  	/* Debug info */
203184571388a9 Frank Li           2022-05-24  293  	if (chip->mf == EDMA_MF_EDMA_LEGACY)
203184571388a9 Frank Li           2022-05-24  294  		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
203184571388a9 Frank Li           2022-05-24  295  	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
203184571388a9 Frank Li           2022-05-24  296  		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
203184571388a9 Frank Li           2022-05-24  297  	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
203184571388a9 Frank Li           2022-05-24  298  		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
d7130902abb40e Devendra K Verma   2025-05-13  299  	else if (chip->mf == EDMA_MF_HDMA_NATIVE)
d7130902abb40e Devendra K Verma   2025-05-13  300  		pci_dbg(pdev, "Version:\tHDMA Native (0x%x)\n", chip->mf);
e0c1d53891c43a Gustavo Pimentel   2021-02-18  301  	else
203184571388a9 Frank Li           2022-05-24  302  		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  303  
203184571388a9 Frank Li           2022-05-24  304  	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
3df63fa8f2afd0 Abinash Singh      2025-07-05 @305  		vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
e51b3048116a6e Frank Li           2022-05-24  306  		chip->reg_base);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  307  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  308  
6951ee96c649f6 Frank Li           2022-05-24  309  	for (i = 0; i < chip->ll_wr_cnt; i++) {
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  310  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
3df63fa8f2afd0 Abinash Singh      2025-07-05  311  			i, vsec_data->ll_wr[i].bar,
3df63fa8f2afd0 Abinash Singh      2025-07-05  312  			vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
16f8a08643b6d6 Serge Semin        2023-01-13  313  			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  314  
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  315  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
3df63fa8f2afd0 Abinash Singh      2025-07-05  316  			i, vsec_data->dt_wr[i].bar,
3df63fa8f2afd0 Abinash Singh      2025-07-05  317  			vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
16f8a08643b6d6 Serge Semin        2023-01-13  318  			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  319  	}
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  320  
6951ee96c649f6 Frank Li           2022-05-24  321  	for (i = 0; i < chip->ll_rd_cnt; i++) {
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  322  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
3df63fa8f2afd0 Abinash Singh      2025-07-05  323  			i, vsec_data->ll_rd[i].bar,
3df63fa8f2afd0 Abinash Singh      2025-07-05  324  			vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
16f8a08643b6d6 Serge Semin        2023-01-13  325  			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  326  
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  327  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
3df63fa8f2afd0 Abinash Singh      2025-07-05  328  			i, vsec_data->dt_rd[i].bar,
3df63fa8f2afd0 Abinash Singh      2025-07-05  329  			vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
16f8a08643b6d6 Serge Semin        2023-01-13  330  			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
31fb8c1ff962d9 Gustavo Pimentel   2021-02-18  331  	}
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  332  
203184571388a9 Frank Li           2022-05-24  333  	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  334  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  335  	/* Validating if PCI interrupts were enabled */
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  336  	if (!pci_dev_msi_enabled(pdev)) {
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  337  		pci_err(pdev, "enable interrupt failed\n");
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  338  		return -EPERM;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  339  	}
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  340  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  341  	/* Starting eDMA driver */
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  342  	err = dw_edma_probe(chip);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  343  	if (err) {
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  344  		pci_err(pdev, "eDMA probe failed\n");
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  345  		return err;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  346  	}
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  347  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  348  	/* Saving data structure reference */
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  349  	pci_set_drvdata(pdev, chip);
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  350  
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  351  	return 0;
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  352  }
41aaff2a2ac01c Gustavo Pimentel   2019-06-04  353  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
