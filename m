From: Mike Travis <travis@sgi.com>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Wed, 04 Jun 2008 07:58:12 -0700
Message-ID: <4846AD84.2090800@sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040011.084909898@sgi.com> <483F8AF7.9000309@cosmosbay.com> <Pine.LNX.4.64.0805292219220.12107@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:38996 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754079AbYFDO6O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Jun 2008 10:58:14 -0400
In-Reply-To: <Pine.LNX.4.64.0805292219220.12107@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

Christoph Lameter wrote:
> On Fri, 30 May 2008, Eric Dumazet wrote:
> 
>>> +static DEFINE_PER_CPU(UNIT_TYPE, area[UNITS]);
>>>   
>> area[] is not guaranteed to be aligned on anything but 4 bytes.
>>
>> If someone then needs to call cpu_alloc(8, GFP_KERNEL, 8), it might get an non
>> aligned result.
>>
>> Either you should add an __attribute__((__aligned__(PAGE_SIZE))),
>> or take into account the real address of area[] in cpu_alloc() to avoid waste
>> of up to PAGE_SIZE bytes
>> per cpu.
> 
> I think cacheline aligning should be sufficient. People should not 
> allocate large page aligned objects here.

I'm a bit confused.  Why is DEFINE_PER_CPU_SHARED_ALIGNED() conditioned on
ifdef MODULE?

        #ifdef MODULE
        #define SHARED_ALIGNED_SECTION ".data.percpu"
        #else
        #define SHARED_ALIGNED_SECTION ".data.percpu.shared_aligned"
        #endif

        #define DEFINE_PER_CPU_SHARED_ALIGNED(type, name)                       \
                __attribute__((__section__(SHARED_ALIGNED_SECTION)))            \
                PER_CPU_ATTRIBUTES __typeof__(type) per_cpu__##name             \
                ____cacheline_aligned_in_smp

Thanks,
Mike
