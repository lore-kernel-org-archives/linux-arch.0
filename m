From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Wed, 22 Jan 2020 10:45:27 -0800
Message-ID: <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:4667 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVSp2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jan 2020 13:45:28 -0500
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

Still doesn't build for me:

> # make
> make --no-builtin-rules ARCH=x86_64 -C ../../../.. headers_install
> make[1]: Entering directory '/home/dave/linux.git'
>   INSTALL ./usr/include
> make[1]: Leaving directory '/home/dave/linux.git'
> make: *** No rule to make target '/home/dave/linux.git/tools/testing/selftests/vm/protection_keys_32', needed by 'all'.  Stop.
