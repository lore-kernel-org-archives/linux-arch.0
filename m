Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F232692B;
	Sun, 10 May 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449253; cv=none; b=mKi3YWc7z78eZhLm+LQ9WEMclRwX1SuNsyhg92tU8UKokUKoVolQRbMN71achaudFHZqijgMUaMSkJE9bFMB12LkBh3Qd3r0LFlVvedFt4qr3OcfCspLHowYT8L99OjEJ6TjyY1S2MH7yRolK9YYmSdAA56Rbv+eTkAil153Czc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449253; c=relaxed/simple;
	bh=hXygK0G1nkNaf+vivvqESQJciIwrQ+dae5+fHbGeSio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/UEI/js/L0Pf38O0lIsYWJibQq7IwsbtBxmYmayTSBkRF96ZPSMI8lK0E0N/l/GEkBI4yRByImowr7h8aNR162f90p+9gWSHy02g5bO0+wWCHbZoXPaW9zRvVLa5bk4LpC+QypYzz3KCRuW2HHkRL8USlahYUXEBvSml25UfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQSTQ/vT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQSTQ/vT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778449251; x=1809985251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXygK0G1nkNaf+vivvqESQJciIwrQ+dae5+fHbGeSio=;
  b=IQSTQ/vT6sXIAVlnePa/elToEHKfPYnyFHrf8hHtl23ErrKqFFKu25bm
   GhiVuvZJNnCxDGGnhNSgPxuOUKiG4+4PwRD0kPidyjiB9xyN9uT7nPfKP
   zdsTGZY1851f/g4+hU6E8GGlNFylpNul5VD1PCVP4qYPw26qCEMf1y7z+
   tI0LNJPJINRh0PXZ+kRTCJkoJNX4oDZGQ6dow/zp8qONKT4Kx6iEObdnE
   Im5xN3XJg9PW8rLo2FBMsUayssLF1WU6tY2yr7C8g/EotD53xA6Vm5KSx
   nh68yI4TysMpg6WMifPFDLHjxIeOp59ohpLNIJSQFp0NDlzoGEx4PuVcE
   Q==;
X-CSE-ConnectionGUID: vV4SY7JWRF2NbrjtKfEKCg==
X-CSE-MsgGUID: dWQEEr9XRkW9hBpCNXuAUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="104797735"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="104797735"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 14:40:50 -0700
X-CSE-ConnectionGUID: JpwARR4wQqWWIRcLPmbppQ==
X-CSE-MsgGUID: x5NVtusiQTqC0hpHwIzVig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="237511727"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 10 May 2026 14:40:48 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMBtG-000000007mz-20dT;
	Sun, 10 May 2026 21:40:46 +0000
Date: Sun, 10 May 2026 23:40:10 +0200
From: kernel test robot <lkp@intel.com>
To: Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mm: make zeropage read-only
Message-ID: <202605102324.g5xWKUc3-lkp@intel.com>
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260510/202605102324.g5xWKUc3-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605102324.g5xWKUc3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605102324.g5xWKUc3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   /tmp/ccZJHv5S.s: Assembler messages:
>> /tmp/ccZJHv5S.s:14940: Warning: setting incorrect section attributes for .rodata..page_aligned

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
