Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA327FD6D;
	Thu,  5 Mar 2026 05:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772690107; cv=none; b=KTU0JhmEClk2gtC3Tk6YSf2kQoo01VkWVEJ9wH1+NtGsijvSExVfPbmhidu30H5sHPJjb7sdWNnE3271ZaF+HPXzBG4qy++WnJ5AgrMW1vB+i9IDZKy9v1hbd1Hbmq1VLf+KOegXqwu/6jqbnGOPCwbybClHp4vsHOPjun9b3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772690107; c=relaxed/simple;
	bh=saE/R53PoKUxMpAtJvPqY0KhOX/7wGAbKRXu7D6dADM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUIEOLRwbI/XeWd45w37PWGnROPIz9mEBPNEeSM/TOZhPtCADyGLomw9B1rbaoscNTRUYGj/OslR4fbDyq8pX7PRIWWp7VkRkPBLFrsRZDn42qwQLvnaeezEYsK+kS8JHQavl7zPM9RlqszKdWWMX+m1aKHpmlaecrPrvTP62Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dqxsu3S3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dqxsu3S3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772690104; x=1804226104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=saE/R53PoKUxMpAtJvPqY0KhOX/7wGAbKRXu7D6dADM=;
  b=Dqxsu3S3037saZP6ZnndZnyyN8pQo59DzrkdveSk9dSpdFzJfuodTT9Q
   wTXhtPC8IHQxnz6/sc09r/nz325rHdaruSq2N1Y1sRY9uMJKHyZK9nt/Y
   MejHsNc34QdYy6dXpwIzyco8Skk2ep75lfxd6kAMRFwmLyua8CmG4rjAS
   9C41VXZRuW5et2UperSqB7BQ/CctPZqHAnHmtyDAoCVABrO0nWlqGS+y6
   EzyJC5ZOkoAI9bnpgs8/Ve6INF04O6sezXiXUjXtuhDk2LcqZSmAhnzo4
   orat2gaBVTvbaHXmbWhOTbBgN1/HYhXP7ZLNxWPOL1p9fXZklE0ZnILek
   A==;
X-CSE-ConnectionGUID: auStydoMSua9V//FcbxQWA==
X-CSE-MsgGUID: WSdH6pz8Q8qjGhAiUmLtoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="85115192"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="85115192"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 21:55:04 -0800
X-CSE-ConnectionGUID: n2UTrrTpTvKtseP++6k1yg==
X-CSE-MsgGUID: pnmWYGjuR9qQoQWSr1YCag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="218574983"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 Mar 2026 21:55:02 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy1fn-00000000013-0LUC;
	Thu, 05 Mar 2026 05:54:59 +0000
Date: Thu, 5 Mar 2026 13:49:54 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] [PATCH]-This patch series completes the
 implementation of do_mq_timedreceive2 new        system calls that provide
 non-destructive peek functionality        on POSIX message queues
Message-ID: <202603051306.xpnYl8Oz-lkp@intel.com>
References: <20260304135126.77270-3-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304135126.77270-3-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v7.0-rc2 next-20260304]
[cannot apply to arnd-asm-generic/master tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection/20260305-020107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260304135126.77270-3-academic1mathura%40gmail.com
patch subject: [PATCH 3/3] [PATCH]-This patch series completes the implementation of do_mq_timedreceive2 new        system calls that provide non-destructive peek functionality        on POSIX message queues
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20260305/202603051306.xpnYl8Oz-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051306.xpnYl8Oz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051306.xpnYl8Oz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/csky/include/uapi/asm/unistd.h:3,
                    from arch/csky/include/asm/unistd.h:3,
                    from <stdin>:2:
>> ./arch/csky/include/generated/uapi/asm/unistd_32.h:352:9: warning: '__NR_mq_timedreceive_time64' redefined
     352 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/csky/include/generated/uapi/asm/unistd_32.h:299:9: note: this is the location of the previous definition
     299 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   <stdin>:1634:2: warning: #warning syscall mq_timedreceive2_time64 not implemented [-Wcpp]
--
   In file included from arch/csky/include/uapi/asm/unistd.h:3,
                    from arch/csky/include/asm/unistd.h:3,
                    from include/uapi/linux/unistd.h:8,
                    from include/uapi/linux/lsm.h:14,
                    from include/linux/security.h:36,
                    from include/net/scm.h:9,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:44,
                    from drivers/base/core.c:24:
>> ./arch/csky/include/generated/uapi/asm/unistd_32.h:352:9: warning: '__NR_mq_timedreceive_time64' redefined
     352 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/csky/include/generated/uapi/asm/unistd_32.h:299:9: note: this is the location of the previous definition
     299 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/csky/include/uapi/asm/unistd.h:3,
                    from arch/csky/include/asm/unistd.h:3,
                    from include/uapi/linux/unistd.h:8,
                    from include/linux/syscalls.h:91,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:64,
                    from kernel/sched/rq-offsets.c:5:
>> ./arch/csky/include/generated/uapi/asm/unistd_32.h:352:9: warning: '__NR_mq_timedreceive_time64' redefined
     352 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/csky/include/generated/uapi/asm/unistd_32.h:299:9: note: this is the location of the previous definition
     299 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:751:42: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     751 | sys_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args __user *uargs,
         |                                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:756:36: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     756 |                             struct mq_timedreceive2_args __user *uargs,
         |                                    ^~~~~~~~~~~~~~~~~~~~~
   In file included from arch/csky/include/uapi/asm/unistd.h:3,
                    from arch/csky/include/asm/unistd.h:3,
                    from <stdin>:2:
>> ./arch/csky/include/generated/uapi/asm/unistd_32.h:352:9: warning: '__NR_mq_timedreceive_time64' redefined
     352 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/csky/include/generated/uapi/asm/unistd_32.h:299:9: note: this is the location of the previous definition
     299 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   <stdin>:1634:2: warning: #warning syscall mq_timedreceive2_time64 not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
