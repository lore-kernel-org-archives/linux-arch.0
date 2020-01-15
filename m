From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v15 23/23] selftests: vm: pkeys: Use the correct page size on powerpc
Date: Wed, 15 Jan 2020 17:07:36 +1000
Message-ID: <87h80x9ozr.fsf@mpe.ellerman.id.au>
References: <cover.1576645161.git.sandipan@linux.ibm.com> <ff7c288e2a88ccfb3b79be30967646fe5b869683.1576645161.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:50577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOHHg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 02:07:36 -0500
In-Reply-To: <ff7c288e2a88ccfb3b79be30967646fe5b869683.1576645161.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com

Sandipan Das <sandipan@linux.ibm.com> writes:
> Both 4K and 64K pages are supported on powerpc. Parts of
> the selftest code perform alignment computations based on
> the PAGE_SIZE macro which is currently hardcoded to 64K
> for powerpc. This causes some test failures on kernels
> configured with 4K page size.
>
> This problem is solved by determining the correct page
> size during the build process rather than hardcoding it
> in the header file.

Doing it at build time is wrong, the test could be built on a 4K system
and then run on a 64K system, or vice versa.

You should just use getpagesize() at runtime.

cheers

> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 4e9c741be6af..ada3a67eaac6 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -4,6 +4,10 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
>  
>  CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
> +ifneq (,$(filter $(ARCH), ppc64 ppc64le))
> +protection_keys: EXTRA_CFLAGS += -DPAGE_SIZE=$(shell getconf PAGESIZE)
> +endif
> +
>  LDLIBS = -lrt
>  TEST_GEN_FILES = compaction_test
>  TEST_GEN_FILES += gup_benchmark
> diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
> index 3cd8e03fd640..07fa9f529014 100644
> --- a/tools/testing/selftests/vm/pkey-powerpc.h
> +++ b/tools/testing/selftests/vm/pkey-powerpc.h
> @@ -36,7 +36,6 @@
>  					     pkey-31 and exec-only key */
>  #define PKEY_BITS_PER_PKEY	2
>  #define HPAGE_SIZE		(1UL << 24)
> -#define PAGE_SIZE		(1UL << 16)
>  #define pkey_reg_t		u64
>  #define PKEY_REG_FMT		"%016lx"
>  
> -- 
> 2.17.1
