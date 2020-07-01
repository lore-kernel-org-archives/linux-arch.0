From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 19/25] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Date: Wed, 1 Jul 2020 18:16:09 +0100
Message-ID: <20200701171549.GF5191@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-20-catalin.marinas@arm.com>
 <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732584AbgGARQO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Jul 2020 13:16:14 -0400
Content-Disposition: inline
In-Reply-To: <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luis Machado <luis.machado@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Hayward <Alan.Hayward@arm.com>, Omair Javaid <omair.javaid@linaro.org>

Hi Luis,

On Thu, Jun 25, 2020 at 02:10:10PM -0300, Luis Machado wrote:
> I have one point below I wanted to clarify regarding
> PEEKMTETAGS/POKEMTETAGS.
> 
> But before that, I've pushed v2 of the MTE series for GDB here:
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=shortlog;h=refs/heads/users/luisgpm/aarch64-mte-v2
> 
> That series adds sctlr and gcr registers to the NT_ARM_MTE (still using a
> dummy value of 0x407) register set. It would be nice if the Linux Kernel and
> the debuggers were in sync in terms of supporting this new register set. GDB
> assumes the register set exists if HWCAP2_MTE is there.
> 
> So, if we want to adjust the register set, we should probably consider doing
> that now. That prevents the situation where debuggers would need to do
> another check to confirm NT_ARM_MTE is exported. I'd rather avoid that.

I'm happy to do this before merging, though we need to agree on the
semantics.

Do you need both read and write access? Also wondering whether the
prctl() value would be a better option than the raw register bits (well,
not entirely raw, masking out the irrelevant part).

-- 
Catalin
