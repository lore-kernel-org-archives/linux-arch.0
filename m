From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 05/11] arm64: csum: Disable KASAN for do_csum()
Date: Wed, 22 Apr 2020 12:01:53 +0100
Message-ID: <6efa0cc1-bd3e-b9b6-4e69-7ac05e6efe35@arm.com>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-6-will@kernel.org>
 <20200422094951.GA54428@lakrids.cambridge.arm.com>
 <20200422104138.GA30265@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:47618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732384AbgDVLB7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 07:01:59 -0400
In-Reply-To: <20200422104138.GA30265@willie-the-truck>
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On 2020-04-22 11:41 am, Will Deacon wrote:
> On Wed, Apr 22, 2020 at 10:49:52AM +0100, Mark Rutland wrote:
>> On Tue, Apr 21, 2020 at 04:15:31PM +0100, Will Deacon wrote:
>>> do_csum() over-reads the source buffer and therefore abuses
>>> READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
>>> READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
>>> '__no_sanitize_address' annotation, just annotate do_csum() explicitly
>>> and fall back to normal loads.
>>>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>
>>  From a functional perspective:
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks.
> 
>> I know that Robin had a concern w.r.t. how this would affect the
>> codegen, but I think we can follow that up after the series as a whole
>> is merged.
> 
> Makes sense. I did look at the codegen, fwiw, and it didn't seem especially
> bad. One of the LDP's gets cracked in the unlikely() path, but it didn't
> look like it would be a disaster (and sprinkling barrier() around to force
> the LDP felt really fragile!).

Sure - I have a nagging feeling that it could still do better WRT 
pipelining the loads anyway, so I'm happy to come back and reconsider 
the local codegen later. It certainly doesn't deserve to stand in the 
way of cross-arch rework.

Other than dereferencing the ptr argument, this code has no cause to 
make any explicit memory accesses of its own, so I don't think we lose 
any practical KASAN coverage by moving the annotation to function level. 
Given all that,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.
