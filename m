Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeEEEmk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 May 2018 00:42:40 -0400
Subject: Re: [PATCH v13 3/3] mm, powerpc, x86: introduce an additional vma bit
 for powerpc pkey
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
 <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
 <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
 <20180505011243.GB5617@ram.oc3035372033.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <7d1de723-f001-ebbe-6026-91bef88c566d@intel.com>
Date: Fri, 4 May 2018 21:42:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180505011243.GB5617@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de
Message-ID: <20180505044239.mFORGrJHada-DzOI98KiVmHxY3VHyHnmr9sfsPTfqnA@z>

On 05/04/2018 06:12 PM, Ram Pai wrote:
>> That new line boils down to:
>>
>> 		[ilog2(0)]	= "",
>>
>> on x86.  It wasn't *obvious* to me that it is OK to do that.  The other
>> possibly undefined bits (VM_SOFTDIRTY for instance) #ifdef themselves
>> out of this array.
>>
>> I would just be a wee bit worried that this would overwrite the 0 entry
>> ("??") with "".
> Yes it would :-( and could potentially break anything that depends on
> 0th entry being "??"
> 
> Is the following fix acceptable?
> 
> #if VM_PKEY_BIT4
>                 [ilog2(VM_PKEY_BIT4)]   = "",
> #endif

Yep, I think that works for me.
