Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdHQKqP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Aug 2017 06:46:15 -0400
Subject: Re: [PATCH 15/27] arm64/sve: Probe SVE capabilities and usable vector
 lengths
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-16-git-send-email-Dave.Martin@arm.com>
 <07268b07-c5f4-38d6-257d-5864cb6752c1@arm.com>
 <20170817100424.GI6321@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <5cd3b5c8-acea-044e-c503-a7e8ad0180f8@arm.com>
Date: Thu, 17 Aug 2017 11:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170817100424.GI6321@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu
Message-ID: <20170817104612.QJ7cyq4uz4hErYmI60TIth1JvlawxlWXGEOmq53VVrI@z>

On 17/08/17 11:04, Dave Martin wrote:
> On Wed, Aug 16, 2017 at 06:48:01PM +0100, Suzuki K Poulose wrote:
>> On 09/08/17 13:05, Dave Martin wrote:
>>> [This sender failed our fraud detection checks and may not be who they appear to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing]
>
> Any idea what this is ^ ?  I don't know if this is caused by me or you,
> but I only seem to see it on subthreads you've replied to.
>

Dave,

Sorry about that, should have trimmed that. It looks like the mail server is unhappy
about email received via kvmarm list and I don't know why.

>>
>>> +void __init sve_setup(void)
>>> +{
>>> +       u64 zcr;
>>> +       unsigned int max_vl;
>>> +
>>> +       if (!system_supports_sve())
>>> +               return;
>>> +
>>> +       /*
>>> +        * The architecture mandates 128-bit vectors be supported, and
>>> +        * the code assumes elsewhere that sve_vq_map is non-empty:
>>> +        */
>>> +       BUG_ON(!test_bit(vq_to_bit(1), sve_vq_map));
>>> +
>>> +       sve_vq_map_finalised = true;
>>
>> We have something local in cpufeature.c, sys_caps_initialised. May be we could
>> reuse it here ? With or without that change, FWIW.
>
> I'll take a look at that.  Inventing that here seemed a little ugly, and
> this is all driven from the cpufreatures code anyway now which ensures a
> certain ordering.
>
> If I can reuse sys_caps_initialised for this, I will -- seems pointless
> to reinvent it.

Suzuki
