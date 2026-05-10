Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F939FCAD;
	Sun, 10 May 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778425953; cv=none; b=OAQcLEARl2GtyGku+N6vG10KljLrvC7hvUDD9lA87YMjGddle6sGee7NsM7M95snm4Y2ladYRKb7U/wWAy/v5kkl35qNabJeC/PE3LpgDXiPYOZv61y0joxjIppRSxYbgHf4TI//foSPQ3tSBcfpngdOfmb/fEmRkw4U32GlyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778425953; c=relaxed/simple;
	bh=N+XZMSgicn8mI99CZ460axGdpor6zxJtBh7/Zgbh1yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBTtRuypVLWTgaZPCACyPGPUv7bQemO5IlDCXB6RpAf2N8wozAJ2NsgFjE7TBQiCHCYO1Yv7LZINnqeK0vXsA5mKXTfOKbGPuNlFSFWpfOEvdYUwCH9Fgb+Z3bNRE8klm+0KYsdULU0S5HT4CIzgrBXcI5JGFiZdG3HmSH8nMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+sv/KZY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+sv/KZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778425949; x=1809961949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N+XZMSgicn8mI99CZ460axGdpor6zxJtBh7/Zgbh1yk=;
  b=M+sv/KZYE9WP5dhv/F2+V5i7HNAUeEYQxbxg+8mpxs7R+IiEeWMvceCg
   YsYIaLymdBZh0PReive4CTK8sGEU7p6bYfEyk81NMlEVKIHiJKEMr6A6a
   6TsjLYDT9eNJuvLrkpjhkEg+U/fC2pTAg7BnIB7pqC8QMf7Thi5yVuqCx
   48gX8jDMhuOGUkQ0NdyCQVwSwHfw/axMQvkEgmSqKdSMt8d+y6XGWOlE7
   CrIn4SEG58c9EKy/lNw4K4q6AoXm82kDJC+F4LJFjzpHebHhNYuxuo4eQ
   Abjy4sJqbQjuTHPaJ14Hd7ZQBE6KKG12/JPv3HVTpJh1fyhimXJF2NzWD
   g==;
X-CSE-ConnectionGUID: UMRuuzcDQGOFx6zUHnUblA==
X-CSE-MsgGUID: FPbtmJDgRGSaWDQaaRTDVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96753731"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="96753731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 08:12:28 -0700
X-CSE-ConnectionGUID: AM6aWGUATqKZXBH+JQ1pSg==
X-CSE-MsgGUID: KfSRvOSTTuKI0VJjlUESPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237175762"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 May 2026 08:12:27 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wM5pQ-000000002LB-084H;
	Sun, 10 May 2026 15:12:24 +0000
Date: Sun, 10 May 2026 23:12:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mm: make zeropage read-only
Message-ID: <202605102300.PHd18T7k-lkp@intel.com>
References: <20260508-ro-zeropage-v1-1-9808abc20b49@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-ro-zeropage-v1-1-9808abc20b49@google.com>

Hi Jann,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 917719c412c48687d4a176965d1fa35320ec457c]

url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/mm-make-zeropage-read-only/20260510-200814
base:   917719c412c48687d4a176965d1fa35320ec457c
patch link:    https://lore.kernel.org/r/20260508-ro-zeropage-v1-1-9808abc20b49%40google.com
patch subject: [PATCH] mm: make zeropage read-only
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20260510/202605102300.PHd18T7k-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605102300.PHd18T7k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605102300.PHd18T7k-lkp@intel.com/

All warnings (new ones prefixed by >>):

   /tmp/ccjZQT3J.s: Assembler messages:
>> /tmp/ccjZQT3J.s:3163: Warning: setting incorrect section attributes for .rodata..page_aligned

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
