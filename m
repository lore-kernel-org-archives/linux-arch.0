From: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v18 00/24] selftests, powerpc, x86: Memory Protection Keys
Date: Mon, 2 Mar 2020 15:55:52 +0530
Message-ID: <a86a4a5b-9d44-efed-8bad-a18f108e2746@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
 <5887a858-b669-752e-b65e-ed7d7ded34aa@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbgCBK0F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 05:26:05 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022APDxv006611
        for <linux-arch@vger.kernel.org>; Mon, 2 Mar 2020 05:26:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfnbejvu0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 05:26:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Mon, 2 Mar 2020 10:26:01 -0000
In-Reply-To: <5887a858-b669-752e-b65e-ed7d7ded34aa@intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, skhan@linuxfoundation.org
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, akpm@linux-foundation.org

Hi Shuah,

On 31/01/20 3:21 am, Dave Hansen wrote:
> On 1/29/20 10:36 PM, Sandipan Das wrote:
>> v18:
>> 	(1) Fixed issues with x86 multilib builds based on
>> 	    feedback from Dave.
>> 	(2) Moved patch 2 to the end of the series.
> 
> These (finally) build and run successfully for me on an x86 system with
> protection keys.  Feel free to add my Tested-by, and Acked-by.
> 
> FWIW, I don't think look perfect, but my standards are lower for
> selftests/ than normal kernel code. :)
> 

Any updates on considering this for merging?

- Sandipan
