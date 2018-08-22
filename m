Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeHVXcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2018 19:32:33 -0400
Subject: Re: Alpha Avanti broken by 9ce8654323d69273b4977f76f11c9e2d345ab130
References: <alpine.LRH.2.02.1808161556450.13597@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808201740170.2948@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a1E2V-zFN5PpJ868L=6CgTykkyjtF6-aTsCCh6QqryUig@mail.gmail.com>
 <alpine.LRH.2.02.1808210814250.24287@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3vJK1caKpDqkEhMG=8n8N3U6ckqe=0f2fjUJwk-9K0XA@mail.gmail.com>
 <alpine.LRH.2.02.1808220743270.12730@file01.intranet.prod.int.rdu2.redhat.com>
 <21c0bd37-0ae7-db8f-76b8-6552c30faa4f@codeaurora.org>
 <alpine.LFD.2.21.1808221609000.26277@eddie.linux-mips.org>
 <alpine.LRH.2.02.1808221136480.18647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a20xrD3C2uGPm6dawp_02kbbZaocK5nTZLoUyeiaCkRgw@mail.gmail.com>
 <alpine.LRH.2.02.1808221336400.12083@file01.intranet.prod.int.rdu2.redhat.com>
 <09c561cf-541c-219a-f19b-4ecfaf9a0f02@codeaurora.org>
 <alpine.LRH.2.02.1808221545230.2965@file01.intranet.prod.int.rdu2.redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <89256c73-d8e5-3e8f-e796-9b2f1d2f9522@codeaurora.org>
Date: Wed, 22 Aug 2018 16:06:09 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808221545230.2965@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, okaya@kernel.org, Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On 8/22/2018 3:56 PM, Mikulas Patocka wrote:
> 
> 
> On Wed, 22 Aug 2018, Sinan Kaya wrote:
> 
>> On 8/22/2018 1:47 PM, Mikulas Patocka wrote:
>>> If ARM guarantees that the accesses to a given device are not reordered -
>>> then the barriers in readl and writel are superfluous.
>>
>> It is not. ARM only guarantees ordering of read/write transactions targeting
>> a device not memory.
>>
>> example:
>>
>> write memory
>> raw write to device
>>
>> or
>>
>> raw read from device
>> read memory
>>
>> these can bypass each other on ARM unless a barrier is placed in the right
>> place either via readl()/writel() or explicitly.
> 
> Yes - but - why does Linux insert the barriers into readl() and writel()
> instead of inserting them between accesses to registers and memory?
> 
> A lot of drivers have long sequences of accesses to memory-mapped
> registers with no interleaving accesses to coherent memory and these
> implicit barriers slow them down with no gain at all.

It is an abstraction issue. Majority of drivers are developed against x86
and the developers have no idea about the weakly ordered architecture
implications.

Now, Will Deacon added new primitives to address your concern. There are
new APIs as readl_relaxed() and writel_relaxed() as opposed to readl()
and writel().

Relaxed version still guarantee of register accesses with respect to each
other but no guaranteed with respect to memory. Relaxed versions could
be used in performance critical path.

> 
> Mikulas
> 
