Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597662;
	b=SU17RVuKDNAcQQrxTHbqAdyV9lngkIyNKpClK28sEK7Uq7S+Akz0WDU1H9QHSeFOxAP2
	 quiFCalaS030lYs4mHfR7uvRMtr3v2KzHe9VXlpjyNR201GhktoS9UWmi4LFLEoAacU98
	 J4/zcwaD41NJCSgSs4FlCrmw+/kBsgvmUWencbRKrRS/KpCeiesTchRoTo84G5Pg+CE+a
	 WNkHHGzvGoZIIoAhhTRhBX0jm/ZWWdqJrb2/QIr7dQ9qKkmM7dPYzpfYgOa3A0wb52YxB
	 c0/7DxtCBBDpLpP7UW+BdZ9GMLF0Gj13ytyxnjABf90aR9yhfDtSqEdOJfkivbM7EVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597662;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=aAgF90bs3C3KZ91sc3AsdqOEIkXcwBh6w8fCm7p+R/0=;
	b=TYa8kpoOkO8FKjw8/VR/aoy17jy02C5BqbUMSV9KMXpVg+U7Qg6u6E/8ipc9aXvZY35e
	 BCNGuWTYbA7bSWLb2yq/7oym6Hht6SShsko2nxcUCCJyK5wytNAV1+FmrkMcm9TSdLhYl
	 QQEBNIkXvUFYmpnSBXpx44mjluX4aAIKhzJGKY0J6PVnxglvMtaYQZlnFhWJXTeQL6W+E
	 oRtAmmCZmkxT2N+N05p7nNKooHfifoWZFSfeUmQpEbJ2kyZdWBaW4afEVZ9s+n8wijfTn
	 xfafZfIqvrXGXj8dHw+AUc4Q1EbABX+ZrPTOSlPLljq5HASim7DeC/des3U+Z4r4Unw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ua3VN+n7;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55EF606A31E
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 09:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55EF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ua3VN+n7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795597662; x=1827133662;
  h=date:from:to:cc:subject:message-id;
  bh=tZK87X632UKECb5a2vJvsxp0NroQc8PrWXmjBGCzqcg=;
  b=Ua3VN+n7O5rTBPS4Cp4N96ErvCmpsfNWAm3ytHQ7sSfcC8wOETHz9iZO
   cfQGXdzMiz0pRGJP5ZecEFqJdPXvT1rMomgpB5JmKQgfyXSPmhUVgf1sz
   p1J0eOA8NpqcImF/T2Y5I/2bfTRM7ZyV/677nnXnmeNVD+51xTyvTlLbz
   TCrhbYQmDD4CMTsokxUztehvwyzohjtmuCvPRWLalNXYewqLxpAbfYBea
   V+XoT2ap8d4RVofQfL7vuFB1/jVnJEQuOqVsfXtL1r2aqXjwVpfbPzVv0
   V96onoXlkpzuu4lz6NabGmMi/cpQfhlfU6kD3l54VnTEwOiTgjLm1Gp+e
   g==;
X-CSE-ConnectionGUID: yl/04z29RVOAiBr29PZY7Q==
X-CSE-MsgGUID: 0+pkNlWWSv26GAI1wC/EUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4466879"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4466879"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:07:40 -0800
X-CSE-ConnectionGUID: Qy0c47dLS8CJ1Li9+yuFhQ==
X-CSE-MsgGUID: EBETEbSkS4+nBhK0Lx9RIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11674929"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Nov 2026 01:07:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW8yW-00000001RCM-2yjP;
	Wed, 25 Nov 2026 09:07:36 +0000
Date: Wed, 25 Nov 2026 17:07:21 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 6a65227c12901568485243bafda0b8772ff97903
Message-ID: <20261125170721.rMGYbU9V-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 6a65227c12901568485243bafda0b8772ff97903  openrisc: stop using libgcc

elapsed time: 956m

