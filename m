Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84E3A0B01;
	Thu,  5 Mar 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714929; cv=none; b=EZW6eoICoVP4/HXN9GgdItmXrqdwIwvCgaorAiS4hSIe2ci/ikNiR3W2TM6iM6PvhfoBwt6YQFBCmdLG6Lt9wPAyYjFNrg8h1f7pIOuEGclptRgVdArt6WT7/KPdvzryeDSB9tBzLZ5GvdX8A6r0VovdyAVH3C1CYIwcQqZZRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714929; c=relaxed/simple;
	bh=moMV8HVJX7p9jmRdJK8ze+fOWbsQ1VQt5HqWB90F7VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbrmjYnz/2H3iFkBH6DPpCSR6L/RCjrDY4Xhh7Z48arMJIorZEWu7SbTWKgWruj1vUVOodJgs9C5qUyi2oWC+Migt+p9E31aex2J7YgNKLlLbWawThe/opwuC8mg8MSQpTyKpqlGXfHh+MJf3Mo6+3w/D8lY/nli+o0CB67AsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E37P6H+l; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E37P6H+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772714927; x=1804250927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=moMV8HVJX7p9jmRdJK8ze+fOWbsQ1VQt5HqWB90F7VE=;
  b=E37P6H+lfRoxbmdsZx8A7Rtn1Ku6cupITLi3dTKqRAEAcasw+25qYoh+
   Dv1aSUYV5C5bmymR2HgYcRyjcinUvnaFeBCpsjJNczL4KM/YEfnkmNFsZ
   T/xk+oU66qzlaxOQ3FF6KF/pMvSTm0KFo+SE2b3UNHc8goSJnRkQTGxjt
   yQqXd9P8tPwMEJRh7pi9hCnTn/buezCCZ1Id61udib0zOnbBbPGGu62Zd
   tOOLT6hRub5RSKITbplRsvZAsyeGF2HQMlsQwkvGCXWaSoDSnNjGpAm+u
   74y0+UWmTRX9lxENNbi/wiikMMLUhfPnFPL3Hz0fN3LoKs1Qjmq/nc/6P
   g==;
X-CSE-ConnectionGUID: P2An3MSbRv6Cn+fcPKLbww==
X-CSE-MsgGUID: /EpzAQhcTsWg0l2zTjsNXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72826372"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="72826372"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 04:48:46 -0800
X-CSE-ConnectionGUID: vhPSk0zeSMm+HfNAiAc++w==
X-CSE-MsgGUID: k6gZUd9oQ3asz6R9tmGFlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="249143099"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2026 04:48:44 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy889-000000001zl-1Rk7;
	Thu, 05 Mar 2026 12:48:41 +0000
Date: Thu, 5 Mar 2026 13:48:00 +0100
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] mqueue: introduce new do_mq_timedreceive2() [ mq_peek
 syscall] for non-destructive receive and inspection,fix minor issue,prepared
 doc.
Message-ID: <202603051326.wnlF51YD-lkp@intel.com>
References: <20260305065212.83213-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305065212.83213-1-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes brauner-vfs/vfs.all linus/master v7.0-rc2 next-20260304]
[cannot apply to tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection-fix-minor-issue-prep/20260305-145412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260305065212.83213-1-academic1mathura%40gmail.com
patch subject: [PATCH] mqueue: introduce new do_mq_timedreceive2() [ mq_peek syscall] for non-destructive receive and inspection,fix minor issue,prepared doc.
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260305/202603051326.wnlF51YD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051326.wnlF51YD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/landlock:526: ./include/uapi/linux/landlock.h:45: ERROR: Unknown target name: "network flags". [docutils]
   Documentation/userspace-api/landlock:526: ./include/uapi/linux/landlock.h:50: ERROR: Unknown target name: "scope flags". [docutils]
   Documentation/userspace-api/landlock:526: ./include/uapi/linux/landlock.h:24: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:535: ./include/uapi/linux/landlock.h:166: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:535: ./include/uapi/linux/landlock.h:189: ERROR: Unknown target name: "network flags". [docutils]
>> Documentation/userspace-api/syscall.rst:88: WARNING: Inline emphasis start-string without end-string. [docutils]
>> Documentation/userspace-api/syscall.rst:88: WARNING: Inline emphasis start-string without end-string. [docutils]
>> Documentation/userspace-api/syscall.rst:91: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
   Documentation/userspace-api/syscall.rst:94: WARNING: Inline emphasis start-string without end-string. [docutils]
   Documentation/userspace-api/syscall.rst:94: WARNING: Inline emphasis start-string without end-string. [docutils]
   Documentation/userspace-api/syscall.rst:110: ERROR: Unexpected indentation. [docutils]
>> Documentation/userspace-api/syscall.rst:111: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/userspace-api/syscall.rst:145: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
   Documentation/userspace-api/syscall.rst:181: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
>> Documentation/userspace-api/syscall.rst: WARNING: document isn't included in any toctree [toc.not_included]
   Documentation/networking/skbuff:36: ./include/linux/skbuff.h:181: WARNING: Failed to create a cross reference. A title or caption not found: 'crc' [ref.ref]


vim +88 Documentation/userspace-api/syscall.rst

    79	
    80	NAME
    81	        mq_timedreceive2 - receive or peek at a message from a
    82	        POSIX message queue
    83	
    84	SYNOPSIS
    85	        #include <mqueue.c>
    86	
    87	        struct mq_timedreceive2_args {
  > 88	                size_t         msg_len;
    89	                unsigned int  *msg_prio;
    90	                char          *msg_ptr;
  > 91	        };
    92	
    93	        ssize_t mq_timedreceive2(mqd_t mqdes,
    94	                                 struct mq_timedreceive2_args *uargs,
    95	                                 unsigned int flags,
    96	                                 unsigned long index,
    97	                                 const struct timespec *abs_timeout);
    98	
    99	        Note: As of now,no glibc wrapper exists for this syscall. Callers must
   100	        invoke it directly using syscall().
   101	
   102	DESCRIPTION
   103	        mq_timedreceive2() receives or peeks at a message from the
   104	        message queue referred to by the descriptor mqdes.
   105	
   106	        The uargs structure provides the message buffer parameters:
   107	
   108	          msg_ptr   userspace buffer to receive the message body
   109	          msg_len   size of msg_ptr in bytes, must be >= mq_msgsize
   110	                    of the queue
 > 111	          msg_prio  if not NULL, the priority of the received message
   112	                    is stored here
   113	
   114	        The flags argument controls receive behavior. The following
   115	        flags are defined:
   116	
   117	          MQ_PEEK
   118	                    Copy the message into msg_ptr without removing it
   119	                    from the queue. The queue is not modified. If this
   120	                    flag is not set, behavior is identical to
   121	                    mq_timedreceive() and the message is consumed.
   122	
   123	        The index argument selects which message to operate on within
   124	        the priority-ordered queue. index 0 refers to the highest
   125	        priority message. When MQ_PEEK is not set, index will be ignored but must be 0.
   126	
   127	        The abs_timeout argument specifies an absolute timeout. If
   128	        MQ_PEEK is set,this take control to peek path and so timeout 
   129	        will be ignored otherwise it will behave as mq_timedreceive().
   130	
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
