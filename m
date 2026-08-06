Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC403A9D8D;
	Thu,  6 Aug 2026 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982567; cv=none; b=fOaWzPAXWYsUQfjJdPghxT3fH1Se1MNhaRvmdW8ozd3IXLS0t0jlqwMS6NmNdodkEApBld9KFEIR1Kp2VqJir7LekKViV9qk2HUtxEmOFFkJMobAWWLfAf17aHGeVeAZ+Ze1cF7jPF8Fqa0FsX7GRlUngqerK4g3B4KfL38ewQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982567; c=relaxed/simple;
	bh=ii6BnmI3u2e2Ts9Te7XbGolgJuvo1wcTB1wefhdS7hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwuWBasYHZ0Nl6n6ArIKp2sEnC/FlTF+B89DjCcoaGm0CFmU8JEe+whRf2a6Zte0DQI9BuLRnbW0/qsMeGJTnbJzn7RTMr55tVUJuWAv6wD0KKHZ+hnT46SjbYnsRejCSVNPx4GAhz6V7Q4EIB2gPWXaQ+/R7DeAAqAWvRZZ9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9GCLU/R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9GCLU/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982566; x=1817518566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ii6BnmI3u2e2Ts9Te7XbGolgJuvo1wcTB1wefhdS7hU=;
  b=W9GCLU/R+sxLqRZAB5Lpc5R/g/3rYEip7+vfxe0Z9zjDnZ2TgWHfl7A0
   yc9xc3cYuSJ14RycOa/QHnCysZOrEPsAzBSoFAhuA6sJPYl4A5eJJ/J04
   I5sDOWmZk7w24hX4F71Tl+iJveVegAcrZTuesxB7Hd6DJZF3TnfUhBK/t
   vQkMYioGt9/UwE6cw/WFnbw2VBnFs5gIMFq1638Nf7qGiUZdAPpl56CB2
   DITHm0UfIj/kHGsdbxPV3lsQ/OeAbmeTRT1Hh+BExGTkE05yAiUWWVljo
   rPLI00AOPKoc9ko5cABYtKHI9Uz91eThF3p5jau5EKBHXBQpq+NVte3RS
   g==;
X-CSE-ConnectionGUID: Fn/GAaxYQ0G4n+sUhdy12Q==
X-CSE-MsgGUID: 7loO/4RWSFKAIaF5BTTOqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90452802"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="90452802"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:16:05 -0700
X-CSE-ConnectionGUID: z+EFbCglSZCfoFnaJH7/ow==
X-CSE-MsgGUID: U/7fcUptSGup3rPW0pcMDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="267107977"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Aug 2026 19:16:01 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrneH-00000000DwD-3RtN;
	Thu, 06 Aug 2026 02:15:57 +0000
Date: Thu, 6 Aug 2026 10:15:24 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, arnd@arndb.de, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	peterz@infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mhiramat@kernel.org, atomlin@atomlin.com, neelx@suse.com,
	da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com,
	steve@abita.co, mproche@mail.com, nick.lane@mail.com,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <202608060957.II0PSh3B-lkp@intel.com>
References: <20260622140259.2974-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622140259.2974-1-atomlin@atomlin.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master arnd-asm-generic/master v7.2-rc6 next-20260805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/module-Extend-module_blacklist-parameter-to-built-in-modules/20260805-123559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20260622140259.2974-1-atomlin%40atomlin.com
patch subject: [PATCH v2] module: Extend module_blacklist parameter to built-in modules
config: powerpc64-randconfig-002-20260806 (https://download.01.org/0day-ci/archive/20260806/202608060957.II0PSh3B-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608060957.II0PSh3B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608060957.II0PSh3B-lkp@intel.com/

All errors (new ones prefixed by >>):

>> init/main.c:1364:17: error: call to undeclared function 'module_is_blacklisted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1364 |         if (modname && module_is_blacklisted(modname)) {
         |                        ^
   1 error generated.


vim +/module_is_blacklisted +1364 init/main.c

  1355	
  1356	int __init_or_module do_one_initcall(initcall_t fn)
  1357	{
  1358		int count = preempt_count();
  1359		char msgbuf[64];
  1360		const char *modname;
  1361		int ret;
  1362	
  1363		modname = initcall_get_modname(fn);
> 1364		if (modname && module_is_blacklisted(modname)) {
  1365			pr_info("Skipping initcall for blacklisted built-in module %s\n",
  1366				modname);
  1367			return 0;
  1368		}
  1369	
  1370		if (initcall_blacklisted(fn))
  1371			return -EPERM;
  1372	
  1373		do_trace_initcall_start(fn);
  1374		ret = fn();
  1375		do_trace_initcall_finish(fn, ret);
  1376	
  1377		msgbuf[0] = 0;
  1378	
  1379		if (preempt_count() != count) {
  1380			sprintf(msgbuf, "preemption imbalance ");
  1381			preempt_count_set(count);
  1382		}
  1383		if (irqs_disabled()) {
  1384			strlcat(msgbuf, "disabled interrupts ", sizeof(msgbuf));
  1385			local_irq_enable();
  1386		}
  1387		WARN(msgbuf[0], "initcall %pS returned with %s\n", fn, msgbuf);
  1388	
  1389		add_latent_entropy();
  1390		return ret;
  1391	}
  1392	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
