Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF31C862D;
	Fri,  7 Aug 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093337; cv=none; b=lt1heNXBGsqA4qqEzTA19QR5ZSKbYA9TSJyMF4h5FHyrxbFFf+ZCX8y3RVM6nRFvp1zXuhJWY4HORuA6UN5Bsdr2Q71Q74C7jeOcRbGFh8RGrgBUqgraRuW0nZ+LXhDorTZuYVGyhws7gyIcezQmcdJnk3BdCLfRjDLCeA7I7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093337; c=relaxed/simple;
	bh=sggpEOSlt83QlKX+P08uHCxVzo+8f0TtRZbePVvRyQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tweRaZxqzPyRLXYi7naLAiDh2KBl43iGrblV/v1NFUwBUmSr8hoWBSEBb7SyqeqWIMKBPdU669ltSkdkqBpXw3JCdvbED8VakH4dHHUtLS+hvNTPtS9UmTPiUmbA/KDBofFlrAPQ0IOtEJQsQ8dITA3++Pg3AAtbNwS9alszF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nvwfge11; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvwfge11"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y9cnlC2dp3VmcpnNa4wM8w/p9cBdLSky0AypW3l6X6I=; b=nvwfge11uAwfXgONkQ+ohJviDm
	sHDqcQ4y4Za/DhxroWC79jhum4BoMmCcBI/EO0ba9BKshXkVei+DQ2iLzpm1j70Nz/bfHsQkAu3o8
	Lhu1Q/ApCXf1hXexw5ZQmJJV/CumXUyy51+r20pCBfMYKKjFuEQlQ4vYqqILkeE30jes1ZI+OCOhF
	V70Te2/PD4FE1e7ip9nBgjLW2u243oIMsoFfp0rNnGtfOJENLgXFm6ugPiXomeZaUQ4LD0e6HGATu
	eFa9cGJTC+cHbJQ8G0wslrT+f6GKMHf5e8zNKhKHbW3Hxh68EuNocIMN0e2ZYm9bvQehkBUyLSRdr
	pTCqFejQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsGSw-0000000CE8h-2gNL;
	Fri, 07 Aug 2026 09:02:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D472C302DFD; Fri, 07 Aug 2026 11:01:39 +0200 (CEST)
Date: Fri, 7 Aug 2026 11:01:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>, sj@kernel.org
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arch@vger.kernel.org
Subject: Re: [tip:locking/core] [futex]  b78b0b6582:
 kselftests.damon.sysfs_memcg_path_leak.sh.fail
Message-ID: <20260807090139.GR776954@noisy.programming.kicks-ass.net>
References: <202608071053.6db6276e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202608071053.6db6276e-lkp@intel.com>

On Fri, Aug 07, 2026 at 04:50:48PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kselftests.damon.sysfs_memcg_path_leak.sh.fail" on:
> 
> commit: b78b0b65825275f58336a43611a700de174be8c3 ("futex: Use runtime constants for __futex_hash() hot path")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/core
> 
> 
> in testcase: kselftests
> version: kselftests-x86_64-f5098b6bae76-1_20260727
> with following parameters:
> 
> 	group: damon
> 
> 
> 
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202608071053.6db6276e-lkp@intel.com
> 
> 
> # timeout set to 300
> # selftests: damon: sysfs_memcg_path_leak.sh
> # unreferenced object 0xffff8881029e0ab8 (size 8):
> #   comm "swapper/0", pid 1, jiffies 4294668108
> #   hex dump (first 8 bytes):
> #     00 00 d0 02 81 88 ff ff                          ........
> #   backtrace (crc 6c1bc6d6):
> #     __kmalloc_noprof+0x56b/0x830
> #     futex_init+0x108/0x3c0
> #     do_one_initcall+0xc3/0x4b0
> #     do_initcalls+0x215/0x240
> #     kernel_init_freeable+0x4a1/0x530
> #     kernel_init+0x18/0x180
> #     ret_from_fork+0x547/0x870
> #     ret_from_fork_asm+0x1a/0x30
> not ok 13 selftests: damon: sysfs_memcg_path_leak.sh # exit=1

I have no idea what DAMON does or what this selftest is on about. SJ?
