Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D537F8BD;
	Fri,  6 Mar 2026 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793480; cv=none; b=aK7UsdvzpihAXCvdK3b8C0riiTwEiqrkBvtun2x4p/bDJu1DSWnLMRW/paQCzTCtlijK2JlZV1a4KKtw2zkPMX/UhlOet0uXxUMr2rabFMAFfhhg9Gm9WmdWcGm2dbTn6CdTY7i2N6eJy88GSIWYzDKaQJpxaaG5WBqd9ovpkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793480; c=relaxed/simple;
	bh=XMCQCXBJXKgPkb5u1PYenb+skJrk1hZvPj9ZE49uSzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOjF+nBSyofXUKxA8EomAO1cnYVaOFLQBc5Bf44A0b4+R40Gtq7DvXu72WG8CUYQ5EOWqjGayUhMHUOnuaWiQ+f2vhEYf851iEWAmjMAWMI6XTTwuiD6H2QodEyljUuQ6a73GYsiZrZo0SixsXIe7ffXsqL+Va6k6nS8nxRWWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLl5rdVc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLl5rdVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772793479; x=1804329479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XMCQCXBJXKgPkb5u1PYenb+skJrk1hZvPj9ZE49uSzQ=;
  b=cLl5rdVcvYRIK1GSXPquag05InKuorzNRAjTgLN5MRbnYpCIcIGPSzkU
   ICheZUTKYT2Xp9oGu8lLDFSsXzYr6mAE43U5NWPZwkG7c70d7abjYfpUQ
   VtbqAki8T3JfS6NrNwo1vTpdqoyShIo+betzlilUhQUy8f2H3rFGvGyah
   yCz1BkUzopW7CLed8jNlD6vAf76/iAEPVRg8hkgmHSJ4rSisJNsN23ezl
   UCpy9j6AZpT6L137tsD74TC+Rv4ohV7B51W1mfAW63PiLBt2YbFwDcwzm
   imoiOZbk6/yvwiCDZNpJkwqg8eyvQbGx5RpwiNoJeFOvbLEDbTXmk7GOK
   w==;
X-CSE-ConnectionGUID: 0ykTcEOPTK2TyOct/tzOmA==
X-CSE-MsgGUID: 3ZyEwNDsTxCRRCZECtRldA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73801269"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73801269"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 02:37:58 -0800
X-CSE-ConnectionGUID: Ln9pi8tXTAu7u6pH5e6hTA==
X-CSE-MsgGUID: Eie0sDR/R62UEGdyu41cRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223456487"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 06 Mar 2026 02:37:56 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vySZ7-000000002Ef-3WoH;
	Fri, 06 Mar 2026 10:37:53 +0000
Date: Fri, 6 Mar 2026 11:36:56 +0100
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] mqueue: introduce new do_mq_timedreceive2() [ mq_peek
 syscall] for non-destructive receive and inspection,fix minor issue,prepared
 doc.
Message-ID: <202603061141.ryqSrkfy-lkp@intel.com>
References: <20260305180942.913686-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305180942.913686-1-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes brauner-vfs/vfs.all next-20260305]
[cannot apply to linus/master tip/x86/asm v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection-fix-minor-issue-prep/20260306-065614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260305180942.913686-1-academic1mathura%40gmail.com
patch subject: [PATCH] mqueue: introduce new do_mq_timedreceive2() [ mq_peek syscall] for non-destructive receive and inspection,fix minor issue,prepared doc.
config: x86_64-rhel-9.4-func (https://download.01.org/0day-ci/archive/20260306/202603061141.ryqSrkfy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603061141.ryqSrkfy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603061141.ryqSrkfy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   ipc/mqueue.c:1748:24: warning: 'struct compat_mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:617:63: note: in definition of macro '__same_type'
     617 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/syscalls.h:131:26: note: in expansion of macro '__TYPE_AS'
     131 | #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
         |                          ^~~~~~~~~
   include/linux/syscalls.h:132:56: note: in expansion of macro '__TYPE_IS_LL'
     132 | #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
         |                                                        ^~~~~~~~~~~~
   include/linux/syscalls.h:122:27: note: in expansion of macro '__SC_LONG'
     122 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                           ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
     123 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
     125 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   arch/x86/include/asm/syscall_wrapper.h:224:36: note: in expansion of macro '__MAP'
     224 |         static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));     \
         |                                    ^~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   In file included from ipc/mqueue.c:29:
   ipc/mqueue.c:1748:24: warning: 'struct compat_mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:127:25: note: in definition of macro '__SC_DECL'
     127 | #define __SC_DECL(t, a) t a
         |                         ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
     123 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
     125 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   arch/x86/include/asm/syscall_wrapper.h:225:43: note: in expansion of macro '__MAP'
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                                           ^~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1748:24: warning: 'struct compat_mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:617:63: note: in definition of macro '__same_type'
     617 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/syscalls.h:131:26: note: in expansion of macro '__TYPE_AS'
     131 | #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
         |                          ^~~~~~~~~
   include/linux/syscalls.h:132:56: note: in expansion of macro '__TYPE_IS_LL'
     132 | #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
         |                                                        ^~~~~~~~~~~~
   include/linux/syscalls.h:122:27: note: in expansion of macro '__SC_LONG'
     122 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                           ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
     123 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
     125 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   arch/x86/include/asm/syscall_wrapper.h:228:36: note: in expansion of macro '__MAP'
     228 |         static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))      \
         |                                    ^~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c: In function '__se_sys_mq_timedreceive2_time32':