configs tested: 444
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261123    gcc-8.5.0
alpha                 randconfig-2001-20261123    gcc-8.5.0
alpha                 randconfig-2200-20261123    gcc-12.5.0 smatch
alpha                randconfig-r2101-20261123    gcc-8.5.0  cocci
alpha                randconfig-r2106-20261123    clang-24   cocci
alpha                randconfig-r2111-20261123    gcc-8.5.0  cocci
alpha                randconfig-r2301-20261123    gcc-11.5.0 sparse
alpha                randconfig-r2303-20261123    gcc-14.4.0 sparse
alpha                randconfig-r2305-20261123    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                          haps_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261125    gcc-8.5.0
arc                   randconfig-1001-20261125    gcc-8.5.0
arc                   randconfig-2000-20261123    gcc-12.5.0
arc                   randconfig-2001-20261123    gcc-12.5.0
arc                   randconfig-2002-20261123    gcc-12.5.0
arc                   randconfig-2003-20261123    gcc-12.5.0
arc                   randconfig-2004-20261123    gcc-12.5.0
arc                   randconfig-2005-20261123    gcc-12.5.0
arc                   randconfig-2200-20261123    gcc-12.5.0 smatch
arc                  randconfig-r2102-20261123    gcc-8.5.0  cocci
arc                  randconfig-r2104-20261123    gcc-8.5.0  cocci
arc                  randconfig-r2108-20261123    clang-20   cocci
arc                  randconfig-r2109-20261123    gcc-15.3.0 cocci
arc                  randconfig-r2109-20261123    gcc-8.5.0  cocci
arc                  randconfig-r2300-20261123    gcc-11.5.0 sparse
arc                  randconfig-r2308-20261123    gcc-13.5.0 sparse
arc                  randconfig-r2310-20261123    gcc-13.5.0 sparse
arc                  randconfig-r2310-20261123    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.2.0
arm                          axm55xx_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    clang-17
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc18xx_defconfig    clang-17
arm                          lpc32xx_defconfig    clang-17
arm                           moxart_defconfig    clang-17
arm                           moxart_defconfig    clang-24
arm                          mv78xx0_defconfig    clang-17
arm                          mv78xx0_defconfig    gcc-16.2.0
arm                           pxa168_defconfig    clang-17
arm                           pxa168_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261125    gcc-8.5.0
arm                   randconfig-1001-20261125    gcc-8.5.0
arm                   randconfig-1002-20261125    gcc-8.5.0
arm                   randconfig-1003-20261125    gcc-8.5.0
arm                   randconfig-2000-20261123    gcc-16.2.0
arm                   randconfig-2000-20261123    gcc-8.5.0
arm                   randconfig-2001-20261123    gcc-8.5.0
arm                   randconfig-2002-20261123    clang-20
arm                   randconfig-2002-20261123    gcc-8.5.0
arm                   randconfig-2200-20261123    gcc-8.5.0  smatch
arm                  randconfig-r2100-20261123    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261123    clang-20   cocci
arm                  randconfig-r2106-20261123    gcc-8.5.0  cocci
arm                            sama7_defconfig    clang-17
arm                          socfpga_defconfig    clang-17
arm                           sp7021_defconfig    clang-24
arm                           sp7021_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261125    clang-24
arm64                 randconfig-1001-20261125    clang-24
arm64                 randconfig-1002-20261125    clang-24
arm64                 randconfig-1003-20261125    clang-24
arm64                 randconfig-2000-20261123    clang-24
arm64                 randconfig-2000-20261123    gcc-8.5.0
arm64                 randconfig-2001-20261123    gcc-8.5.0
arm64                 randconfig-2002-20261123    clang-24
arm64                 randconfig-2002-20261123    gcc-8.5.0
arm64                 randconfig-2200-20261123    clang-17   smatch
arm64                randconfig-r2103-20261123    gcc-8.5.0  cocci
arm64                randconfig-r2300-20261123    clang-24   sparse
arm64                randconfig-r2301-20261123    gcc-14     sparse
arm64                randconfig-r2307-20261123    clang-24   sparse
arm64                randconfig-r2309-20261123    gcc-13.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261125    clang-24
csky                  randconfig-1001-20261125    clang-24
csky                  randconfig-2000-20261123    gcc-12.5.0
csky                  randconfig-2001-20261123    gcc-12.5.0
csky                  randconfig-2200-20261123    gcc-16.2.0 smatch
csky                 randconfig-r2107-20261123    gcc-8.5.0  cocci
csky                 randconfig-r2108-20261123    gcc-16.2.0 cocci
csky                 randconfig-r2303-20261123    gcc-12     sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261125    gcc-11.5.0
hexagon               randconfig-1001-20261125    gcc-11.5.0
hexagon               randconfig-2000-20261123    gcc-12.5.0
hexagon               randconfig-2001-20261123    gcc-12.5.0
hexagon               randconfig-2200-20261123    clang-24   smatch
hexagon              randconfig-r2105-20261123    gcc-8.5.0  cocci
hexagon              randconfig-r2107-20261123    clang-20   cocci
hexagon              randconfig-r2300-20261123    gcc-14.4.0 sparse
hexagon              randconfig-r2301-20261123    clang-24   sparse
hexagon              randconfig-r2309-20261123    gcc-12.5.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261125    clang-22
i386        buildonly-randconfig-1001-20261125    clang-22
i386        buildonly-randconfig-1002-20261125    clang-22
i386        buildonly-randconfig-1003-20261125    clang-22
i386        buildonly-randconfig-1004-20261125    clang-22
i386        buildonly-randconfig-1005-20261125    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261125    clang-22
i386                  randconfig-1001-20261125    clang-22
i386                  randconfig-1002-20261125    clang-22
i386                  randconfig-1003-20261125    clang-22
i386                  randconfig-1004-20261125    clang-22
i386                  randconfig-1005-20261125    clang-22
i386                  randconfig-1006-20261125    clang-22
i386                  randconfig-2000-20261123    gcc-14
i386                  randconfig-2001-20261123    gcc-14
i386                  randconfig-2002-20261123    gcc-14
i386                  randconfig-2003-20261123    gcc-14
i386                  randconfig-2004-20261123    gcc-14
i386                  randconfig-2005-20261123    gcc-14
i386                  randconfig-2100-20261123    clang-22   cocci
i386                  randconfig-2101-20261123    clang-22   cocci
i386                  randconfig-2102-20261123    clang-22   cocci
i386                  randconfig-2103-20261123    clang-22   cocci
i386                  randconfig-2104-20261123    clang-22   cocci
i386                  randconfig-2105-20261123    clang-22   cocci
i386                  randconfig-2200-20261123    gcc-14     smatch
i386                  randconfig-2300-20261123    gcc-14     sparse
i386                  randconfig-2301-20261123    gcc-14     sparse
i386                  randconfig-2302-20261123    gcc-14     sparse
i386                 randconfig-r2100-20261123    gcc-14     cocci
i386                 randconfig-r2103-20261123    gcc-8.5.0  cocci
i386                 randconfig-r2104-20261123    gcc-14     cocci
i386                 randconfig-r2108-20261123    gcc-8.5.0  cocci
i386                 randconfig-r2305-20261123    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261125    gcc-11.5.0
loongarch             randconfig-1001-20261125    gcc-11.5.0
loongarch             randconfig-2000-20261123    gcc-16.2.0
loongarch             randconfig-2001-20261123    gcc-16.2.0
loongarch             randconfig-2200-20261123    clang-24   smatch
loongarch            randconfig-r2100-20261123    gcc-14     cocci
loongarch            randconfig-r2300-20261123    gcc-12     sparse
loongarch            randconfig-r2302-20261123    gcc-11.5.0 sparse
loongarch            randconfig-r2302-20261123    gcc-14     sparse
loongarch            randconfig-r2302-20261123    gcc-14.4.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5235evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261123    gcc-8.5.0
m68k                  randconfig-2001-20261123    gcc-8.5.0
m68k                  randconfig-2200-20261123    gcc-8.5.0  smatch
m68k                 randconfig-r2100-20261123    gcc-8.5.0  cocci
m68k                 randconfig-r2101-20261123    gcc-8.5.0  cocci
m68k                 randconfig-r2102-20261123    gcc-8.5.0  cocci
m68k                 randconfig-r2105-20261123    gcc-8.5.0  cocci
m68k                 randconfig-r2303-20261123    clang-24   sparse
m68k                 randconfig-r2303-20261123    gcc-14     sparse
m68k                 randconfig-r2304-20261123    gcc-14.4.0 sparse
m68k                 randconfig-r2307-20261123    gcc-8.5.0  sparse
m68k                 randconfig-r2308-20261123    gcc-14     sparse
m68k                 randconfig-r2309-20261123    gcc-8.5.0  sparse
m68k                 randconfig-r2310-20261123    gcc-12.5.0 sparse
m68k                           sun3x_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261123    gcc-8.5.0
microblaze            randconfig-2200-20261123    gcc-16.2.0 smatch
microblaze           randconfig-r2302-20261123    clang-24   sparse
microblaze           randconfig-r2304-20261123    clang-24   sparse
microblaze           randconfig-r2306-20261123    gcc-12.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-17
mips                        bmips_be_defconfig    gcc-16.2.0
mips                      decstation_defconfig    clang-17
mips                  decstation_r4k_defconfig    clang-17
mips                            gcw0_defconfig    clang-24
mips                            ip30_defconfig    clang-17
mips                            ip30_defconfig    gcc-16.2.0
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                       pic32mzda_defconfig    clang-24
mips                  randconfig-2000-20261123    gcc-10.5.0
mips                  randconfig-2000-20261123    gcc-8.5.0
mips                  randconfig-2001-20261123    gcc-10.5.0
mips                  randconfig-2002-20261123    gcc-10.5.0
mips                  randconfig-2002-20261123    gcc-16.2.0
mips                  randconfig-2200-20261123    gcc-14.4.0 smatch
mips                 randconfig-r2100-20261123    gcc-8.5.0  cocci
mips                 randconfig-r2102-20261123    gcc-14     cocci
mips                 randconfig-r2108-20261123    clang-24   cocci
mips                 randconfig-r2304-20261123    gcc-11.5.0 sparse
mips                 randconfig-r2305-20261123    gcc-12     sparse
mips                 randconfig-r2311-20261123    gcc-12.5.0 sparse
mips                 randconfig-r2311-20261123    gcc-8.5.0  sparse
mips                          rt305x_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261125    gcc-11.5.0
nios2                 randconfig-1001-20261125    gcc-11.5.0
nios2                 randconfig-2000-20261123    gcc-16.2.0
nios2                 randconfig-2001-20261123    gcc-16.2.0
nios2                 randconfig-2200-20261123    gcc-8.5.0  smatch
nios2                randconfig-r2106-20261123    gcc-15.3.0 cocci
nios2                randconfig-r2109-20261123    clang-20   cocci
nios2                randconfig-r2110-20261123    gcc-16.2.0 cocci
nios2                randconfig-r2303-20261123    gcc-11.5.0 sparse
nios2                randconfig-r2307-20261123    gcc-13.5.0 sparse
nios2                randconfig-r2311-20261123    gcc-14     sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261123    gcc-10.5.0
openrisc              randconfig-2001-20261123    gcc-10.5.0
openrisc              randconfig-2001-20261123    gcc-16.2.0
openrisc              randconfig-2002-20261123    gcc-10.5.0
openrisc              randconfig-2200-20261123    gcc-12.5.0 smatch
openrisc             randconfig-r2107-20261123    clang-24   cocci
openrisc             randconfig-r2301-20261123    gcc-12     sparse
openrisc             randconfig-r2304-20261123    gcc-12     sparse
openrisc             randconfig-r2304-20261123    gcc-14     sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261125    clang-24
parisc                randconfig-1001-20261125    clang-24
parisc                randconfig-2000-20261123    gcc-16.2.0
parisc                randconfig-2001-20261123    gcc-16.2.0
parisc                randconfig-2200-20261123    gcc-14.4.0 smatch
parisc               randconfig-r2110-20261123    gcc-8.5.0  cocci
parisc               randconfig-r2305-20261123    gcc-14     sparse
parisc               randconfig-r2306-20261123    gcc-13.5.0 sparse
parisc               randconfig-r2307-20261123    gcc-12.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.2.0
powerpc                  mpc836x_rdk_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261125    clang-24
powerpc               randconfig-1001-20261125    clang-24
powerpc               randconfig-2000-20261123    clang-21
powerpc               randconfig-2001-20261123    clang-21
powerpc               randconfig-2002-20261123    clang-21
powerpc               randconfig-2200-20261123    gcc-9.5.0  smatch
powerpc              randconfig-r2301-20261123    gcc-14.4.0 sparse
powerpc              randconfig-r2310-20261123    gcc-14     sparse
powerpc                      tqm8555_defconfig    clang-17
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261125    clang-24
powerpc64             randconfig-1001-20261125    clang-24
powerpc64             randconfig-2000-20261123    clang-21
powerpc64             randconfig-2001-20261123    clang-21
powerpc64             randconfig-2002-20261123    clang-21
powerpc64             randconfig-2200-20261123    gcc-15.3.0 smatch
powerpc64            randconfig-r2102-20261123    gcc-8.5.0  cocci
powerpc64            randconfig-r2103-20261123    gcc-14     cocci
powerpc64            randconfig-r2104-20261123    gcc-8.5.0  cocci
powerpc64            randconfig-r2310-20261123    clang-24   sparse
powerpc64            randconfig-r2311-20261123    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261125    gcc-8.5.0
riscv                 randconfig-1001-20261125    gcc-8.5.0
riscv                 randconfig-2000-20261123    gcc-11.5.0
riscv                 randconfig-2001-20261123    gcc-11.5.0
riscv                 randconfig-2002-20261123    gcc-11.5.0
riscv                 randconfig-2003-20261123    gcc-11.5.0
riscv                 randconfig-2004-20261123    gcc-11.5.0
riscv                 randconfig-2005-20261123    gcc-11.5.0
riscv                 randconfig-2200-20261123    clang-17   smatch
riscv                randconfig-r2105-20261123    gcc-14     cocci
riscv                randconfig-r2308-20261123    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261125    gcc-8.5.0
s390                  randconfig-1001-20261125    gcc-8.5.0
s390                  randconfig-2000-20261123    clang-20
s390                  randconfig-2001-20261123    clang-20
s390                  randconfig-2002-20261123    clang-20
s390                  randconfig-2003-20261123    clang-20
s390                  randconfig-2004-20261123    clang-20
s390                  randconfig-2005-20261123    clang-20
s390                  randconfig-2200-20261123    clang-24   smatch
s390                 randconfig-r2104-20261123    gcc-8.5.0  cocci
s390                 randconfig-r2108-20261123    gcc-15.3.0 cocci
s390                 randconfig-r2109-20261123    clang-24   cocci
s390                 randconfig-r2110-20261123    clang-20   cocci
s390                 randconfig-r2311-20261123    gcc-13.5.0 sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-24
sh                    randconfig-1000-20261125    gcc-8.5.0
sh                    randconfig-1001-20261125    gcc-8.5.0
sh                    randconfig-2000-20261123    gcc-16.2.0
sh                    randconfig-2001-20261123    gcc-16.2.0
sh                    randconfig-2002-20261123    gcc-16.2.0
sh                    randconfig-2003-20261123    gcc-16.2.0
sh                    randconfig-2004-20261123    gcc-16.2.0
sh                    randconfig-2005-20261123    gcc-16.2.0
sh                    randconfig-2200-20261123    gcc-16.2.0 smatch
sh                   randconfig-r2111-20261123    gcc-15.3.0 cocci
sh                   randconfig-r2306-20261123    clang-24   sparse
sh                   randconfig-r2306-20261123    gcc-14     sparse
sh                   randconfig-r2306-20261123    gcc-8.5.0  sparse
sh                            se7343_defconfig    gcc-16.2.0
sh                            se7780_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                             shmin_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261125    gcc-12
sparc                 randconfig-1001-20261125    gcc-12
sparc                 randconfig-2000-20261123    gcc-9.5.0
sparc                 randconfig-2001-20261123    gcc-9.5.0
sparc                 randconfig-2200-20261123    gcc-12.5.0 smatch
sparc                randconfig-r2101-20261123    gcc-8.5.0  cocci
sparc                randconfig-r2102-20261123    gcc-14     cocci
sparc                randconfig-r2107-20261123    gcc-16.2.0 cocci
sparc                randconfig-r2305-20261123    gcc-14.4.0 sparse
sparc                randconfig-r2308-20261123    gcc-8.5.0  sparse
sparc64                           alldefconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261125    gcc-12
sparc64               randconfig-1001-20261125    gcc-12
sparc64               randconfig-2000-20261123    gcc-9.5.0
sparc64               randconfig-2001-20261123    gcc-9.5.0
sparc64               randconfig-2200-20261123    clang-22   smatch
sparc64              randconfig-r2103-20261123    gcc-14     cocci
sparc64              randconfig-r2104-20261123    gcc-14     cocci
sparc64              randconfig-r2106-20261123    gcc-16.2.0 cocci
sparc64              randconfig-r2111-20261123    clang-20   cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261125    gcc-12
um                    randconfig-1001-20261125    gcc-12
um                    randconfig-2000-20261123    gcc-9.5.0
um                    randconfig-2001-20261123    gcc-9.5.0
um                    randconfig-2200-20261123    clang-21   smatch
um                   randconfig-r2103-20261123    gcc-8.5.0  cocci
um                   randconfig-r2105-20261123    gcc-14     cocci
um                   randconfig-r2105-20261123    gcc-8.5.0  cocci
um                   randconfig-r2111-20261123    clang-24   cocci
um                   randconfig-r2300-20261123    gcc-14     sparse
um                   randconfig-r2307-20261123    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261125    clang-22
x86_64      buildonly-randconfig-1001-20261125    clang-22
x86_64      buildonly-randconfig-1002-20261125    clang-22
x86_64      buildonly-randconfig-1003-20261125    clang-22
x86_64      buildonly-randconfig-1004-20261125    clang-22
x86_64      buildonly-randconfig-1005-20261125    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261125    clang-22
x86_64                randconfig-1001-20261125    clang-22
x86_64                randconfig-1002-20261125    clang-22
x86_64                randconfig-1003-20261125    clang-22
x86_64                randconfig-1004-20261125    clang-22
x86_64                randconfig-1005-20261125    clang-22
x86_64                randconfig-2000-20261123    gcc-14
x86_64                randconfig-2001-20261123    gcc-14
x86_64                randconfig-2002-20261123    gcc-14
x86_64                randconfig-2003-20261123    gcc-14
x86_64                randconfig-2004-20261123    gcc-14
x86_64                randconfig-2005-20261123    gcc-14
x86_64                randconfig-2100-20261123    clang-22   cocci
x86_64                randconfig-2101-20261123    clang-22   cocci
x86_64                randconfig-2102-20261123    clang-22   cocci
x86_64                randconfig-2103-20261123    clang-22   cocci
x86_64                randconfig-2104-20261123    clang-22   cocci
x86_64                randconfig-2105-20261123    clang-22   cocci
x86_64                randconfig-2200-20261123    gcc-14     smatch
x86_64                randconfig-2300-20261123    gcc-14     sparse
x86_64                randconfig-2301-20261123    gcc-14     sparse
x86_64                randconfig-2302-20261123    gcc-14     sparse
x86_64               randconfig-r2101-20261123    gcc-14     cocci
x86_64               randconfig-r2107-20261123    gcc-15.3.0 cocci
x86_64               randconfig-r2302-20261123    gcc-12     sparse
x86_64               randconfig-r2309-20261123    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    clang-17
xtensa                           iss_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261125    gcc-12
xtensa                randconfig-1001-20261125    gcc-12
xtensa                randconfig-2000-20261123    gcc-12.5.0
xtensa                randconfig-2001-20261123    gcc-12.5.0
xtensa                randconfig-2200-20261123    gcc-8.5.0  smatch
xtensa               randconfig-r2101-20261123    gcc-14     cocci
xtensa               randconfig-r2109-20261123    gcc-16.2.0 cocci
xtensa               randconfig-r2110-20261123    clang-24   cocci
xtensa               randconfig-r2110-20261123    gcc-15.3.0 cocci
xtensa               randconfig-r2111-20261123    gcc-16.2.0 cocci
xtensa               randconfig-r2308-20261123    gcc-12.5.0 sparse
xtensa               randconfig-r2309-20261123    clang-24   sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
