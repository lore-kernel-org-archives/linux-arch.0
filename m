Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC4286881;
	Thu, 22 Jan 2026 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045014; cv=none; b=PzrDZAc6gLA6Jjs09iAh6Tl3Aozu0LPWZ4GzxM8lfWinaLGtDvu0deTqh++LdMYWjuoabyIKDY2diQKK6ydXJp+LrqdfPN6xJDlWeN9cdri8dTNQL6k6OmRDs8vcxSDGoxgrLiSe2G4nozN20C6IH8a4K0ShRS0U+vS1h+jvNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045014; c=relaxed/simple;
	bh=roQTG7BUnVXv2IGEQlqh5+zLrO9mjPF10u/iCVEG5JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3XDN1MbN0ii2asDNMK+IgW0FmX0MNfBVF1HyytcBfh7NNlFvtys7i2r5FeskCesAfeZtfW5rfRqO6Ppi5cEd/xsxoDixRwRIN8kBqP/9mUkhzQx41qdeSKZqKaswToytBt1bKqMReCnbOSCzRudRGLK6hDndBYZ3zmLH44vsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REmR6IZH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REmR6IZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769045012; x=1800581012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=roQTG7BUnVXv2IGEQlqh5+zLrO9mjPF10u/iCVEG5JM=;
  b=REmR6IZHhLebjv6CCCXLuF8L+I7S1AbzKZ7DOktNxlHXJ2PxX7Pml90F
   6Wb/Gp+luU48n5Kb0cYms9Q1vxup5KC3Z1D+i+kVigR34Qze66Ba7RVeS
   4q93KgJBpR+5D6Ljig/wAhfjBb2fMCOt5yu5/+PibrHasm/IgsyQ8tpEV
   vUsILCc/QrxxOPgX20LXXuytmeasuSclYZQa42KgoXVPxqwchujCiB5iC
   +RGGafoldTT7sclN0LuwTB8jn0BXD3PY8M/bF15qg9Ikf27F3ZRLF2Bqc
   4ublwIoH9cFTbrlqPdyXYxKhF/vCr57sRT0sozZrDxsCXn3ztUgTdHj4Z
   w==;
X-CSE-ConnectionGUID: YL9A+C5RS8q5jB7fns/eCQ==
X-CSE-MsgGUID: 8T4TYQz4Qq6SoXg1Z4icFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70448941"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70448941"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:23:29 -0800
X-CSE-ConnectionGUID: 509RMO9hSZeFWJL92bc8nQ==
X-CSE-MsgGUID: lnLLwhhmQUu/f10JpD2HZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="205842636"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Jan 2026 17:23:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vijPt-00000000SG5-4BMx;
	Thu, 22 Jan 2026 01:23:21 +0000
Date: Thu, 22 Jan 2026 09:23:16 +0800
From: kernel test robot <lkp@intel.com>
To: david.laight.linux@gmail.com, Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH next 12/14] bits: move the defitions of BIT() and
 BIT_ULL() back to linux/bits.h
Message-ID: <202601220951.7C4YG7hB-lkp@intel.com>
References: <20260121145731.3623-13-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-13-david.laight.linux@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260120]

url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/overflow-Reduce-expansion-of-__type_max/20260122-013456
base:   next-20260120
patch link:    https://lore.kernel.org/r/20260121145731.3623-13-david.laight.linux%40gmail.com
patch subject: [PATCH next 12/14] bits: move the defitions of BIT() and BIT_ULL() back to linux/bits.h
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260122/202601220951.7C4YG7hB-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220951.7C4YG7hB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601220951.7C4YG7hB-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/bounds.c:14:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/arm64/include/asm/barrier.h:14:
>> arch/arm64/include/asm/alternative-macros.h:18:20: warning: 'unsigned' is not defined, evaluates to 0 [-Wundef]
      18 | #if ARM64_NCAPS >= ARM64_CB_BIT
         |                    ^
   arch/arm64/include/asm/alternative-macros.h:16:22: note: expanded from macro 'ARM64_CB_BIT'
      16 | #define ARM64_CB_BIT    BIT(ARM64_CB_SHIFT)
         |                         ^
   include/linux/bits.h:94:18: note: expanded from macro 'BIT'
      94 | #define BIT(nr)         BIT_TYPE(unsigned long, nr)
         |                         ^
   include/linux/bits.h:88:4: note: expanded from macro 'BIT_TYPE'
      88 |         ((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
         |           ^
   In file included from kernel/bounds.c:14:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/arm64/include/asm/barrier.h:14:
>> arch/arm64/include/asm/alternative-macros.h:18:20: error: token is not a valid binary operator in a preprocessor subexpression
      18 | #if ARM64_NCAPS >= ARM64_CB_BIT
         |                    ^~~~~~~~~~~~
   arch/arm64/include/asm/alternative-macros.h:16:22: note: expanded from macro 'ARM64_CB_BIT'
      16 | #define ARM64_CB_BIT    BIT(ARM64_CB_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:94:18: note: expanded from macro 'BIT'
      94 | #define BIT(nr)         BIT_TYPE(unsigned long, nr)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:88:13: note: expanded from macro 'BIT_TYPE'
      88 |         ((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
         |           ~~~~~~~~ ^
   1 warning and 1 error generated.
   make[3]: *** [scripts/Makefile.build:182: kernel/bounds.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1330: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +18 arch/arm64/include/asm/alternative-macros.h

4c0bd995d73ed8 Mark Rutland 2022-09-12  17  
4c0bd995d73ed8 Mark Rutland 2022-09-12 @18  #if ARM64_NCAPS >= ARM64_CB_BIT
4c0bd995d73ed8 Mark Rutland 2022-09-12  19  #error "cpucaps have overflown ARM64_CB_BIT"
4c0bd995d73ed8 Mark Rutland 2022-09-12  20  #endif
7cda23da52ad79 Will Deacon  2020-06-30  21  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
