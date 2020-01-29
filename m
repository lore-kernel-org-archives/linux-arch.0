From: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Wed, 29 Jan 2020 15:26:35 +0530
Message-ID: <3c7b6d98-da08-29c7-cd5b-39d2903b24a2@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
 <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
 <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbgA2J4q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 04:56:46 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00T9sVZl045925
        for <linux-arch@vger.kernel.org>; Wed, 29 Jan 2020 04:56:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtmmx5g8c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 29 Jan 2020 04:56:45 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 29 Jan 2020 09:56:43 -0000
In-Reply-To: <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

Hi Dave,

On 28/01/20 3:08 pm, Sandipan Das wrote:
> On 27/01/20 9:12 pm, Dave Hansen wrote:
>>
>> How have you tested this patch (and the whole series for that matter)?
>>
> 
> I replaced the second patch with this one and did a build test.
> Till v16, I had tested the whole series (build + run) on both a POWER8
> system (with 4K and 64K page sizes) and a Skylake SP system but for
> x86_64 only. Following that, I could only do a build test locally on
> my laptop for i386 and x86_64 on my laptop as I did not have access to
> the Skylake system anymore.
> 
> 

I got a chance to use the Skylake system today and tested (build + run)
the whole series (v17 with the fixed Makefile) for both i386 and x86_64.
Everything passed.

- Sandipan
