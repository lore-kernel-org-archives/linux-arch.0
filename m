From: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Sat, 18 Jan 2020 14:54:51 +0530
Message-ID: <88abbb6b-8e07-43e5-231f-0e54edcad3f7@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
 <3a14815c-b9cb-f5a5-630a-0bfb25356429@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbgARJZH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Jan 2020 04:25:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00I9CZB7011370
        for <linux-arch@vger.kernel.org>; Sat, 18 Jan 2020 04:25:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkw7gjn13-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 18 Jan 2020 04:25:06 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Sat, 18 Jan 2020 09:25:04 -0000
In-Reply-To: <3a14815c-b9cb-f5a5-630a-0bfb25356429@intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org



On 17/01/20 11:32 pm, Dave Hansen wrote:
> I also tested the series.  The 64-bit binary works fine.  But,
> 
> This is failing to build the x86 selftests:
> 
> make: *** No rule to make target 'protection_keys.c', needed by
> '/home/daveh/linux/tools/testing/selftests/x86/protection_keys_32'.  Stop.
> 
> I think you just forgot to remove the binary from the x86 Makefile.
> 
> Which reminds me: This removes the 32-bit binary.  x86 32-bit binaries
> exercise different paths than the 64-bit ones, so we like to have both.
>  Although it isn't *essential* it would really be nice to keep the
> 32-bit binary.
> 

Oops. Let me fix that. Thanks for testing this.

- Sandipan
