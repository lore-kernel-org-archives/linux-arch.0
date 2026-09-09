Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909472E229F;
	Wed,  9 Sep 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917715; cv=none; b=VW2vlhvc8txTeq0+9+prMnG/JVevkjaT2LvJfsKnZAN6BWeYGpAtIpQgmqW/HoLfB6WQaVxn5wJCJknlu0LxFzANaCzmqmy5OZYyJzBaIp7ntyn9VabCXWjY9GleTosWiDrgLxCd2LnclyDPUwDxmFwrFNRYWEDTiGAb0Sd7Cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917715; c=relaxed/simple;
	bh=o39w0mFHR1dYfyksC/IVqr8MfutQWQkeUgU4kvt0uDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXsihih8fH0Y5W5MJ7ZrSD+uwgZ+NGR5EGWFWDpcJBoM5ty+s1uLC5ph7A/TxRcumLao2x+X9pQgj7HkDInS5j1HWGsaXMPXVujux6sCjO8BQ3c8wnnqOjaN5LTOIPjS2NsvMMaYYZU3ZjCTLSUvS76GnC4gbhZ2UNi1pkpzhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/Pw4iIx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/Pw4iIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788917713; x=1820453713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o39w0mFHR1dYfyksC/IVqr8MfutQWQkeUgU4kvt0uDA=;
  b=m/Pw4iIxBd1DW2tY0doZlbwq+3dkeMEWZcYNJR+J0uFfqHMjOvRv+sWw
   3up2T4tfmlOEQCdaXt9kU9rgEuzPAn8iAX52PQ558OJSe3vsDMMHVUrqE
   GlOnAy8ANEJv9LEP9hF7DleTV0ISHSZZB8v8RNIyaMdfeOrzXjxJv8COP
   4AqZCgmzyaYOJcrLhtef8OBgb3bYWJo/fyBw1SyK1qo8sd5B02LiPiTR9
   3SsWlX6NCfmhabKEnBnbuZayOo3OkzhlPepJOELSAabx+uB+dQEiFwP3C
   8TadtnQFuE0FqYnnQEIiXBRKFFvGARn7dUiaadE5OCYMlbez0+vQAZOyu
   g==;
X-CSE-ConnectionGUID: NuGjBzvBSw+cR9SAQ38t1A==
X-CSE-MsgGUID: T1GYcxx5Q+iW/2C2fYGUgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89091936"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89091936"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:35:12 -0700
X-CSE-ConnectionGUID: DKqSixrxSgaSHwGK+Mijlw==
X-CSE-MsgGUID: 1KPB/RUgRyqkCwx56iWLeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="275304859"
Received: from igk-lkp-server01.igk.intel.com (HELO cc074f2a4298) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 18:35:08 -0700
Received: from kbuild by cc074f2a4298 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x47DN-0000000010M-0ZPg;
	Wed, 09 Sep 2026 01:35:05 +0000
Date: Wed, 9 Sep 2026 03:35:01 +0200
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, arnd@arndb.de, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	peterz@infradead.org, ojeda@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, mhiramat@kernel.org, boqun@kernel.org,
	atomlin@atomlin.com, neelx@suse.com, da.anzani@gmail.com,
	sean@ashe.io, chjohnst@mail.com, steve@abita.co, mproche@mail.com,
	nick.lane@mail.com, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] module: Rename module_blacklist to
 module_denylist
