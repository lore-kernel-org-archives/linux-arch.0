Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404908AbgFXRfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 13:35:13 -0400
From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Wed, 24 Jun 2020 13:35:09 -0400
Subject: Re: [PATCH v3 2/9] vmlinux.lds.h: Add .symtab, .strtab, and
 .shstrtab to STABS_DEBUG
Message-ID: <20200624173509.GA1460341@rani.riverdale.lan>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-3-keescook@chromium.org>
 <20200624153930.GA1337895@rani.riverdale.lan>
 <20200624161643.73x6navnwryckuit@google.com>
 <20200624171121.GA1377921@rani.riverdale.lan>
 <20200624172620.654hhjetiyzpgoxw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624172620.654hhjetiyzpgoxw@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fangrui Song <maskray@google.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20200624173509.-6Jzuvu3ESF5sk1zefH2mdO_gQ4-qJB75HEUvEyMZz0@z>

On Wed, Jun 24, 2020 at 10:26:20AM -0700, Fangrui Song wrote:
> 
> On 2020-06-24, Arvind Sankar wrote:
> >On Wed, Jun 24, 2020 at 09:16:43AM -0700, Fangrui Song wrote:
> >>
> >> On 2020-06-24, Arvind Sankar wrote:
> >> >On Tue, Jun 23, 2020 at 06:49:33PM -0700, Kees Cook wrote:
> >> >> When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
> >> >> and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
> >> >> so there will be no warnings when --orphan-handling=warn is used more
> >> >> widely. (They are added above comment as it is the more common
> >> >
> >> >Nit 1: is "after .comment" better than "above comment"? It's above in the
> >> >sense of higher file offset, but it's below in readelf output.
> >>
> >> I mean this order:)
> >>
> >>    .comment
> >>    .symtab
> >>    .shstrtab
> >>    .strtab
> >>
> >> This is the case in the absence of a linker script if at least one object file has .comment (mostly for GCC/clang version information) or the linker is LLD which adds a .comment
> >>
> >> >Nit 2: These aren't actually debugging sections, no? Is it better to add
> >> >a new macro for it, and is there any plan to stop LLD from warning about
> >> >them?
> >>
> >> https://reviews.llvm.org/D75149 "[ELF] --orphan-handling=: don't warn/error for unused synthesized sections"
> >> described that .symtab .shstrtab .strtab are different in GNU ld.
> >> Since many other GNU ld synthesized sections (.rela.dyn .plt ...) can be renamed or dropped
> >> via output section descriptions, I don't understand why the 3 sections
> >> can't be customized.
> >
> >So IIUC, lld will now warn about .rela.dyn etc only if they're non-empty?
> 
> HEAD and future 11.0.0 will not warn about unused synthesized sections
> like .rela.dyn
> 
> For most synthesized sections, empty = unused.
> 
> >>
> >> I created a feature request: https://sourceware.org/bugzilla/show_bug.cgi?id=26168
> >> (If this is supported, it is a consistent behavior to warn for orphan
> >> .symtab/.strtab/.shstrtab
> >>
> >> There may be 50% chance that the maintainer decides that "LLD diverges"
> >> I would disagree: there is no fundamental problems with .symtab/.strtab/.shstrtab which make them special in output section descriptions or orphan handling.)
> >>
> >
> >.shstrtab is a little special in that it can't be discarded if the ELF
> >file contains any sections at all. But yeah, there's no reason they
> >can't be renamed or placed in a custom location in the file.
> 
> https://sourceware.org/pipermail/binutils/2020-March/000179.html
> proposes -z nosectionheader. With this option, I believe .shstrtab is
> not needed. /DISCARD/ : { *(.shstrtab) }  should achieve a similar effect.

oh wow.
