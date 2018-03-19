Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:60064 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933034AbeCSPVJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Mar 2018 11:21:09 -0400
Subject: Re: [PATCH v12 00/11] Application Data Integrity feature introduced
 by SPARC M7
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <20180318.110857.1660518649370410007.davem@davemloft.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <b9507686-6c3f-7fb1-b305-c1817f86a884@oracle.com>
Date: Mon, 19 Mar 2018 09:19:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180318.110857.1660518649370410007.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: dave.hansen@linux.intel.com, aarcange@redhat.com, akpm@linux-foundation.org, allen.pais@oracle.com, aneesh.kumar@linux.vnet.ibm.com, anthony.yznaga@oracle.com, arnd@arndb.de, benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com, corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com, david.j.aldridge@oracle.com, dwindsor@gmail.com, ebiederm@xmission.com, elena.reshetova@intel.com, gregkh@linuxfoundation.org, hannes@cmpxchg.org, henry.willard@oracle.com, hpa@zytor.com, hughd@google.com, imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com, jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de, khalid@gonehiking.org, khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org, ktkhai@virtuozzo.com, liam.merwick@oracle.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com, linux@roeck-us.net, me@tobin.cc, mgorman@suse.de, mgorman@techsingularity.net, mhocko@suse.com, mike.kravetz@oracle.com, minchan@kernel.org, mingo@kernel.org
Message-ID: <20180319151921.0MuWR_AiQOsDLMaToa7trDajrZJYMse7Qp8D4LAoY_I@z>

On 03/18/2018 09:08 AM, David Miller wrote:
> In uapi/asm/auxvec.h you conditionalize the ADI aux vectors on
> CONFIG_SPARC64.
> 
> That's not correct, you should never control user facing definitions
> based upon kernel configuration.
> 
> Also, both 32-bit and 64-bit applications running on ADI capable
> machines want to compile against and use this informaiton.
> 
> So please remove these CPP checks.
> 

Hi Dave,

That makes sense. I will send a patch to remove these.

Thanks,
Khalid
