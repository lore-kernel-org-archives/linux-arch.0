Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09ED30BB97;
	Sat,  7 Mar 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887457; cv=none; b=cqImQLKrQz8DvNDUBH5jp5agj7QipYXmaPktnXaXvSnosWtudHl1b96phEgJUEDA45KnkTWw3tILtZjILKEuxFogiw0ZvWh3g6+e2yEd32G/+eEeW2/ycf3vqQhkNTNRFALLF2tYwXYCCjumWbIm5plSjtKCC9Cee/IyZJ8N2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887457; c=relaxed/simple;
	bh=egICFilckyqhOCeUwSYsMbOVEf6BLClzIWoLFEf59Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3tqd3DyJBjM9oH4lS+Y0I++ZIuD8Sz98l19Xp/TmBFd4k4P2uU//FR7GRxphDZFJCx/j+mE9JajfZ5dNzI9xlNKxOwfIZ7hvgbLZhVY/2B+so2ArNuoVWHPPXnkjQUTshI1UCWG28mUdbJg34leIApvKTkmJffTqNBCUGZPdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWM8JSu2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWM8JSu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772887454; x=1804423454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egICFilckyqhOCeUwSYsMbOVEf6BLClzIWoLFEf59Ck=;
  b=CWM8JSu2qWcvmlRUR5yN8LdS1tha9tmRLbLd0H+tWDQDk66kxwDCSAxW
   qTOYNK/wSKIVaCSCu351x90DZfjHge1z216rFEX+LV0VDqmu/YKZWvFiw
   LWgfsHpBOdCNXgl0HaMnbevIVVjx0RVKsClK2NON6YnoPaljAxqE1gryI
   j4ISBQ0F4jxjL4ddFqzcqw30mZxyvZEepvbTdzgjLkSIELPa0j7v7UGe1
   ccUNsfVbAnokMmSyWi3U2xsq52LXs7LaakvBIWO7Q57P7yvVVkVOaEJ8j
   wEuw3NDvK7CcrkXvIrUXUOFMvNwUf2LSjS4NOemHHSXtQEpp7QlWH8XsK
   g==;
X-CSE-ConnectionGUID: GOJsJABPR2C5FAslBJUBkQ==
X-CSE-MsgGUID: IkHqngmJS5OWVWuoyxNT5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="99449721"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="99449721"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 04:44:14 -0800
X-CSE-ConnectionGUID: yya9cmgLSwmCh1EtD2o9Dw==
X-CSE-MsgGUID: +1GcB3TiTam/csmQlO5yLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="242289282"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Mar 2026 04:44:12 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyr0s-000000001yz-0Sna;
	Sat, 07 Mar 2026 12:44:10 +0000
Date: Sat, 7 Mar 2026 20:43:25 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	academic1mathura@gmail.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [
 mq_peek syscall] for non-destructive receive and inspection,fix minor
 issue,prepared doc.
