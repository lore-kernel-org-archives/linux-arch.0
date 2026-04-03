Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C903845A5;
	Fri,  3 Apr 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205906; cv=none; b=WgMKLuXloKxPJC3XKeBnvkmSFHo8kL0+jNM5SIhZcujluooU7V1pxR4YTedZNDbkOVvhuQqmEKhqCP41s94FqNDdqzCrPPYYLz8aTyDUbuBP4E7Toit+wB4AhpLGbk15/+Bd7+tYGYKFRsBA+JctcuG/nqLPIlKnZ5Hnqm12JSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205906; c=relaxed/simple;
	bh=tLTLzFAMTM1rw1Oww+ppWMIFA2Da83NWm0LlHMKNhlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBaiVWwp1tUD1P9LCOHZ3zti9UMueidjpePHnX600R+pFjEG27fQQUiCTgerJeXheeO/UpcnPPnbIai22N3ARwfAAJJm9/t1YoExJ4YNAn3oIwucHTmRPTfiBgcX5DnkBWrpLw3I6J2rjDOqtmCTc+UPvn7EM998FV+3a8qHS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+4BiI9N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+4BiI9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775205905; x=1806741905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tLTLzFAMTM1rw1Oww+ppWMIFA2Da83NWm0LlHMKNhlA=;
  b=D+4BiI9NmHKyrmEro9CrVdVtt6y4WYdBrmiEgQ5LP4XbIskDG4wNRK+9
   1oBx1YgVNMbihGzo9vzRdfwTNAXcotudbzoT5/Q97IIGtuS6UDDJU/pGq
   zpb7oFsqqEkHBBDSr2ie3Ek4N8dtMYzj5KD+1UPtOcFUFSKRuT9CzTfro
   meIthe38V0g+gc4+D4gdmFsg/AQgjj5ED0yXmROYE0YMAVk6C4iNC/B3L
   IZo2WR+RHJravJghQ2NLh+pMfnmf0N7ccC/dGw3X/4mIHs5r7PgDPGajU
   hVjvAnEsA611fahhCU8S+FboMAoXFxaC9P3nLZz6IqOUgx4QeLm6vdq9t
   g==;
X-CSE-ConnectionGUID: cZcZKQCFRni0acTYa6PYSQ==
X-CSE-MsgGUID: 2yp1GdWjTKSWwbGz9pk7Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86888927"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="86888927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 01:45:01 -0700
X-CSE-ConnectionGUID: 6gzePHlgQaGymIk0phTsEg==
X-CSE-MsgGUID: ub7Axl/9TLKpjeacaRUOmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="226368655"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Apr 2026 01:44:58 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8a9A-0000000015L-18jz;
	Fri, 03 Apr 2026 08:44:56 +0000
Date: Fri, 3 Apr 2026 16:44:20 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	academic1mathura@gmail.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 1/4] IPC: Added New system call do_mq_timedreceive2()
 for non-destructive peek on posix mqueue
Message-ID: <202604030850.kLrlQyOM-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on tip/perf/core perf-tools/perf-tools linus/master v7.0-rc6 next-20260401]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/IPC-Added-New-system-call-do_mq_timedreceive2-for-non-destructive-peek-on-posix-mqueue/20260315-143134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20260315040827.156558-2-academic1mathura%40gmail.com
patch subject: [PATCH v1 1/4] IPC: Added New system call do_mq_timedreceive2() for non-destructive peek on posix mqueue
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20260403/202604030850.kLrlQyOM-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e3cbd9984a78422c3799629eb6b5f7f7818c1a11)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604030850.kLrlQyOM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604030850.kLrlQyOM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from init/do_mounts.c:23:
   In file included from include/linux/nfs_fs.h:32:
   In file included from include/linux/sunrpc/clnt.h:29:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:103:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:44:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:13:
   In file included from include/net/compat.h:8:
>> include/linux/compat.h:805:65: warning: declaration of 'struct compat_mq_timedreceive2_args' will not be visible outside of this function [-Wvisibility]
     805 | asmlinkage long compat_sys_mq_timedreceive2(mqd_t mqdes, struct compat_mq_timedreceive2_args __user *uargs,
         |                                                                 ^
   1 warning generated.


vim +805 include/linux/compat.h

   799	
   800	#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
   801	asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
   802			const struct iovec __user *vec,
   803			unsigned long vlen, loff_t pos, rwf_t flags);
   804	#endif
 > 805	asmlinkage long compat_sys_mq_timedreceive2(mqd_t mqdes, struct compat_mq_timedreceive2_args __user *uargs,
   806												unsigned int flags, unsigned long index,
   807												struct old_timespec32 __user *abs_timeout);
   808	/*
   809	 * Deprecated system calls which are still defined in
   810	 * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
   811	 */
   812	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
