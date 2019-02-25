Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35036 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbfBYQ53 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Feb 2019 11:57:29 -0500
Date: Mon, 25 Feb 2019 16:57:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Message-ID: <20190225165720.GA79300@arrakis.emea.arm.com>
References: <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com>
 <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com>
 <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com>
 <ac8f4e3b-84b8-6067-6a7a-fac7dc48daea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8f4e3b-84b8-6067-6a7a-fac7dc48daea@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: Evgenii Stepanov <eugenis@google.com>, nd <nd@arm.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Linux Memory Management List <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Kostya Serebryany <kcc@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <Robin.Murphy@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20190225165721.LX--BWSa2djebxZobcY-c235nfGLYVPxuUmL79qPk_w@z>

Hi Szabolcs,

Thanks for looking into this. Comments below.

On Tue, Feb 19, 2019 at 06:38:31PM +0000, Szabolcs Nagy wrote:
> i think these rules work for the cases i care about, a more
> tricky question is when/how to check for the new syscall abi
> and when/how the TCR_EL1.TBI0 setting may be turned off.

I don't think turning TBI0 off is critical (it's handy for PAC with
52-bit VA but then it's short-lived if you want more security features
like MTE).

> consider the following cases (tb == top byte):
> 
> binary 1: user tb = any, syscall tb = 0
>   tbi is on, "legacy binary"
> 
> binary 2: user tb = any, syscall tb = any
>   tbi is on, "new binary using tb"
>   for backward compat it needs to check for new syscall abi.
> 
> binary 3: user tb = 0, syscall tb = 0
>   tbi can be off, "new binary",
>   binary is marked to indicate unused tb,
>   kernel may turn tbi off: additional pac bits.
> 
> binary 4: user tb = mte, syscall tb = mte
>   like binary 3, but with mte, "new binary using mte"
>   does it have to check for new syscall abi?
>   or MTE HWCAP would imply it?
>   (is it possible to use mte without new syscall abi?)

I think MTE HWCAP should imply it.

> in userspace we want most binaries to be like binary 3 and 4
> eventually, i.e. marked as not-relying-on-tbi, if a dso is
> loaded that is unmarked (legacy or new tb user), then either
> the load fails (e.g. if mte is already used? or can we turn
> mte off at runtime?) or tbi has to be enabled (prctl? does
> this work with pac? or multi-threads?).

We could enable it via prctl. That's the plan for MTE as well (in
addition maybe to some ELF flag).

> as for checking the new syscall abi: i don't see much semantic
> difference between AT_HWCAP and AT_FLAGS (either way, the user
> has to check a feature flag before using the feature of the
> underlying system and it does not matter much if it's a syscall
> abi feature or cpu feature), but i don't see anything wrong
> with AT_FLAGS if the kernel prefers that.

The AT_FLAGS is aimed at capturing binary 2 case above, i.e. the
relaxation of the syscall ABI to accept tb = any. The MTE support will
have its own AT_HWCAP, likely in addition to AT_FLAGS. Arguably,
AT_FLAGS is either redundant here if MTE implies it (and no harm in
keeping it around) or the meaning is different: a tb != 0 may be checked
by the kernel against the allocation tag (i.e. get_user() could fail,
the tag is not entirely ignored).

> the discussion here was mostly about binary 2,

That's because passing tb != 0 into the syscall ABI is the main blocker
here that needs clearing out before merging the MTE support. There is,
of course, a variation of binary 1 for MTE:

binary 5: user tb = mte, syscall tb = 0

but this requires a lot of C lib changes to support properly.

> but for
> me the open question is if we can make binary 3/4 work.
> (which requires some elf binary marking, that is recognised
> by the kernel and dynamic loader, and efficient handling of
> the TBI0 bit, ..if it's not possible, then i don't see how
> mte will be deployed).

If we ignore binary 3, we can keep TBI0 = 1 permanently, whether we have
MTE or not.

> and i guess on the kernel side the open question is if the
> rules 1/2/3/4 can be made to work in corner cases e.g. when
> pointers embedded into structs are passed down in ioctl.

We've been trying to track these down since last summer and we came to
the conclusion that it should be (mostly) fine for the non-weird memory
described above.

-- 
Catalin
