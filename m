From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Tue, 20 Sep 2016 14:35:45 +0200
Message-ID: <c24828e0-9c67-aa48-e62a-f68496c4d8ad@de.ibm.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
 <60adab94-f32e-2287-4821-81a88fa366d4@de.ibm.com>
 <20160920222732.12301963@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751449AbcITMf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Sep 2016 08:35:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8KCYQDB042919
        for <linux-arch@vger.kernel.org>; Tue, 20 Sep 2016 08:35:55 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25jnp70my9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Sep 2016 08:35:55 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 20 Sep 2016 13:35:53 +0100
In-Reply-To: <20160920222732.12301963@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>

On 09/20/2016 02:27 PM, Nicholas Piggin wrote:
> On Tue, 20 Sep 2016 13:19:30 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 09/16/2016 10:57 AM, Nicholas Piggin wrote:
>>> Implementing busy wait loops with cpu_relax() in callers poses
>>> some difficulties for powerpc.
>>>
>>> First, we want to put our SMT thread into a low priority mode for the
>>> duration of the loop, but then return to normal priority after exiting
>>> the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
>>> cpu_relax() does may have HMT_medium take effect before HMT_low made
>>> any (or much) difference.
>>>
>>> Second, it can be beneficial for some implementations to spin on the
>>> exit condition with a statically predicted-not-taken branch (i.e.,
>>> always predict the loop will exit).
>>>
>>> This is a quick RFC with a couple of users converted to see what
>>> people think. I don't use a C branch with hints, because we don't want
>>> the compiler moving the loop body out of line, which makes it a bit
>>> messy unfortunately. If there's a better way to do it, I'm all ears.
>>>
>>> I would not propose to switch all callers immediately, just some
>>> core synchronisation primitives.  
>> Just a FYA,
>>
>> On s390 we have a private version of cpu_relax that yields the cpu
>> time slice back to the hypervisor via a hypercall.
> 
> The powerpc guest also wants to yield to hypervisor in some busywait
> situations.
> 
>> As this turned out
>> to be problematic in some cases there is also now a cpu_relax_lowlatency.
>>
>> Now, this seems still problematic as there are too many places still 
>> using cpu_relax instead of cpu_relax_lowlatency. So my plan is to do 
>> a change of that, make cpu_relax just be a barrier and add a new 
>> cpu_relax_yield that gives up the time slice. (so that s390 cpu_relax
>> is just like any other cpu_relax)
>>
>> As far as I can tell the only place where I want to change cpu_relax
>> to cpu_relax_lowlatency after that change is the stop machine run 
>> code, so I hope to have no conflicts with your changes.
> 
> I don't think there should be any conflicts, but it would be good to
> make sure busy wait primitives can be usable by s390. So I can add
> _yield variants that can do the right thing for s390.

I was distracted by "more important work" (TM) but I will put you on
CC when ready.
> 
> I need to think more about virtualization, so I'm glad you commented.
> Powerpc would like to be told when a busywait loop knows the CPU it is
> waiting for. So perhaps also a _yield_to_cpu variant as well.

Yes, we also have 2 hypercalls: one that yields somehow and one that yields
to a specific CPU. The latter is strongly preferred.
> 
> Something that will work with mutex_spin_on_owner and similar would be
> nice too. As far as I can tell, powerpc may want to yield to hypervisor
> when the owner's vcpu is scheduled off in that case too.
> 
