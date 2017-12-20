Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:45274 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbdLTU3S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Dec 2017 15:29:18 -0500
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
References: <20171219114112.939391-1-arnd@arndb.de>
 <8e42a1de-f619-7a4e-6d58-f90f53f5f38f@synopsys.com>
 <CAK8P3a2fXQHCN7gqNL9j7AeZqy7NXAMW1bqyFJs3G1M_M4BQ4A@mail.gmail.com>
 <f31caa9b-89f0-4168-04bf-14a98595865e@synopsys.com>
 <CAK8P3a25RgC0qPCrGfutSnLHr77NqK74dW2g0m7fcMnm5Ou8yg@mail.gmail.com>
 <27bfdc23-1774-cf07-dab4-ab253a41d2f7@synopsys.com>
 <CAK8P3a0UKLJkmU_zVDyODMZR0G47i=zscNpgGZO4LryvmdUt6Q@mail.gmail.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <861992dd-a28d-0f8c-572f-4194d15238df@synopsys.com>
Date: Wed, 20 Dec 2017 12:29:02 -0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0UKLJkmU_zVDyODMZR0G47i=zscNpgGZO4LryvmdUt6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Christopher Li <sparse@chrisli.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20171220202902.IJ6NY7mk6NPgzlA4zYiq4xgYxtDV8jimFu0CuwGpTGo@z>

On 12/20/2017 12:12 PM, Arnd Bergmann wrote:
>> Sorry, I didn't realize we are missing the stack trace now which you removed
>> from the patch - why ? Did u intend to reduce inline generated code for the
>> stack dump calls - which sounds like a great idea. But it would only work
>> for the synchronous abort() but not when builtin translates to actual trap
>> inducing instruction.
> 
> I assumed that the trap instruction would trigger the register and
> stack dump, as it does on all other architectures.

Only if __builtin_trap() translated to that instruction. Otherwise we need to do 
this inside abort()

> The most common
> way this is handled is to have one instruction that is known to trap,
> and use that to trigger a BUG(), and have __builtin_trap() issue
> that instruction as well.

Good point. So we'll need ARC specific abort anyways.


> You might also want to implement CONFIG_DEBUG_BUGVERBOSE
> support to attach further data to it.

OK I'll take a look !

> How about overriding abort() with the same instruction that
> __builtin_trap() inserts on newer compilers then? That should
> make the behavior consistent.

Yeah this is a great point ! Will do

thx,
-Vineet
