Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cy5C+Hth"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9EAF
	for <linux-arch@vger.kernel.org>; Tue,  5 Dec 2023 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701787765; x=1733323765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vAAQ8wa0EAG2/mzy0oHSIHGOs2O1vadv0yCm0YHbt1w=;
  b=cy5C+HthHTxRjnvhVx6kcXJ7mikAHLN6vYDJUzvq6GXSkUG94pSm9fTl
   d2BbXkDBIvBMOGUbcaFIJc0sKojWsWW1WFTb+S7Jx/UrmCrw9OrEBebqt
   4mmdfUcR7LEiesiisIm9eNUY0LT5H5B1Q2qCBoGF2brUvFPyjFpuWhaVy
   0/DBWJqlcYs/aFL06ao7uusq7Ig4ZO585ddOs9wZsohsLgDC2+oczRCvK
   ihIew/4ZQoxH3akHTrMvfyQTPRQkZbkKCiNXRP71/QVswyzLT/4AUvspK
   gyPWWUgWm2L5387bIdbHVtqcWrL8KGKl0WSO1ersspdr6T6jeCbFbkWJl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="966782"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="966782"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="770942104"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="770942104"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2023 06:49:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAWjg-0009CU-2g;
	Tue, 05 Dec 2023 14:49:20 +0000
Date: Tue, 5 Dec 2023 22:49:06 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:mips-prototypes 12/20] ld.lld: error: undefined
 symbol: octeon_cache_init
Message-ID: <202312052241.PBlQLxHZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git mips-prototypes
head:   3ba13f3f1f92410943161b5c13347847e79623e1
commit: 5e98240758cb00fac9636b0e38aebd383ef74694 [12/20] mips: move cache declarations into header
config: mips-rs90_defconfig (https://download.01.org/0day-ci/archive/20231205/202312052241.PBlQLxHZ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312052241.PBlQLxHZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052241.PBlQLxHZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: octeon_cache_init
   >>> referenced by cache.c
   >>>               arch/mips/mm/cache.o:(cpu_cache_init) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
