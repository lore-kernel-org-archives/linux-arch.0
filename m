From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
Date: Wed, 29 Jan 2020 13:28:19 -0800
Message-ID: <CAFd5g477pGY7vkYK7qTtstxpCv0NG9=11Nig=kSo1JX8vczRVA@mail.gmail.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com> <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com> <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com> <alpine.LRH.2.20.2001291006570.13921@dhcp-10-175-173-43.vpn.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40017 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgA2V2b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jan 2020 16:28:31 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so371292pjb.5
        for <linux-arch@vger.kernel.org>; Wed, 29 Jan 2020 13:28:31 -0800 (PST)
In-Reply-To: <alpine.LRH.2.20.2001291006570.13921@dhcp-10-175-173-43.vpn.oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux

On Wed, Jan 29, 2020 at 5:07 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Tue, 28 Jan 2020, Frank Rowand wrote:
>
> > On 1/28/20 1:19 AM, Brendan Higgins wrote:
> > > On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > >>
> > >> On 1/23/20 4:40 PM, Brendan Higgins wrote:
> > >>> Sorry for the late reply. I am still catching up from being on vacation.
> > >>>>> On Mon, Jan 6, 2020 at 2:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >>>> It does beg the question if this means kunit is happy to not be a tool
> > >>>> to test pre basic setup stuff (terminology used in init.c, meaning prior
> > >>>> to running all init levels). I suspect this is the case.
> > >>>
> > >>> Not sure. I still haven't seen any cases where this is necessary, so I
> > >>> am not super worried about it. Regardless, I don't think this patchset
> > >>> really changes anything in that regard, we are moving from late_init
> > >>> to after late_init, so it isn't that big of a change for most use
> > >>> cases.
> > >>>
> > >>> Please share if you can think of some things that need to be tested in
> > >>> early init.
> > >>
> > >> I don't have a specific need for this right now.  I had not thought about
> > >> how the current kunit implementation forces all kunit tests to run at a
> > >> specific initcall level before reading this email thread.
> > >>
> > >> I can see the value of being able to have some tests run at different
> > >> initcall levels to verify what functionality is available and working
> > >> at different points in the boot sequence.
> > >
> > > Let's cross that bridge when we get there. It should be fairly easy to
> > > add that functionality.
> >
> > Yes. I just wanted to add the thought to the back of your mind so that
> > it does not get precluded by future changes to the kunit architecture.
> >
> > >
> > >> But more important than early initcall levels, I do not want the
> > >> framework to prevent using or testing code and data that are marked
> > >> as '__init'.  So it is important to retain a way to invoke the tests
> > >> while __init code and data are available, if there is also a change
> > >> to generally invoke the tests later.
> > >
> > > Definitely. For now that still works as long as you don't build KUnit
> > > as a module, but I think Alan's new patches which allow KUnit to be
> > > run at runtime via debugfs could cause some difficulty there. Again,
> >
> > Yes, Alan's patches are part of what triggered me thinking about the
> > issues I raised.
> >
> >
>
> As Brendan says, any such tests probably shouldn't be buildable
> as modules, but I wonder if we need to add some sort of way
> to ensure execution from debugfs is not allowed for such cases?
> Even if a test suite is builtin, it can be executed via debugfs
> in the patches I sent out, allowing suites to be re-run.  Sounds
> like we need a way to control that behaviour based on the
> desired test suite execution environment.

I think that's true.

> Say, for example, the "struct kunit_suite" definitions associated
> with the tests was marked as __initdata; are there any handy macros to
> identify it as being in the __init section? If so, we could simply
> avoid adding a "run" file to the debugfs representation for such
> suites.  Failing that, perhaps we need some sort of flags field
> in "struct kunit_suite" to specify execution environment constraints?

I think the former would be ideal, but the latter is acceptable as
well, assuming neither results in complaints from the compiler (I
guess we will find out for sure once we get a hold of the device tree
KUnit test).

Luis, you mentioned your linker table work might be applicable for
dynamic post boot configuring of dispatching. Do you think this work
could help solve this problem?

For reference, Alan's debugfs code can be found here:

https://lore.kernel.org/linux-kselftest/CAFd5g46657gZ36PaP8Pi999hPPgBU2Kz94nrMspS-AzGwdBF+g@mail.gmail.com/T/#m210cadbeee267e5c5a9253d83b7b7ca723d1f871
