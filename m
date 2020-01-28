From: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Tue, 28 Jan 2020 15:08:06 +0530
Message-ID: <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
 <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgA1JiT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jan 2020 04:38:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S9aYKl068133
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 04:38:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrfejt223-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 04:38:17 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 28 Jan 2020 09:38:15 -0000
In-Reply-To: <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

Hi Dave,

On 27/01/20 9:12 pm, Dave Hansen wrote:
> 
> How have you tested this patch (and the whole series for that matter)?
> 

I replaced the second patch with this one and did a build test.
Till v16, I had tested the whole series (build + run) on both a POWER8
system (with 4K and 64K page sizes) and a Skylake SP system but for
x86_64 only. Following that, I could only do a build test locally on
my laptop for i386 and x86_64 on my laptop as I did not have access to
the Skylake system anymore.

This is how I tested the build process:

$ cd linux
$ make -C tools/testing/selftests
...
make[1]: Entering directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'
...
gcc -Wall -I ../../../../usr/include  -no-pie -m32  protection_keys.c -lrt -lrt -ldl -lm -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_32
gcc -Wall -I ../../../../usr/include  -no-pie -m64  protection_keys.c -lrt -lrt -ldl -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_64
...

$ make -C tools/testing/selftests clean
$ make -C tools/testing/selftests/vm
make: Entering directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'
make --no-builtin-rules ARCH=x86_64 -C ../../../.. headers_install
make[1]: Entering directory '/home/sandipan/.devel/linux'
  INSTALL ./usr/include
make[1]: Leaving directory '/home/sandipan/.devel/linux'
...
gcc -Wall -I ../../../../usr/include  -no-pie -m32  protection_keys.c -lrt -lrt -ldl -lm -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_32
gcc -Wall -I ../../../../usr/include  -no-pie -m64  protection_keys.c -lrt -lrt -ldl -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_64
...

$ make -C tools/testing/selftests/vm clean
$ make -C tools/testing/selftests/vm protection_keys
make: Entering directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'
gcc -Wall -I ../../../../usr/include  -no-pie -m32  protection_keys.c -lrt -lrt -ldl -lm -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_32
gcc -Wall -I ../../../../usr/include  -no-pie -m64  protection_keys.c -lrt -lrt -ldl -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_64
make: Leaving directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'

$ make -C tools/testing/selftests/vm clean
$ make -C tools/testing/selftests/vm protection_keys_32
make: Entering directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'
gcc -Wall -I ../../../../usr/include  -no-pie -m32  protection_keys.c -lrt -lrt -ldl -lm -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_32
make: Leaving directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'

$ make -C tools/testing/selftests/vm protection_keys_64
make: Entering directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'
gcc -Wall -I ../../../../usr/include  -no-pie -m64  protection_keys.c -lrt -lrt -ldl -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_64
make: Leaving directory '/home/sandipan/.devel/linux/tools/testing/selftests/vm'

$ make -C tools/testing/selftests/vm clean
$ cd tools/testing/selftests/vm
$ make
make --no-builtin-rules ARCH=x86_64 -C ../../../.. headers_install
make[1]: Entering directory '/home/sandipan/.devel/linux'
  INSTALL ./usr/include
make[1]: Leaving directory '/home/sandipan/.devel/linux'
...
gcc -Wall -I ../../../../usr/include  -no-pie -m32  protection_keys.c -lrt -lrt -ldl -lm -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_32
gcc -Wall -I ../../../../usr/include  -no-pie -m64  protection_keys.c -lrt -lrt -ldl -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_64
...

$ make clean
$ make protection_keys
gcc -Wall -I ../../../../usr/include  -no-pie -m32  protection_keys.c -lrt -lrt -ldl -lm -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_32
gcc -Wall -I ../../../../usr/include  -no-pie -m64  protection_keys.c -lrt -lrt -ldl -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_64

$ make clean
$ make protection_keys_32
gcc -Wall -I ../../../../usr/include  -no-pie -m32  protection_keys.c -lrt -lrt -ldl -lm -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_32

$ make protection_keys_64
gcc -Wall -I ../../../../usr/include  -no-pie -m64  protection_keys.c -lrt -lrt -ldl -o /home/sandipan/.devel/linux/tools/testing/selftests/vm/protection_keys_64


- Sandipan
