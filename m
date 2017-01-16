Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdAPQb3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jan 2017 11:31:29 -0500
Date: Mon, 16 Jan 2017 16:31:23 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
Message-ID: <20170116163123.GQ3699@e103592.cambridge.arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
 <20170116122038.GG28060@E107787-LIN>
 <20170116133231.GO3699@e103592.cambridge.arm.com>
 <20170116151156.GI28060@E107787-LIN>
 <a7261d6b-0074-7345-d380-ef0dd335dd56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7261d6b-0074-7345-d380-ef0dd335dd56@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pedro Alves <palves@redhat.com>
Cc: Yao Qi <qiyaoltc@gmail.com>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, gdb@sourceware.org, Christoffer Dall <christoffer.dall@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org, Alan Hayward <alan.hayward@arm.com>, Torvald Riegel <triegel@redhat.com>, Joseph Myers <joseph@codesourcery.com>
Message-ID: <20170116163123.PkNgCJwhR7wwDC3M0bZOaaPTd3RPrw1gYF03Wjchuic@z>

On Mon, Jan 16, 2017 at 03:47:55PM +0000, Pedro Alves wrote:
> On 01/16/2017 03:11 PM, Yao Qi wrote:
> > 
> >> > 
> >> > gdb must already re-detect the vector length on stop, since the target
> >> > could have called the prctl() in the meantime.
> > Yes, gdb assumes the vector length may be changed, so it re-detects on
> > every stop, but I don't see the need for gdb to change the vector length.
> > 
> 
> Do we need to consider inferior function calls here?
> 
> Say the program is stopped in code that assumes "vector length N", and
> the user does "print some_function_that_assumes_some_other_vector_length ()".
> 
> Is that a use case we need to cover?
> 
> If so, to make it work correctly, the debugger needs to be able to change the
> vector length to the length assumed by that called function, and then
> restore it back after the call completes (or is aborted).
> 
> I have no idea whether the debugger will be able to figure
> out a function's assumed vector length from debug info or some such.

I think the proposed ptrace interface can support this -- i.e., it
should provide everything needed to save off the VL and register state,
switch VL, do something else, then restore the VL and state (if not,
that's a bug).

My current position is that determining what vector length is
required by what function or binary is a 100% userspace problem, though.

ELF/DWARF could have annotations about this, though it wouldn't
necessarily be per-function -- you might require a whole image to be
built for the same vector length (if any).

Cheers
---Dave
