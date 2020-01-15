From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
Date: Wed, 15 Jan 2020 11:49:03 +0100
Message-ID: <CAK8P3a3JfUjm88CLqkvAmCoEA1FsmQ33sfHGK4=Y5iuhWxet5Q@mail.gmail.com>
References: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
 <20200114213914.198223-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:32843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOKtW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 05:49:22 -0500
In-Reply-To: <20200114213914.198223-1-ndesaulniers@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Android Kernel Team <kernel-team@android.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>

On Tue, Jan 14, 2020 at 10:39 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 10, 2020 at 06:35:02PM +0100, Arnd Bergmann wrote:
> > On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > > discarding the 'volatile' qualifier:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > >
> > > We've been working around this using some nasty hacks which make
> > > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > > kernel builds now, emit a warning if we detect it during the build.
> >
> > No objection to recommending gcc-4.8, but I think this should either
> > just warn once during the kernel build instead of for every file, or
> > it should become a hard requirement.
>
> Yeah, hard requirement sounds good to me. Arnd, do you have stats on which
> distros have which versions of GCC (IIRC, you had some stats for the GCC 4.6
> upgrade)? This allows us to clean up more cruft in the kernel (grep for
> GCC_VERSION).

This is the list that Kirill and I came up with in the thread I linked to

> - Debian 8.0 Jessie has 4.9.2, EOL 2020-05
> - Ubuntu 14.04 LTS Trusty has 4.8.2, EOL 2019-04;
> - Fedora 21 has 4.9.2, EOL 2015-12;
> - OpenSUSE 42.3 has 4.8.5, EOL 2019-06;
> - RHEL 7.7 has 4.8.5, EOL 2024-06;
> - RHEL 6.9 has 4.4.7, EOL 2020-11;
> - SUSE 12-SP4 has 4.8.6, EOL 2024, extended support 2027
> - Oracle 7.6 has 4.8.5, EOL ?;
> - Slackware 14.1 (no EOL announced): gcc-4.8

In an older thread about moving to gcc-4.3 or 4.6 as a minimum,
this were the even older distros:

> - RHEL 5.x has 4.1; extended support EOL 2020
> - SLES11 had gcc-4.3; extended support EOL 2022
> - Debian  Wheezy (oldoldstable) had gcc-4.6, EOL 2018.
> - OpenWRT 12.07 Attitude Adjustment had gcc-4.6
>    and is still used with devices that have only 4MB flash / 32 MB RAM

      Arnd