Message-ID: <202603072056.0e7wfE3v-lkp@intel.com>
References: <20260306075009.83723-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306075009.83723-1-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes brauner-vfs/vfs.all linus/master v7.0-rc2 next-20260306]
[cannot apply to tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection-fix-minor-issue-prep/20260306-155240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260306075009.83723-1-academic1mathura%40gmail.com
patch subject: [PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [ mq_peek syscall] for non-destructive receive and inspection,fix minor issue,prepared doc.
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260307/202603072056.0e7wfE3v-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603072056.0e7wfE3v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603072056.0e7wfE3v-lkp@intel.com/

All errors (new ones prefixed by >>):

   ipc/mqueue.c:1748:10: warning: declaration of 'struct compat_mq_timedreceive2_args' will not be visible outside of this function [-Wvisibility]
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                        ^
   ipc/mqueue.c:1748:10: warning: declaration of 'struct compat_mq_timedreceive2_args' will not be visible outside of this function [-Wvisibility]
   ipc/mqueue.c:1748:10: warning: declaration of 'struct compat_mq_timedreceive2_args' will not be visible outside of this function [-Wvisibility]
>> ipc/mqueue.c:1747:1: error: incompatible pointer types passing 'struct compat_mq_timedreceive2_args *' to parameter of type 'struct compat_mq_timedreceive2_args *' [-Werror,-Wincompatible-pointer-types]
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1749 |                 unsigned int, flags, const unsigned long, index,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1750 |                 const struct old_timespec32 __user *, u_abs_timeout)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: expanded from macro 'SYSCALL_DEFINE5'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:237:2: note: expanded from macro 'SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:230:37: note: expanded from macro '__SYSCALL_DEFINEx'
     230 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                                           ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/syscalls.h:123:42: note: expanded from macro '__MAP5'
     123 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ~~~~~~~^~~~~~~~~~~~~~
   include/linux/syscalls.h:122:27: note: expanded from macro '__MAP4'
     122 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                           ^~~~~~
   include/linux/syscalls.h:133:25: note: expanded from macro '__SC_CAST'
     133 | #define __SC_CAST(t, a) (__force t) a
         |                         ^~~~~~~~~~~~~
   ipc/mqueue.c:1748:49: note: passing argument to parameter 'uargs' here
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                                                               ^
   ipc/mqueue.c:1748:10: warning: declaration of 'struct compat_mq_timedreceive2_args' will not be visible outside of this function [-Wvisibility]
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                        ^
>> ipc/mqueue.c:1747:1: error: conflicting types for '__do_sys_mq_timedreceive2_time32'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^
   include/linux/syscalls.h:230:36: note: expanded from macro 'SYSCALL_DEFINE5'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:237:2: note: expanded from macro 'SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   arch/x86/include/asm/syscall_wrapper.h:235:21: note: expanded from macro '__SYSCALL_DEFINEx'
     235 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^
   <scratch space>:71:1: note: expanded from here
      71 | __do_sys_mq_timedreceive2_time32
         | ^
   ipc/mqueue.c:1747:1: note: previous declaration is here
   include/linux/syscalls.h:230:36: note: expanded from macro 'SYSCALL_DEFINE5'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:237:2: note: expanded from macro 'SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   arch/x86/include/asm/syscall_wrapper.h:225:21: note: expanded from macro '__SYSCALL_DEFINEx'
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^
   <scratch space>:44:1: note: expanded from here
      44 | __do_sys_mq_timedreceive2_time32
         | ^
>> ipc/mqueue.c:1756:6: error: call to undeclared function 'get_compat_mq_args'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1756 |         if (get_compat_mq_args(pargs, uargs))
         |             ^
   ipc/mqueue.c:1756:6: note: did you mean 'get_compat_msghdr'?
   include/net/compat.h:51:5: note: 'get_compat_msghdr' declared here
      51 | int get_compat_msghdr(struct msghdr *, struct compat_msghdr __user *,
         |     ^
   4 warnings and 3 errors generated.


vim +1747 ipc/mqueue.c

  1746	
> 1747	SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
> 1748			struct compat_mq_timedreceive2_args __user *, uargs,
  1749			unsigned int, flags, const unsigned long, index,
  1750			const struct old_timespec32 __user *, u_abs_timeout)
  1751	{
  1752		struct mq_timedreceive2_args args, *pargs = NULL;
  1753	
  1754		pargs = &args;
  1755	
> 1756		if (get_compat_mq_args(pargs, uargs))
  1757			return -EFAULT;
  1758	
  1759		struct timespec64 ts, *p = NULL;
  1760	
  1761		if (u_abs_timeout) {
  1762			int res = compat_prepare_timeout(u_abs_timeout, &ts);
  1763			
  1764			if (res)
  1765				return res;
  1766			p = &ts;
  1767		}
  1768		return do_mq_timedreceive2(mqdes, pargs, flags, index, p);
  1769	}
  1770	#endif
  1771	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
