From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
Date: Wed, 24 Jun 2020 16:51:44 -0700
Message-ID: <20200624235144.GD818054@tassilo.jf.intel.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com>
 <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
 <CAKwvOdm_EBfmV+GvDE-COoDwpEm9snea4_KtuFyorA5KEU6FbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34743 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387959AbgFXXvp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 19:51:45 -0400
Content-Disposition: inline
In-Reply-To: <CAKwvOdm_EBfmV+GvDE-COoDwpEm9snea4_KtuFyorA5KEU6FbQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>

On Wed, Jun 24, 2020 at 02:09:40PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 24, 2020 at 1:58 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Filter out CC_FLAGS_LTO for the vDSO.
> >
> > Just curious about this patch (and the following one for x86's vdso),
> > do you happen to recall specifically what the issues with the vdso's
> > are?
> 
> + Andi (tangential, I actually have a bunch of tabs open with slides
> from http://halobates.de/ right now)
> 58edae3aac9f2
> 67424d5a22124
> $ git log -S DISABLE_LTO

I think I did it originally because the vDSO linker step didn't do
all the magic needed for gcc LTO. But it also doesn't seem to be
very useful for just a few functions that don't have complex
interactions, and somewhat risky for violating some assumptions.

-Andi
