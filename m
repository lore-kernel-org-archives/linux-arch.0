From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 1/6] arm64: Detect the ARMv8.4 TTL feature
Date: Tue, 26 May 2020 11:06:41 +0100
Message-ID: <872737c7e0690df3f42103365c651ad4@kernel.org>
References: <20200525125300.794-1-yezhenyu2@huawei.com>
 <20200525125300.794-2-yezhenyu2@huawei.com>
 <c6b6eb07-2606-9fc0-280a-e53b81a6491c@arm.com>
 <050b7ee6-c7aa-5d61-4dff-4792a411464e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgEZKGo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 May 2020 06:06:44 -0400
In-Reply-To: <050b7ee6-c7aa-5d61-4dff-4792a411464e@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On 2020-05-26 07:40, Zhenyu Ye wrote:
> Hi Anshuman,
> 
> On 2020/5/26 10:39, Anshuman Khandual wrote:
>> This patch (https://patchwork.kernel.org/patch/11557359/) is adding 
>> some
>> more ID_AA64MMFR2 features including the TTL. I am going to respin 
>> parts
>> of the V4 series patches along with the above mentioned patch. So 
>> please
>> rebase this series accordingly, probably on latest next.

No. Please.

>> 
> 
> I noticed that some patches of your series have been merged into arm64
> tree (for-next/cpufeature), such as TLB range, but this one not. Why?
> 
> BTW, this patch is provided by Marc in his NV series [1], maybe you
> should also let him know.
> 
> I will rebase my series after your patch is merged.

Please don't rebase on -next. That's the worse thing to do. Always base
your series on a well known -rc, and stick to that. Maintainers can
always do the rebase and resolve conflicts.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
