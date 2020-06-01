From: Luis Machado <luis.machado@linaro.org>
Subject: Re: [PATCH v4 18/26] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Date: Mon, 1 Jun 2020 12:17:27 -0300
Message-ID: <48197e4c-0b77-5e35-c735-922aede425c5@linaro.org>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-19-catalin.marinas@arm.com>
 <a6fb329c-b4ad-9ffa-5344-601348978c34@linaro.org>
 <20200601120724.GB23419@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgFAPRg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2020 11:17:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFAC05BD43
        for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2020 08:17:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c14so8331961qka.11
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2020 08:17:35 -0700 (PDT)
In-Reply-To: <20200601120724.GB23419@gaia>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Alan Hayward <Alan.Hayward@arm.com>, Omair Javaid <omair.javaid@linaro.org>

On 6/1/20 9:07 AM, Catalin Marinas wrote:
> On Fri, May 29, 2020 at 06:25:14PM -0300, Luis Machado wrote:
>> I have a question about siginfo MTE information. I suppose SEGV_MTESERR will
>> be the most useful setting for debugging, right? Does si_addr contain the
>> tagged pointer with the logical tag, a zero-tagged memory address or a
>> tagged pointer with the allocation tag?
> 
> The si_addr is zero-tagged currently. We were planning to expose the tag
> in FAR_EL1 as a separate siginfo field. See these discussions:
> > 
https://lore.kernel.org/linux-arm-kernel/20200513180914.50892-1-pcc@google.com/
> https://lore.kernel.org/linux-arm-kernel/20200521022943.195898-1-pcc@google.com/
> 
> In theory, we could add the tag to si_addr for SEGV_MTESERR, it
> shouldn't break the existing ABI (well, it depends on how you look at
> it).
> 

Having additional fields in siginfo that hold useful information is 
probably best for debuggers. See my comment below about Intel MPX.

>>  From the debugger user's perspective, one would want to see both the logical
>> tag and the allocation tag. And it would be handy to have both available in
>> siginfo. Does that make sense?
> 
> The debugger can access the allocation tag via PTRACE_PEEKMTETAGS. I
> don't think the kernel should provide this in siginfo. Also, the signal
> handler can do an LDG and read the allocation tag directly, no need for
> it to be in siginfo.
> 

While the debugger can request this information from the kernel, the 
debugger has already received a SIGSEGV signal and will have to fetch 
siginfo for si_code. Having to do another PTRACE_PEEKMTETAGS call just 
to fetch the allocation tag doesn't sound great. Remember this can 
travel through TCP to gdbserver so it can call ptrace from the remote's 
end. It would be best to avoid the round trip.

Also, there seems to be past precedent to include more information in 
siginfo. For example, Intel MPX includes upper/lower bounds violation 
data in there.

Regarding using LDG, are you suggesting force-running this particular 
instruction in the traced process? If so, that isn't the way GDB (in 
particular, not sure about LLDB) does things.

>> Also, when would we see SEGV_MTEAERR, for example? That would provide no
>> additional information about a particular memory address, which is not that
>> useful for the debugger.
> 
> Yeah, we can't really do much here since the hardware doesn't provide us
> such information. The async mode is only useful as a general test to see
> if your program has MTE faults but for actual debugging you'd have to
> switch to synchronous. For glibc at least, I think the mode can be
> driven by an environment variable.
> 

I suspect SEGV_MTESERR would be a reasonable default then, for whoever 
is responsible for setting the default settings.

I'm assuming it is not the debugger, as it doesn't know how to toggle 
prctl settings.
