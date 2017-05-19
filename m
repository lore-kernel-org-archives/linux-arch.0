From: Babu Moger <babu.moger@oracle.com>
Subject: Re: [PATCH 2/6] arch/sparc: Define config parameter CPU_BIG_ENDIAN
Date: Fri, 19 May 2017 11:26:26 -0500
Message-ID: <a73ea688-ea81-7423-0b71-c00fe1162cc4@oracle.com>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
 <1495154170-854693-3-git-send-email-babu.moger@oracle.com>
 <20170518.222629.750013339888739217.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41291 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdESQ1I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2017 12:27:08 -0400
In-Reply-To: <20170518.222629.750013339888739217.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


On 5/18/2017 9:26 PM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Thu, 18 May 2017 18:36:06 -0600
>
>> @@ -91,6 +91,10 @@ config ARCH_DEFCONFIG
>>   config ARCH_PROC_KCORE_TEXT
>>   	def_bool y
>>   
>> +config CPU_BIG_ENDIAN
>> +	bool
>> +	default y if SPARC64
>> +
> 32-bit sparc is big-endian too :-)
>
> So please don't use SPARC64 for the setting, use plain SPARC instead.

Ok. Sure. Will do.
