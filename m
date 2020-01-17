From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Fri, 17 Jan 2020 10:02:35 -0800
Message-ID: <3a14815c-b9cb-f5a5-630a-0bfb25356429@intel.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:29688 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQSCg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 13:02:36 -0500
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

On 1/17/20 4:49 AM, Sandipan Das wrote:
> Memory protection keys enables an application to protect its address
> space from inadvertent access by its own code.
> 
> This feature is now enabled on powerpc and has been available since
> 4.16-rc1. The patches move the selftests to arch neutral directory
> and enhance their test coverage.
> 
> Tested on powerpc64 and x86_64 (Skylake-SP).
I also tested the series.  The 64-bit binary works fine.  But,

This is failing to build the x86 selftests:

make: *** No rule to make target 'protection_keys.c', needed by
'/home/daveh/linux/tools/testing/selftests/x86/protection_keys_32'.  Stop.

I think you just forgot to remove the binary from the x86 Makefile.

Which reminds me: This removes the 32-bit binary.  x86 32-bit binaries
exercise different paths than the 64-bit ones, so we like to have both.
 Although it isn't *essential* it would really be nice to keep the
32-bit binary.
