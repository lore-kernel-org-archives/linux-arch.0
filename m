Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46430 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754818AbdESQhh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2017 12:37:37 -0400
Subject: Re: [PATCH 6/6] arch/sparc: Enable queued spinlock support for SPARC
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
 <1495154170-854693-7-git-send-email-babu.moger@oracle.com>
 <20170518.223220.105988940116687879.davem@davemloft.net>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <8e402c6d-7912-afb0-7be7-76dd9b06cf57@oracle.com>
Date: Fri, 19 May 2017 11:37:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170518.223220.105988940116687879.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170519163706.4T-toUtffw_XXx2L7H3_-5pWLFucNFept7tUqIXpY0Q@z>


On 5/18/2017 9:32 PM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Thu, 18 May 2017 18:36:10 -0600
>
>> @@ -83,6 +83,7 @@ config SPARC64
>>   	select ARCH_SUPPORTS_ATOMIC_RMW
>>   	select HAVE_NMI
>>   	select ARCH_USE_QUEUED_RWLOCKS
>> +	select ARCH_USE_QUEUED_SPINLOCKS
>>   
>>   config ARCH_DEFCONFIG
>>   	string
> Like the queued spinlock enabling patch, if this will be on
> all the time for SPARC64 then:
>
>> diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/spinlock_64.h
>> index 562dbd8..e2044e3 100644
>> --- a/arch/sparc/include/asm/spinlock_64.h
>> +++ b/arch/sparc/include/asm/spinlock_64.h
>> @@ -11,6 +11,9 @@
>>   #include <asm/processor.h>
>>   #include <asm/barrier.h>
>>   
>> +#ifdef CONFIG_QUEUED_SPINLOCKS
>> +#include <asm/qspinlock.h>
>> +#else
> This ifdef doesn't make any sense, by definition it will always be on.

Ok. Will do. thanks
