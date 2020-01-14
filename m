From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
Date: Tue, 14 Jan 2020 13:39:14 -0800
Message-ID: <20200114213914.198223-1-ndesaulniers@google.com>
References: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33237 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVjR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 16:39:17 -0500
Received: by mail-pf1-f201.google.com with SMTP id c72so9560259pfc.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:39:16 -0800 (PST)
In-Reply-To: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: borntraeger@de.ibm.com, kernel-team@android.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, luc.vanoostenryck@gmail.com, mpe@ellerman.id.au, peterz@infradead.org, segher@kernel.crashing.org, torvalds@linux-foundation.org, will@kernel.org, masahiroy@kernel.org

On Fri, Jan 10, 2020 at 06:35:02PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> >
> > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > discarding the 'volatile' qualifier:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > We've been working around this using some nasty hacks which make
> > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > kernel builds now, emit a warning if we detect it during the build.
> 
> No objection to recommending gcc-4.8, but I think this should either
> just warn once during the kernel build instead of for every file, or
> it should become a hard requirement.

Yeah, hard requirement sounds good to me. Arnd, do you have stats on which
distros have which versions of GCC (IIRC, you had some stats for the GCC 4.6
upgrade)? This allows us to clean up more cruft in the kernel (grep for
GCC_VERSION).

Will, Documentation/process/changes.rst should also be modified.

Android is still using GCC 4.9 (which is more like GCC 4.8 plus patches), but
I've been actively moving them (to Clang) over the past 2 years. I'll check
with our other internal distro's and give them a heads up.
