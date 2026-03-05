Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306628A1E6;
	Thu,  5 Mar 2026 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772690109; cv=none; b=GTbwwPHyqdAKvl7Hd0YGpbPKnioDwn1UFkHaEhwL/EhJnDrAFKG7VY9beK4wzKYHjPDsdiUI5ZkmsKb6zt40fjlq2W2nqEjbbT5hqjcXPOtr4Aqx/Ph/owFw9rDjkV5o3njqxdAq++jYTy5l1YGI4LOwhHhXmOVhgABnJe74vNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772690109; c=relaxed/simple;
	bh=FLQoTFQUo4QiFSgYR9UU3E7n7VY4bud+kKDsw6E++t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVk6WUyE7YwCU4iyANac+9ab2RU3TN3kA/RnJE3w/11eoXhga5pMxacYjm52GTGBruuUS9Z/3GR3YS+48wVXZvVMHcFZfG51t8UucmaGswIhVZ+JLrlq/p2ogLtLOv3AsRYtHy0MkloH+rnYGy2PrpexlnrQPAQm9EtTfBCFdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VElikVqd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VElikVqd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772690107; x=1804226107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLQoTFQUo4QiFSgYR9UU3E7n7VY4bud+kKDsw6E++t8=;
  b=VElikVqd4b232AwfYyj8M26FrMqqmv7GS9kfFISTpMuA0Dz9pZn4Vi+c
   94kiduB+B86AK1JQYAPjAru6AGPOxmlI6zPonuzax5DgRcR8wYKwTA0Hj
   XPIsXIQgI5cvYeUjQPR+XnYzwYgKa5VCoxN7BgdwtjTuxVpMlbVsJJjro
   55C2VORk9Ifbt36oCqHsfqFzLd6muvfsIlPN0qO/q5zmML88m3/o4dy2V
   oIzwrfOz7+KYeiLEXWOUBZq41C41TY7ndPaB0Pb3aYzJpB5Bl9YYPowIH
   4pR0q/JiUHmXY7rfdXHn0duT6uGTXNTS7XOAcMLrMBCtaqwwBaOiZ+CM5
   g==;
X-CSE-ConnectionGUID: 4dgeABI2QZen7HyQhG0Y3A==
X-CSE-MsgGUID: 80Y7gehEQUCLcHynFupOaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="85115197"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="85115197"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 21:55:04 -0800
X-CSE-ConnectionGUID: TzH3e4CxT22RkWBFlSXM/g==
X-CSE-MsgGUID: 4NCjl+xsS6GpWGEBWTqy6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="218574984"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 Mar 2026 21:55:02 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy1fn-00000000015-0UYI;
	Thu, 05 Mar 2026 05:54:59 +0000
Date: Thu, 5 Mar 2026 13:51:30 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] [PATCH]-This patch series completes the
 implementation of do_mq_timedreceive2 new        system calls that provide
 non-destructive peek functionality        on POSIX message queues
