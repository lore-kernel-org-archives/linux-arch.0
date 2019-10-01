Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42066 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfJASOv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 14:14:51 -0400
Date: Tue, 1 Oct 2019 19:14:38 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191001181438.GL25745@shell.armlinux.org.uk>
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
 <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
Message-ID: <20191001181438.PMZwFqIJhcwlGDw1vzQHffTHMEatP-CKEM6UgMUX5YM@z>

On Tue, Oct 01, 2019 at 11:00:11AM -0700, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > > I apologize; I don't mean to be difficult.  I would just like to avoid
> > > surprises when code written with the assumption that it will be
> > > inlined is not.  It sounds like we found one issue in arm32 and one in
> > > arm64 related to outlining.  If we fix those two cases, I think we're
> > > close to proceeding with Masahiro's cleanup, which I view as a good
> > > thing for the health of the Linux kernel codebase.
> >
> > Except, using the C preprocessor for this turns the arm32 code into
> > yuck:
> >
> > 1. We'd need to turn get_domain() and set_domain() into multi-line
> >    preprocessor macro definitions, using the GCC ({ }) extension
> >    so that get_domain() can return a value.
> >
> > 2. uaccess_save_and_enable() and uaccess_restore() also need to
> >    become preprocessor macro definitions too.
> >
> > So, we end up with multiple levels of nested preprocessor macros.
> > When something goes wrong, the compiler warning/error message is
> > going to be utterly _horrid_.
> 
> That's why I preferred V1 of Masahiro's patch, that fixed the inline
> asm not to make use of caller saved registers before calling a
> function that might not be inlined.

... which I objected to based on the fact that this uaccess stuff is
supposed to add protection against the kernel being fooled into
accessing userspace when it shouldn't.  The whole intention there is
that [sg]et_domain(), and uaccess_*() are _always_ inlined as close
as possible to the call site of the accessor touching userspace.

Moving it before the assignments mean that the compiler is then free
to issue memory loads/stores to load up those registers, which is
exactly what we want to avoid.


In any case, I violently disagree with the idea that stuff we have
in header files should be permitted not to be inlined because we
have soo much that is marked inline.  Having it moved out of line,
and essentially the same function code appearing in multiple C files
is really not an improvement over the current situation with excessive
use of inlining.  Anyone who has looked at the code resulting from
dma_map_single() will know exactly what I'm talking about, which is
way in excess of the few instructions we have for the uaccess_* stuff
here.

The right approach is to move stuff out of line - and by that, I
mean _actually_ move the damn code, so that different compilation
units can use the same instructions, and thereby gain from the
whole point of an instruction cache.

The whole "let's make inline not really mean inline" is nothing more
than a band-aid to the overuse (and abuse) of "inline".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