Message-ID: <202609090311.bhj7AUr7-lkp@intel.com>
References: <20260903185557.183224-3-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903185557.183224-3-atomlin@atomlin.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on soc/for-next linus/master v7.3-rc2 next-20260908]
[cannot apply to arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/module-Extend-module_blacklist-parameter-to-built-in-modules/20260903-145556
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20260903185557.183224-3-atomlin%40atomlin.com
patch subject: [PATCH v10 2/2] module: Rename module_blacklist to module_denylist
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260909/202609090311.bhj7AUr7-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260909/202609090311.bhj7AUr7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609090311.bhj7AUr7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find type `initcall_modname` in crate `::kernel::bindings`
   --> rust/doctests_kernel_generated.rs:7459:1
   |
   7459 | / module! {
   7460 | |    type: MyModule,
   7461 | |    name: "module_firmware_test",
   7462 | |    authors: ["Rust for Linux"],
   7463 | |    description: "module_firmware! test module",
   7464 | |    license: "GPL",
   7465 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0422]: cannot find struct, variant or union type `initcall_modname` in crate `::kernel::bindings`
   --> rust/doctests_kernel_generated.rs:7459:1
   |
   7459 | / module! {
   7460 | |    type: MyModule,
   7461 | |    name: "module_firmware_test",
   7462 | |    authors: ["Rust for Linux"],
   7463 | |    description: "module_firmware! test module",
   7464 | |    license: "GPL",
   7465 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find type `initcall_modname` in crate `::kernel::bindings`
   --> rust/doctests_kernel_generated.rs:12739:1
   |
   12739 | / kernel::module_phy_driver! {
   12740 | |     drivers: [PhySample],
   12741 | |     device_table: [
   12742 | |         DeviceId::new_with_driver::<PhySample>()
   ...     |
   12747 | |     license: "GPL",
   12748 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `$crate::prelude::module` which comes from the expansion of the macro `kernel::module_phy_driver` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0422]: cannot find struct, variant or union type `initcall_modname` in crate `::kernel::bindings`
   --> rust/doctests_kernel_generated.rs:12739:1
   |
   12739 | / kernel::module_phy_driver! {
   12740 | |     drivers: [PhySample],
   12741 | |     device_table: [
   12742 | |         DeviceId::new_with_driver::<PhySample>()
   ...     |
   12747 | |     license: "GPL",
   12748 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `$crate::prelude::module` which comes from the expansion of the macro `kernel::module_phy_driver` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find type `initcall_modname` in crate `::kernel::bindings`
   --> samples/rust/rust_minimal.rs:7:1
   |
   7 | / module! {
   8 | |     type: RustMinimal,
   9 | |     name: "rust_minimal",
   10 | |     authors: ["Rust for Linux Contributors"],
   ...  |
   22 | |     },
   23 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0422]: cannot find struct, variant or union type `initcall_modname` in crate `::kernel::bindings`
   --> samples/rust/rust_minimal.rs:7:1
   |
   7 | / module! {
   8 | |     type: RustMinimal,
   9 | |     name: "rust_minimal",
   10 | |     authors: ["Rust for Linux Contributors"],
   ...  |
   22 | |     },
   23 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find type `initcall_modname` in crate `::kernel::bindings`
   --> samples/rust/rust_misc_device.rs:136:1
   |
   136 | / module! {
   137 | |     type: RustMiscDeviceModule,
   138 | |     name: "rust_misc_device",
   139 | |     authors: ["Lee Jones"],
   140 | |     description: "Rust misc device sample",
   141 | |     license: "GPL",
   142 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0422]: cannot find struct, variant or union type `initcall_modname` in crate `::kernel::bindings`
   --> samples/rust/rust_misc_device.rs:136:1
   |
   136 | / module! {
   137 | |     type: RustMiscDeviceModule,
   138 | |     name: "rust_misc_device",
   139 | |     authors: ["Lee Jones"],
   140 | |     description: "Rust misc device sample",
   141 | |     license: "GPL",
   142 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find type `initcall_modname` in crate `::kernel::bindings`
   --> samples/rust/rust_print_main.rs:8:1
   |
   8 | / module! {
   9 | |     type: RustPrint,
   10 | |     name: "rust_print",
   11 | |     authors: ["Rust for Linux Contributors"],
   12 | |     description: "Rust printing macros sample",
   13 | |     license: "GPL",
   14 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0422]: cannot find struct, variant or union type `initcall_modname` in crate `::kernel::bindings`
   --> samples/rust/rust_print_main.rs:8:1
   |
   8 | / module! {
   9 | |     type: RustPrint,
   10 | |     name: "rust_print",
   11 | |     authors: ["Rust for Linux Contributors"],
   12 | |     description: "Rust printing macros sample",
   13 | |     license: "GPL",
   14 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `module` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find type `initcall_modname` in crate `::kernel::bindings`
   --> samples/rust/rust_debugfs.rs:58:1
   |
   58 | / kernel::module_platform_driver! {
   59 | |     type: RustDebugFs,
   60 | |     name: "rust_debugfs",
   61 | |     authors: ["Matthew Maurer"],
   62 | |     description: "Rust DebugFS usage sample",
   63 | |     license: "GPL",
   64 | | }
   | |_^ not found in `::kernel::bindings`
   |
   = note: this error originates in the macro `$crate::prelude::module` which comes from the expansion of the macro `kernel::module_platform_driver` (in Nightly builds, run with -Z macro-backtrace for more info)
..

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