Message-ID: <202603051353.0aNGnszx-lkp@intel.com>
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
[also build test WARNING on shuah-kselftest/fixes linus/master v7.0-rc2 next-20260303]
[cannot apply to arnd-asm-generic/master tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection/20260305-020107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260304135126.77270-3-academic1mathura%40gmail.com
patch subject: [PATCH 3/3] [PATCH]-This patch series completes the implementation of do_mq_timedreceive2 new        system calls that provide non-destructive peek functionality        on POSIX message queues
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20260305/202603051353.0aNGnszx-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051353.0aNGnszx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051353.0aNGnszx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arc/include/uapi/asm/unistd.h:10,
                    from arch/arc/include/asm/unistd.h:5,
                    from <stdin>:2:
>> ./arch/arc/include/generated/uapi/asm/unistd_32.h:356:9: warning: '__NR_mq_timedreceive_time64' redefined
     356 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/arc/include/generated/uapi/asm/unistd_32.h:303:9: note: this is the location of the previous definition
     303 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   <stdin>:1634:2: warning: #warning syscall mq_timedreceive2_time64 not implemented [-Wcpp]
--
   In file included from arch/arc/include/uapi/asm/unistd.h:10,
                    from arch/arc/include/asm/unistd.h:5,
                    from arch/arc/include/asm/entry.h:10,
                    from arch/arc/kernel/head.S:14:
>> ./arch/arc/include/generated/uapi/asm/unistd_32.h:356:9: warning: '__NR_mq_timedreceive_time64' redefined
     356 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/arc/include/generated/uapi/asm/unistd_32.h:303:9: note: this is the location of the previous definition
     303 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/arc/include/uapi/asm/unistd.h:10,
                    from arch/arc/include/asm/unistd.h:5,
                    from include/uapi/linux/unistd.h:8,
                    from arch/arc/kernel/process.c:16:
>> ./arch/arc/include/generated/uapi/asm/unistd_32.h:356:9: warning: '__NR_mq_timedreceive_time64' redefined
     356 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/arc/include/generated/uapi/asm/unistd_32.h:303:9: note: this is the location of the previous definition
     303 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arc/kernel/process.c:19:
   include/linux/syscalls.h:751:42: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     751 | sys_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args __user *uargs,
         |                                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:756:36: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     756 |                             struct mq_timedreceive2_args __user *uargs,
         |                                    ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/arc/include/uapi/asm/unistd.h:10,
                    from arch/arc/include/asm/unistd.h:5,
                    from include/uapi/linux/unistd.h:8,
                    from include/linux/syscalls.h:91,
                    from arch/arc/kernel/sys.c:3:
>> ./arch/arc/include/generated/uapi/asm/unistd_32.h:356:9: warning: '__NR_mq_timedreceive_time64' redefined
     356 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/arc/include/generated/uapi/asm/unistd_32.h:303:9: note: this is the location of the previous definition
     303 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:751:42: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     751 | sys_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args __user *uargs,
         |                                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:756:36: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     756 |                             struct mq_timedreceive2_args __user *uargs,
         |                                    ^~~~~~~~~~~~~~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/arc/kernel/sys.c:14:52: note: in expansion of macro '__SYSCALL'
      14 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arc/include/generated/asm/syscall_table_32.h:1:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       1 | __SYSCALL_WITH_COMPAT(0, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[0]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/arc/kernel/sys.c:14:52: note: in expansion of macro '__SYSCALL'
      14 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arc/include/generated/asm/syscall_table_32.h:1:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       1 | __SYSCALL_WITH_COMPAT(0, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:2:1: note: in expansion of macro '__SYSCALL'
       2 | __SYSCALL(1, sys_io_destroy)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[1]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:2:1: note: in expansion of macro '__SYSCALL'
       2 | __SYSCALL(1, sys_io_destroy)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/arc/kernel/sys.c:14:52: note: in expansion of macro '__SYSCALL'
      14 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arc/include/generated/asm/syscall_table_32.h:3:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       3 | __SYSCALL_WITH_COMPAT(2, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[2]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/arc/kernel/sys.c:14:52: note: in expansion of macro '__SYSCALL'
      14 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arc/include/generated/asm/syscall_table_32.h:3:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       3 | __SYSCALL_WITH_COMPAT(2, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:4:1: note: in expansion of macro '__SYSCALL'
       4 | __SYSCALL(3, sys_io_cancel)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[3]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:4:1: note: in expansion of macro '__SYSCALL'
       4 | __SYSCALL(3, sys_io_cancel)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:5:1: note: in expansion of macro '__SYSCALL'
       5 | __SYSCALL(4, sys_io_getevents_time32)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[4]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:5:1: note: in expansion of macro '__SYSCALL'
       5 | __SYSCALL(4, sys_io_getevents_time32)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:6:1: note: in expansion of macro '__SYSCALL'
       6 | __SYSCALL(5, sys_setxattr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[5]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:6:1: note: in expansion of macro '__SYSCALL'
       6 | __SYSCALL(5, sys_setxattr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:7:1: note: in expansion of macro '__SYSCALL'
       7 | __SYSCALL(6, sys_lsetxattr)
--
   In file included from arch/arc/include/uapi/asm/unistd.h:10,
                    from arch/arc/include/asm/unistd.h:5,
                    from include/uapi/linux/unistd.h:8,
                    from include/linux/syscalls.h:91,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:64,
                    from kernel/sched/rq-offsets.c:5:
>> ./arch/arc/include/generated/uapi/asm/unistd_32.h:356:9: warning: '__NR_mq_timedreceive_time64' redefined
     356 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/arc/include/generated/uapi/asm/unistd_32.h:303:9: note: this is the location of the previous definition
     303 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:751:42: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     751 | sys_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args __user *uargs,
         |                                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:756:36: warning: 'struct mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
     756 |                             struct mq_timedreceive2_args __user *uargs,
         |                                    ^~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arc/include/uapi/asm/unistd.h:10,
                    from arch/arc/include/asm/unistd.h:5,
                    from <stdin>:2:
>> ./arch/arc/include/generated/uapi/asm/unistd_32.h:356:9: warning: '__NR_mq_timedreceive_time64' redefined
     356 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/arc/include/generated/uapi/asm/unistd_32.h:303:9: note: this is the location of the previous definition
     303 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   <stdin>:1634:2: warning: #warning syscall mq_timedreceive2_time64 not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
