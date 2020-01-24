From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 09/10] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
Date: Sat, 25 Jan 2020 00:29:44 +0100
Message-ID: <20200124232944.GD14914@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-10-will@kernel.org>
 <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com>
 <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
 <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAXXaH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 18:30:07 -0500
Content-Disposition: inline
In-Reply-To: <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>

On Fri, Jan 24, 2020 at 09:05:27AM -0800, Nick Desaulniers wrote:

> Ack. Do maintainers have tools for fetching patch series and
> automating collecting Reviewed-by tags, or is it all extremely manual?

Both; I'm currently still doing it manually, but I know that for example
Thomas's scripts are a lot smarter and do it for him.

I'm meaning to switch to his scripts, but I suppose there's some inertia
at play :-)
