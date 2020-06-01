From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 18/26] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Date: Mon, 1 Jun 2020 13:07:25 +0100
Message-ID: <20200601120724.GB23419@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-19-catalin.marinas@arm.com>
 <a6fb329c-b4ad-9ffa-5344-601348978c34@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:37536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFAMH3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 08:07:29 -0400
Content-Disposition: inline
In-Reply-To: <a6fb329c-b4ad-9ffa-5344-601348978c34@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luis Machado <luis.machado@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Alan Hayward <Alan.Hayward@arm.com>, Omair Javaid <omair.javaid@linaro.org>

On Fri, May 29, 2020 at 06:25:14PM -0300, Luis Machado wrote:
> I have a question about siginfo MTE information. I suppose SEGV_MTESERR will
> be the most useful setting for debugging, right? Does si_addr contain the
> tagged pointer with the logical tag, a zero-tagged memory address or a
> tagged pointer with the allocation tag?

The si_addr is zero-tagged currently. We were planning to expose the tag
in FAR_EL1 as a separate siginfo field. See these discussions:

https://lore.kernel.org/linux-arm-kernel/20200513180914.50892-1-pcc@google.com/
https://lore.kernel.org/linux-arm-kernel/20200521022943.195898-1-pcc@google.com/

In theory, we could add the tag to si_addr for SEGV_MTESERR, it
shouldn't break the existing ABI (well, it depends on how you look at
it).

> From the debugger user's perspective, one would want to see both the logical
> tag and the allocation tag. And it would be handy to have both available in
> siginfo. Does that make sense?

The debugger can access the allocation tag via PTRACE_PEEKMTETAGS. I
don't think the kernel should provide this in siginfo. Also, the signal
handler can do an LDG and read the allocation tag directly, no need for
it to be in siginfo.

> Also, when would we see SEGV_MTEAERR, for example? That would provide no
> additional information about a particular memory address, which is not that
> useful for the debugger.

Yeah, we can't really do much here since the hardware doesn't provide us
such information. The async mode is only useful as a general test to see
if your program has MTE faults but for actual debugging you'd have to
switch to synchronous. For glibc at least, I think the mode can be
driven by an environment variable.

-- 
Catalin
