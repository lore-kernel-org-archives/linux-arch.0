From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Date: Sat, 1 Aug 2020 13:27:46 -0400
Message-ID: <20200801172746.GC3249534@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
 <20200801035128.GB2800311@rani.riverdale.lan>
 <202007312237.4F385EB3@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHAR1u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Aug 2020 13:27:50 -0400
Content-Disposition: inline
In-Reply-To: <202007312237.4F385EB3@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Jian Cai <jiancai@google.com>, =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org

On Fri, Jul 31, 2020 at 11:18:02PM -0700, Kees Cook wrote:
> On Fri, Jul 31, 2020 at 11:51:28PM -0400, Arvind Sankar wrote:
> > 
> > This also changes the ordering to place all hot resp unlikely sections separate
> > from other text, while currently it places the hot/unlikely bits of each file
> > together with the rest of the code in that file. That seems like a reasonable
> 
> Oh, hmm, yes, we aren't explicitly using SORT() here. Does that mean the
> input sections were entirely be ordered in compilation unit link order,
> even in the case of orphan sections? (And I think either way, the answer
> isn't the same between bfd and lld.) I actually thought the like-named
> input sections were collected together first with lld, but bfd strictly
> appended to the output section. I guess it's time for me to stare at -M
> output from ld...

I don't know what happened to the orphans previously. But .text.hot and
.text.unlikely will now change ordering. It sounds from below like this
wasn't intentional? Though it does seem to be how BFD's default linker
scripts lay it out.

> 
> Regardless, this patch is attempting to fix the problem where bfd and lld
> lay out the orphans differently (as mentioned above, lld seems to sort
> them in a way that is not strictly appended, and bfd seems to sort them
> strictly appended). In the case of being appended to the .text output
> section, this would cause boot failures due to _etext not covering the
> resulting sections (which this[1] also encountered and fixed to be more
> robust for such appended collection -- that series actually _depends_ on
> orphan handling doing the appending, because there is no current way
> to map wildcard input sections to their own separate output sections).
> 
> > change and should be mentioned in the commit message.
> > 
> > However, the history of their being together comes from
> > 
> >   9bebe9e5b0f3 ("kbuild: Fix .text.unlikely placement")
> > 
> > which seems to indicate there was some problem with having them separated out,
> > although I don't quite understand what the issue was from the commit message.
> 
> Looking at this again, I actually wonder if we have bigger issues here
> with dead code elimination:
> 
> #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> ...
> 
> that would catch: .text.hot .text.fixup .text.unlikely and .text.unknown
> but not .text.hot.*, etc (i.e. the third dot isn't matched, which is,
> I assume, why Clang switched to adding a trailing dot). However, this
> patch lists .text.hot .text.hot.* first, so they'd get pulled to the
> front correctly, but the trailing ones (with 2 dots) would not, since
> they'd match the TEXT_MAIN wildcard first. (This problem actually existed
> before this patch too, and is not the fault of 9bebe9e5b0f3, but rather
> the addition of TEXT_MAIN, which could potentially match .text.unlikely
> and .text.fixup)

The existing comment on TEXT_TEXT mentions that issue. However, note
that the dead code stuff is only available currently on mips and ppc,
and is hidden behind EXPERT for those, so I'm not sure if anyone
actually uses it.

9bebe9e5b0f3 predates LD_DEAD_CODE_DATA_ELIMINATION, and there were no
wildcards I can see in .text at the time, which is why I don't
understand what problem is referred to in the commit message.

Btw, for the FGKASLR stuff, instead of keeping the output sections per
function, couldn't you generate a table of functions with sizes, and use
that when randomizing the order? Then the sections themselves could be
collected into .text explicitly.
