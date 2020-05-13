From: Luis Machado <luis.machado@linaro.org>
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Date: Wed, 13 May 2020 09:52:52 -0300
Message-ID: <3d2621ac-9d08-53ea-6c22-c62532911377@linaro.org>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-20-catalin.marinas@arm.com>
 <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
 <20200513104849.GC2719@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732967AbgEMMxB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 08:53:01 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E4C061A0C
        for <linux-arch@vger.kernel.org>; Wed, 13 May 2020 05:53:01 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r3so8135174qvm.1
        for <linux-arch@vger.kernel.org>; Wed, 13 May 2020 05:53:01 -0700 (PDT)
In-Reply-To: <20200513104849.GC2719@gaia>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Alan Hayward <Alan.Hayward@arm.com>, Omair Javaid <omair.javaid@linaro.org>

On 5/13/20 7:48 AM, Catalin Marinas wrote:
> Hi Luis,
> 
> On Tue, May 12, 2020 at 04:05:15PM -0300, Luis Machado wrote:
>> On 4/21/20 11:25 AM, Catalin Marinas wrote:
>>> Add support for bulk setting/getting of the MTE tags in a tracee's
>>> address space at 'addr' in the ptrace() syscall prototype. 'data' points
>>> to a struct iovec in the tracer's address space with iov_base
>>> representing the address of a tracer's buffer of length iov_len. The
>>> tags to be copied to/from the tracer's buffer are stored as one tag per
>>> byte.
>>>
>>> On successfully copying at least one tag, ptrace() returns 0 and updates
>>> the tracer's iov_len with the number of tags copied. In case of error,
>>> either -EIO or -EFAULT is returned, trying to follow the ptrace() man
>>> page.
>>>
>>> Note that the tag copying functions are not performance critical,
>>> therefore they lack optimisations found in typical memory copy routines.
>>>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Alan Hayward <Alan.Hayward@arm.com>
>>> Cc: Luis Machado <luis.machado@linaro.org>
>>> Cc: Omair Javaid <omair.javaid@linaro.org>
>>> ---
>>>
>>> Notes:
>>>       New in v3.
>>>
>>>    arch/arm64/include/asm/mte.h         |  17 ++++
>>>    arch/arm64/include/uapi/asm/ptrace.h |   3 +
>>>    arch/arm64/kernel/mte.c              | 127 +++++++++++++++++++++++++++
>>>    arch/arm64/kernel/ptrace.c           |  15 +++-
>>>    arch/arm64/lib/mte.S                 |  50 +++++++++++
>>>    5 files changed, 211 insertions(+), 1 deletion(-)
>>>
>> I started working on MTE support for GDB and I'm wondering if we've already
>> defined a way to check for runtime MTE support (as opposed to a HWCAP2-based
>> check) in a traced process.
>>
>> Originally we were going to do it via empty-parameter ptrace calls, but you
>> had mentioned something about a proc-based method, if I'm not mistaken.
> 
> We could expose more information via proc_pid_arch_status() but that
> would be the tagged address ABI and tag check fault mode and intended
> for human consumption mostly. We don't have any ptrace interface that
> exposes HWCAPs. Since the gdbserver runs on the same machine as the
> debugged process, it can check the HWCAPs itself, they are the same for
> all processes.

Sorry, I think i haven't made it clear. I already have access to HWCAP2 
both from GDB's and gdbserver's side. But HWCAP2 only indicates the 
availability of a particular feature in a CPU, it doesn't necessarily 
means the traced process is actively using MTE, right?

So GDB/gdbserver would need runtime checks to be able to tell if a 
process is using MTE, in which case the tools will pay attention to tags 
and additional MTE-related registers (sctlr and gcr) we plan to make 
available to userspace.

This would be similar to SVE, where we have a HWCAP bit indicating the 
presence of the feature, but it may not be in use at runtime for a 
particular running process.

The original proposal was to have GDB send PTRACE_PEEKMTETAGS with a 
NULL address and check the result. Then GDB would be able to decide if 
the process is using MTE or not.

> 
> BTW, in my pre-v4 patches (hopefully I'll post v4 this week), I changed
> the ptrace tag access slightly to return an error (and no tags copied)
> if the page has not been mapped with PROT_MTE. The other option would
> have been read-as-zero/write-ignored as per the hardware behaviour.
> Either option is fine by me but I thought the write-ignored part would
> be more confusing for the debugger. If you have any preference here,
> please let me know.
> 

I think erroring out is a better alternative, as long as the debugger 
can tell what the error means, like, for example, "this particular 
address doesn't make use of tags".
