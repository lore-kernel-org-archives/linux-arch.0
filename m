Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF037FF56;
	Fri,  3 Apr 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205906; cv=none; b=lDQypz697sWb3MwwvcQPdhrUbBI6kIh8l0hVC0v/SIWA6Di4dFWREsUxEOqt1YynJn/rel6O7Bj+JEF+MC6YgKF9Hr2sjhheqHdNzUGRYjrTLnjic/FoB91ZjoxoYyMN8qYRMbsjpPQ/Kx3AqCk5tq9aaRePSO2Ty1Edck/MuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205906; c=relaxed/simple;
	bh=Cj6aLvB2CBIox/OySwYL4iio2nwTbpFsHisndqvjKg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AddPLal3ZFCU22SHIAwoHZgQSb56IK5f7ibe+Fxo2eZBgJC6YJJ2IZZKcroqkPeZT13OVx57pa54vFFTRz6/C49m0ms37JYX7VtDJFbshmS0QyzvdK3INgIl5dRf8krGZXQLceVwV1wTSe4OKnG+9X3s3VHVKy5omW/gQKhivYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUMzUqMN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUMzUqMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775205905; x=1806741905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cj6aLvB2CBIox/OySwYL4iio2nwTbpFsHisndqvjKg0=;
  b=jUMzUqMN5bHWE2/96TLSJ/4fAr4gDhL/dZyBUg+lRrHYORTLJHSsU3px
   r86nVCXT8Mn117BEHEzb5i2lu3j/paKB/piqECD4hYoTq4KWHzYrm0Apn
   oNhtrPIxBCYHYgn8aThnthXLtRos6EjO9ugNmuOLfQpNUccfWogXzD+V6
   QgmE4X5292U2Y0SVC7Uv+2p/PouFMjgOW3AIaYO6KcTHKqeQNNqBIDLvu
   dNWdHWO0wgAN/gFQBdSFKwODtORqnKT/nvZmj4F6EdCVRoxFXd6m/tj9u
   eE+ct2EcKVpCMJ0D2OXm8NZz0rVtnd5+okUK8/N6z76CTsBkepRzXcA+C
   Q==;
X-CSE-ConnectionGUID: bBxephoWTayBDtC89XATyw==
X-CSE-MsgGUID: yDpeXjk9QeWjDHjrOVt6xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86888926"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="86888926"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 01:45:01 -0700
X-CSE-ConnectionGUID: TVu48rzWTI+Sb00PRs8tig==
X-CSE-MsgGUID: v3SmVUDoQ8urF2agRGzWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="226368657"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Apr 2026 01:44:59 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8a9A-0000000015H-10YM;
	Fri, 03 Apr 2026 08:44:56 +0000
Date: Fri, 3 Apr 2026 16:44:16 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 1/4] IPC: Added New system call do_mq_timedreceive2()
 for non-destructive peek on posix mqueue
Message-ID: <202604030741.FjjnwM09-lkp@intel.com>
References: <20260315040827.156558-2-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315040827.156558-2-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v7.0-rc6 next-20260401]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/IPC-Added-New-system-call-do_mq_timedreceive2-for-non-destructive-peek-on-posix-mqueue/20260315-143134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20260315040827.156558-2-academic1mathura%40gmail.com
patch subject: [PATCH v1 1/4] IPC: Added New system call do_mq_timedreceive2() for non-destructive peek on posix mqueue
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20260403/202604030741.FjjnwM09-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604030741.FjjnwM09-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604030741.FjjnwM09-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/mqueue.h: leak CONFIG_COMPAT to user-space
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/linux/mqueue.h] Error 1
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1431: headers] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
