From: Babu Moger <babu.moger@oracle.com>
Subject: Re: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
Date: Fri, 19 May 2017 11:36:19 -0500
Message-ID: <4f6735d6-ceb4-bfdd-5c98-58bef04d6566@oracle.com>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
 <1495154170-854693-5-git-send-email-babu.moger@oracle.com>
 <20170518.223113.1783186374793423172.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46118 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdESQgu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2017 12:36:50 -0400
In-Reply-To: <20170518.223113.1783186374793423172.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


On 5/18/2017 9:31 PM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Thu, 18 May 2017 18:36:08 -0600
>
>> @@ -82,6 +82,7 @@ config SPARC64
>>   	select HAVE_ARCH_AUDITSYSCALL
>>   	select ARCH_SUPPORTS_ATOMIC_RMW
>>   	select HAVE_NMI
>> +	select ARCH_USE_QUEUED_RWLOCKS
>>   
> If you are selecting this on SPARC64 all the time, then:
>
>> @@ -94,6 +94,7 @@ static inline void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long fla
>>   	: "memory");
>>   }
>>   
>> +#ifndef CONFIG_QUEUED_RWLOCKS
>>   /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
> You can remove this segment of ifdef'd code altogether since it is in
> a sparc64 specific header file.

Sure. will do.