>> include/linux/syscalls.h:133:25: error: passing argument 2 of '__do_sys_mq_timedreceive2_time32' from incompatible pointer type [-Wincompatible-pointer-types]
     133 | #define __SC_CAST(t, a) (__force t) a
   include/linux/syscalls.h:122:27: note: in expansion of macro '__SC_CAST'
     122 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                           ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
     123 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
     125 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   arch/x86/include/asm/syscall_wrapper.h:230:43: note: in expansion of macro '__MAP'
     230 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
         |                                           ^~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1748:63: note: expected 'struct compat_mq_timedreceive2_args *' but argument is of type 'struct compat_mq_timedreceive2_args *'
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   include/linux/syscalls.h:127:27: note: in definition of macro '__SC_DECL'
     127 | #define __SC_DECL(t, a) t a
         |                           ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
     123 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
     125 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   arch/x86/include/asm/syscall_wrapper.h:225:43: note: in expansion of macro '__MAP'
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                                           ^~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c: At top level:
   ipc/mqueue.c:1748:24: warning: 'struct compat_mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
    1748 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:127:25: note: in definition of macro '__SC_DECL'
     127 | #define __SC_DECL(t, a) t a
         |                         ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
     123 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
     125 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   arch/x86/include/asm/syscall_wrapper.h:235:43: note: in expansion of macro '__MAP'
     235 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                                           ^~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   In file included from include/linux/compat.h:34,
                    from include/net/compat.h:8,
                    from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from ipc/mqueue.c:28:
>> arch/x86/include/asm/syscall_wrapper.h:235:28: error: conflicting types for '__do_sys_mq_timedreceive2_time32'; have 'long int(mqd_t,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)' {aka 'long int(int,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)'}
     235 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:225:28: note: previous declaration of '__do_sys_mq_timedreceive2_time32' with type 'long int(mqd_t,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)' {aka 'long int(int,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)'}
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c: In function '__do_sys_mq_timedreceive2_time32':
>> ipc/mqueue.c:1756:13: error: implicit declaration of function 'get_compat_mq_args'; did you mean 'get_compat_msghdr'? [-Wimplicit-function-declaration]
    1756 |         if (get_compat_mq_args(pargs, uargs))
         |             ^~~~~~~~~~~~~~~~~~
         |             get_compat_msghdr
   ipc/mqueue.c: At top level:
   arch/x86/include/asm/syscall_wrapper.h:225:28: warning: '__do_sys_mq_timedreceive2_time32' used but never defined
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     230 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1747 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~


vim +/__do_sys_mq_timedreceive2_time32 +133 include/linux/syscalls.h

07fe6e00f6cca6f Al Viro            2013-01-21  126  
07fe6e00f6cca6f Al Viro            2013-01-21  127  #define __SC_DECL(t, a)	t a
4f59c718521a0f0 Al Viro            2017-07-08  128  #define __TYPE_AS(t, v)	__same_type((__force t)0, v)
4f59c718521a0f0 Al Viro            2017-07-08  129  #define __TYPE_IS_L(t)	(__TYPE_AS(t, 0L))
4f59c718521a0f0 Al Viro            2017-07-08  130  #define __TYPE_IS_UL(t)	(__TYPE_AS(t, 0UL))
4f59c718521a0f0 Al Viro            2017-07-08  131  #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
4a0fd5bf0fd0795 Al Viro            2013-01-21  132  #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
4f59c718521a0f0 Al Viro            2017-07-08 @133  #define __SC_CAST(t, a)	(__force t) a
56062d60f117dcc Richard Palethorpe 2024-01-10  134  #define __SC_TYPE(t, a)	t
2cf0966683430b6 Al Viro            2013-01-21  135  #define __SC_ARGS(t, a)	a
4a0fd5bf0fd0795 Al Viro            2013-01-21  136  #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
1a94bc34768e463 Heiko Carstens     2009-01-14  137  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
