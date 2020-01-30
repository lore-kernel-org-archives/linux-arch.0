From: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Thu, 30 Jan 2020 11:49:26 +0530
Message-ID: <26f630e5-1f70-888c-4b43-30e73c9f270c@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
 <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
 <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
 <ca6cfdeb-00f2-d926-e4e1-c1723cc25445@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgA3GTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:19:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6DlAV021062
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:19:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xuagnmdjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:19:37 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:19:35 -0000
In-Reply-To: <ca6cfdeb-00f2-d926-e4e1-c1723cc25445@intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

Hi Dave,

On 30/01/20 12:29 am, Dave Hansen wrote:
> On 1/28/20 1:38 AM, Sandipan Das wrote:
>> On 27/01/20 9:12 pm, Dave Hansen wrote:
>>> How have you tested this patch (and the whole series for that matter)?
>>>
>> I replaced the second patch with this one and did a build test.
>> Till v16, I had tested the whole series (build + run) on both a POWER8
>> system (with 4K and 64K page sizes) and a Skylake SP system but for
>> x86_64 only.
> 
> Do you have any idea why I was seeing x86 build errors and you were not?
> 

There were problems with patch 2 from v17. The fixed patch is what I replied
with previously in this thread. The test results that I posted were with that
patch included. Will post out v18 today with the fix.

- Sandipan
