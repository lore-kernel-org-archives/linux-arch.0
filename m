Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15399 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389079AbfEXPU5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 11:20:57 -0400
Date: Fri, 24 May 2019 10:20:45 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] module/ksymtab: use 64-bit relative reference for target
 symbol
Message-ID: <20190524152045.w3syntzp4bb5jb7u@treble>
References: <20190522150239.19314-1-ard.biesheuvel@arm.com>
 <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com>
 <f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com>
 <20190523091811.GA26646@fuggles.cambridge.arm.com>
 <907a9681-cd1d-3326-e3dd-5f6965497720@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <907a9681-cd1d-3326-e3dd-5f6965497720@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, guillaume.gardet@arm.com, mark.rutland@arm.com, mingo@kernel.org, jeyu@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, x86@kernel.org
Message-ID: <20190524152045.LlasWUPZCwWpizx6_o0dKGvpkzr1FBkb6BT4wObAS3Y@z>

On Thu, May 23, 2019 at 10:29:39AM +0100, Ard Biesheuvel wrote:
> 
> 
> On 5/23/19 10:18 AM, Will Deacon wrote:
> > On Thu, May 23, 2019 at 09:41:40AM +0100, Ard Biesheuvel wrote:
> > > 
> > > 
> > > On 5/22/19 5:28 PM, Ard Biesheuvel wrote:
> > > > 
> > > > 
> > > > On 5/22/19 4:02 PM, Ard Biesheuvel wrote:
> > > > > The following commit
> > > > > 
> > > > >     7290d5809571 ("module: use relative references for __ksymtab entries")
> > > > > 
> > > > > updated the ksymtab handling of some KASLR capable architectures
> > > > > so that ksymtab entries are emitted as pairs of 32-bit relative
> > > > > references. This reduces the size of the entries, but more
> > > > > importantly, it gets rid of statically assigned absolute
> > > > > addresses, which require fixing up at boot time if the kernel
> > > > > is self relocating (which takes a 24 byte RELA entry for each
> > > > > member of the ksymtab struct).
> > > > > 
> > > > > Since ksymtab entries are always part of the same module as the
> > > > > symbol they export (or of the core kernel), it was assumed at the
> > > > > time that a 32-bit relative reference is always sufficient to
> > > > > capture the offset between a ksymtab entry and its target symbol.
> > > > > 
> > > > > Unfortunately, this is not always true: in the case of per-CPU
> > > > > variables, a per-CPU variable's base address (which usually differs
> > > > > from the actual address of any of its per-CPU copies) could be at
> > > > > an arbitrary offset from the ksymtab entry, and so it may be out
> > > > > of range for a 32-bit relative reference.
> > > > > 
> > > 
> > > (Apologies for the 3-act monologue)
> > 
> > Exposition, development and recapitulation ;)
> > 
> > > This turns out to be incorrect. The symbol address of per-CPU variables
> > > exported by modules is always in the vicinity of __per_cpu_start, and so it
> > > is simply a matter of making sure that the core kernel is in range for
> > > module ksymtab entries containing 32-bit relative references.
> > > 
> > > When running the arm64 with kaslr enabled, we currently randomize the module
> > > space based on the range of ADRP/ADD instruction pairs, which have a -/+ 4
> > > GB range rather than the -/+ 2 GB range of 32-bit place relative data
> > > relocations. So we can fix this by simply reducing the randomization window
> > > to 2 GB.
> > 
> > Makes sense. Do you see the need for an option to disable PREL relocs
> > altogether in case somebody wants the additional randomization range?
> > 
> 
> No, not really. To be honest, I don't think
> CONFIG_RANDOMIZE_MODULE_REGION_FULL is that useful to begin with, and the
> only reason we enabled it by default at the time was to ensure that the PLT
> code got some coverage after we introduced it.

In code, percpu variables are accessed with absolute relocations, right?
Before I read your 3rd act, I was wondering if it would make sense to do
the same with the ksymtab relocations.

Like if we somehow [ insert much hand waving ] ensured that everybody
uses EXPORT_PER_CPU_SYMBOL() for percpu symbols instead of just
EXPORT_SYMBOL() then we could use a different macro to create the
ksymtab relocations for percpu variables, such that they use absolute
relocations.

Just an idea.  Maybe the point is moot now.

-- 
Josh
