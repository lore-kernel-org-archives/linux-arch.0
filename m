Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE135DA79
	for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439678; cv=none; b=FQUhtqmItjhYf4v5uiuYIb+hrCkDkLEQ8eCcyyaaZLZD+atnr1E1BtULmCznBRuMAHmX5cEvv/G/WzCG5Abjsj7axCSjHfl+GvDGTE4il5t/KDa2qTqjlZOIfCFsB3dOx11UkaxsDEqlQBhIia4pPH8MNJgMMAnTieM2oDR0kZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439678; c=relaxed/simple;
	bh=6CFH/hg1Ov1WfGfDWpFTvm7ZV97MeuSSfnzyWhkMwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OxGSlYXclUZ2IIK3p2IVuFJg3DKrECpmLwl3G29M+1cOv2IyUWe33cTYbDnX0ApHxwD+AgbgK9AtEr8BY0r+JUv3svEA1tIlVF0HM0iLM/lRyzytLUGDJEvOe5dQUIB6XTm47Nj8DwRDwhH3srGD9Og/RQ0yewl/uwhwoA5c49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gobDzRPp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gobDzRPp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789439674; x=1820975674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6CFH/hg1Ov1WfGfDWpFTvm7ZV97MeuSSfnzyWhkMwFc=;
  b=gobDzRPpKALqs6pwt/kCBFPwleiD+MlXozeMWPpiFy0Q79RkaPQYrLZu
   +Crs9Wd2te3jZJAlb1rUqxBbKX8xF/TSVLIy9F/Pq4WWeOz+LFCzSRKo1
   uTDCxdz7RoHJA5yzz40teS02nQxJU1VRMf95kGQ7YOno0eNqNuV9lrCqw
   0j2lcOmQlt4vpH6GQOlClATXPkzr7/vWTyE240ycxhcNe7Jso5FM4oZ47
   1wDlfU59R4cPVmcYkHdRrA4t4PSNYOOjgSR0qlFpvDmDE04EJE/bP5N20
   mI74Ek4q8Y/nIrZRpUy2+6/Rtc3akVSVRVyODMfNMXSOKmzIjUnNJZIz3
   g==;
X-CSE-ConnectionGUID: uhDGuVsvS/2vd1KSVvzlQw==
X-CSE-MsgGUID: UTIzwxEETRCmw24Hdrfrow==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92304630"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92304630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 19:34:30 -0700
X-CSE-ConnectionGUID: BssNTp6vS/C2kWKGTpwHrQ==
X-CSE-MsgGUID: ODChjbPcT4i1iXHNg+4FvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268528034"
Received: from igk-lkp-server01.igk.intel.com (HELO 71151d66d536) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 14 Sep 2026 19:34:29 -0700
Received: from kbuild by 71151d66d536 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6J06-000000000Sx-3UWS;
	Tue, 15 Sep 2026 02:34:26 +0000
Date: Tue, 15 Sep 2026 04:33:37 +0200
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?"Andr=C3=A9?= Almeida" <andrealmeid@igalia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [arnd-asm-generic:asm-generic 9/13] make[3]: *** No rule to
 make target 'arch/mips/include/generated/uapi/asm/unistd_n64.h', needed by
 'all'.
Message-ID: <202609150414.DqgSFy2C-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
head:   bc3f9642aa608f557a37a97d6c4f73a223fb35e3
commit: f01e296ac213455eacb228e75c7fe04f529757bb [9/13] mips: Use the common syscall table
config: mips-randconfig-r064-20260915 (https://download.01.org/0day-ci/archive/20260915/202609150414.DqgSFy2C-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260915/202609150414.DqgSFy2C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609150414.DqgSFy2C-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'arch/mips/include/generated/uapi/asm/unistd_n64.h', needed by 'all'.
>> make[3]: *** No rule to make target 'arch/mips/include/generated/uapi/asm/unistd_n32.h', needed by 'all'.
   make[3]: Target 'all' not remade because of errors.
   make[2]: *** [arch/mips/Makefile:437: archheaders] Error 2 shuffle=2927363064
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2927363064
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2927363064
   make: Target 'prepare' not remade because of errors.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
