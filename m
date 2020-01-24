From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 09/10] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
Date: Fri, 24 Jan 2020 09:26:37 +0100
Message-ID: <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-10-will@kernel.org>
 <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXI0w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 03:26:52 -0500
Content-Disposition: inline
In-Reply-To: <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>

On Thu, Jan 23, 2020 at 10:36:37AM -0800, Nick Desaulniers wrote:
> On Thu, Jan 23, 2020 at 7:34 AM Will Deacon <will@kernel.org> wrote:
> >
> > It is very rare to see versions of GCC prior to 4.8 being used to build
> > the mainline kernel. These old compilers are also know to have codegen
> > issues which can lead to silent miscompilation:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > Raise the minimum GCC version for kernel build to 4.8 and remove some
> > tautological Kconfig dependencies as a consequence.
> >
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> 
> Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> I wouldn't mind if this patch preceded the earlier one in the series
> adding the warning, should the series require a v2 and if folks are
> generally ok with bumping the min version.

If I hadn't actually read your reply, I would have never spotted that
reviewed-by tag, hidden in a blob of text like that.

Adding some whitespace before and after, such that it stands out a
little more, might avoid such issues.
