From: Marc Zyngier <maz@kernel.org>
Subject: Re: [RESEND RFC PATCH v1] arm64: kvm: flush tlbs by range in
 unmap_stage2_range function
Date: Mon, 27 Jul 2020 18:12:34 +0100
Message-ID: <fb4756b58892fbc2022cf1f5b9320c27@kernel.org>
References: <20200724134315.805-1-yezhenyu2@huawei.com>
 <5d54c860b3b4e7a98e4d53397e6424ae@kernel.org>
 <f74277fd-5af2-c46f-169f-c15a321165cd@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f74277fd-5af2-c46f-169f-c15a321165cd@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, steven.price@arm.com, mark.rutland@arm.com, ascull@google.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com
List-Id: linux-arch.vger.kernel.org

Zhenyu,

On 2020-07-27 15:51, Zhenyu Ye wrote:
> Hi Marc,
> 
> On 2020/7/26 1:40, Marc Zyngier wrote:
>> On 2020-07-24 14:43, Zhenyu Ye wrote:
>>> Now in unmap_stage2_range(), we flush tlbs one by one just after the
>>> corresponding pages cleared.  However, this may cause some 
>>> performance
>>> problems when the unmap range is very large (such as when the vm
>>> migration rollback, this may cause vm downtime too loog).
>> 
>> You keep resending this patch, but you don't give any numbers
>> that would back your assertion.
> 
> I have tested the downtime of vm migration rollback on arm64, and found
> the downtime could even take up to 7s.  Then I traced the cost of
> unmap_stage2_range() and found it could take a maximum of 1.2s.  The
> vm configuration is as follows (with high memory pressure, the dirty
> rate is about 500MB/s):
> 
>   <memory unit='GiB'>192</memory>
>   <vcpu placement='static'>48</vcpu>
>   <memoryBacking>
>     <hugepages>
>       <page size='1' unit='GiB' nodeset='0'/>
>     </hugepages>
>   </memoryBacking>

This means nothing to me, I'm afraid.

> 
> After this patch applied, the cost of unmap_stage2_range() can reduce 
> to
> 16ms, and VM downtime can be less than 1s.
> 
> The following figure shows a clear comparison:
> 
> 	      |	vm downtime  |	cost of unmap_stage2_range()
> --------------+--------------+----------------------------------
> before change |		7s   |		1200 ms
> after  change |		1s   |		  16 ms
> --------------+--------------+----------------------------------

I don't see how you turn a 1.184s reduction into a 6s gain.
Surely there is more to it than what you posted.

>>> +
>>> +    if ((end - start) >= 512 << (PAGE_SHIFT - 12)) {
>>> +        __tlbi(vmalls12e1is);
>> 
>> And what is this magic value based on? You don't even mention in the
>> commit log that you are taking this shortcut.
>> 
> 
> 
> If the page num is bigger than 512, flush all tlbs of this vm to avoid
> soft lock-ups on large TLB flushing ranges.  Just like what the
> flush_tlb_range() does.

I'm not sure this is applicable here, and it doesn't mean
this is as good on other systems.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
