Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC001369D67;
	Fri, 12 Jun 2026 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227275; cv=none; b=BPUxjvV7ecwM81QOiTolOuoqZqUtO3qCRtkkL3Ut6fOyb5RkZpYhRRhpNCX71bP3gfuUcxEDrUFVz6Qc/mYGS9CydWDuITnJcQSaE9VYtUZS8Jw8AyJCwmq98H70HXbYIy6NBxYUXJZ3D+4KKwZiacXtlJIpdT5tmsebsuO0GEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227275; c=relaxed/simple;
	bh=jCW9P9kX3+FEMhD6Eo/EVvG7uM9wj4pAIXIyaruKRf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrIY/XeTX8QkFv6iFFyQT+q2X/yeErLTdl9T6ExWenoznLB4oiK4SUE45b6xZqGTwzeWPO5WlJYPlW9S87RW3I3mV2rCmPEKj5VEladugTH8XPQSG319qoSKq6ms02g2sVeoVXwNUKpsu4pF54qwKEvaE11zTY42Ku2+RnWCDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBY59Zj/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBY59Zj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227269; x=1812763269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jCW9P9kX3+FEMhD6Eo/EVvG7uM9wj4pAIXIyaruKRf0=;
  b=eBY59Zj/YCl4ymHygAKjD+p3B6sF3/moUOr7cbBJ+hAZQ+gM3sQrHl2l
   iA0miWeRJbLVDC/dHxbswgNU05B/hxpDwcdy9i368yDsxcZFCpLo2yYBf
   VskpKZU5sZZiYjW9E5Hajgo3cskj/tdleihtqSNzrdznUdrdoptVar9Uy
   wCWKYglADAX+PyHLfgaBKApRSWiKh7v3idm3RsVeOE9S/bdAuoaKgRa6z
   4iFoZqj/TLq8ZwBoa1mqCTU1LjssTcX5IJvOG3Ig7thhUU2sClPnuIECG
   A+IINEGlChqhAGPewdeVNwtEGs4gbyfNfw2Ri09ctj48f986WoKsdD8xq
   w==;
X-CSE-ConnectionGUID: Rrwx0XbpR/GF6xeDVUIjhQ==
X-CSE-MsgGUID: xjlKBoLNRLajh8Wa9UV2Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85896235"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="85896235"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:21:08 -0700
X-CSE-ConnectionGUID: 0ab6YTUgQ6qrH23KedlKEQ==
X-CSE-MsgGUID: H/huuM1cTmaZaGAnBvpY+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="244242437"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jun 2026 18:21:06 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXqZz-00000000O6q-2txQ;
	Fri, 12 Jun 2026 01:21:03 +0000
Date: Fri, 12 Jun 2026 09:20:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, paul@paul-moore.com, eparis@redhat.com,
	arnd@arndb.de, sgrubb@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
Message-ID: <202606120946.0eNy5YXB-lkp@intel.com>
References: <20260610164719.2668906-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610164719.2668906-1-rrobaina@redhat.com>

Hi Ricardo,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on linus/master v7.1-rc7 next-20260610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Robaina/audit-add-missing-syscalls-to-PERM-class-tables/20260611-024240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
patch link:    https://lore.kernel.org/r/20260610164719.2668906-1-rrobaina%40redhat.com
patch subject: [PATCH] audit: add missing syscalls to PERM class tables
config: riscv-randconfig-001-20260611 (https://download.01.org/0day-ci/archive/20260612/202606120946.0eNy5YXB-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606120946.0eNy5YXB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606120946.0eNy5YXB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/audit.c:23:
>> include/asm-generic/audit_change_attr.h:52:1: error: '__NR_utimensat' undeclared here (not in a function); did you mean 'vfs_utimes'?
    __NR_utimensat,
    ^~~~~~~~~~~~~~
    vfs_utimes


vim +52 include/asm-generic/audit_change_attr.h

  > 52	__NR_utimensat,

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
