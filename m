From: Luis Machado <luis.machado@linaro.org>
Subject: Re: [PATCH v5 19/25] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Date: Wed, 1 Jul 2020 14:32:43 -0300
Message-ID: <8fa5c891-0f4a-c925-679e-94c41a546490@linaro.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-20-catalin.marinas@arm.com>
 <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
 <20200701171549.GF5191@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbgGARcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2020 13:32:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2287C08C5C1
        for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2020 10:32:52 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d12so11394273qvn.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2020 10:32:52 -0700 (PDT)
In-Reply-To: <20200701171549.GF5191@gaia>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Hayward <Alan.Hayward@arm.com>, Omair Javaid <omair.javaid@linaro.org>

Hi,

On 7/1/20 2:16 PM, Catalin Marinas wrote:
> Hi Luis,
> 
> On Thu, Jun 25, 2020 at 02:10:10PM -0300, Luis Machado wrote:
>> I have one point below I wanted to clarify regarding
>> PEEKMTETAGS/POKEMTETAGS.
>>
>> But before that, I've pushed v2 of the MTE series for GDB here:
>>
>> https://sourceware.org/git/?p=binutils-gdb.git;a=shortlog;h=refs/heads/users/luisgpm/aarch64-mte-v2
>>
>> That series adds sctlr and gcr registers to the NT_ARM_MTE (still using a
>> dummy value of 0x407) register set. It would be nice if the Linux Kernel and
>> the debuggers were in sync in terms of supporting this new register set. GDB
>> assumes the register set exists if HWCAP2_MTE is there.
>>
>> So, if we want to adjust the register set, we should probably consider doing
>> that now. That prevents the situation where debuggers would need to do
>> another check to confirm NT_ARM_MTE is exported. I'd rather avoid that.
> 
> I'm happy to do this before merging, though we need to agree on the
> semantics.
> 
> Do you need both read and write access? Also wondering whether the

If I recall the previous discussion correctly, Kevin thought access to 
both of these would be interesting to the user. It sounded like having 
read-only access was enough. If so,...

> prctl() value would be a better option than the raw register bits (well,
> not entirely raw, masking out the irrelevant part).

... then exposing the most useful bits to the user would be better, and 
up to you to define.

I can tweak the GDB patches to turn the sctlr and gcr values into flag 
fields. Then GDB can just show those in a more meaningful way. I just 
need to know what the bits would look like.

I'd rather not make these values writable if we don't think there is a 
good use case for it. Better avoid giving developers more knobs than 
they need?
