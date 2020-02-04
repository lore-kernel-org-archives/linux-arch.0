From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Date: Tue, 4 Feb 2020 14:01:33 -0800
Message-ID: <CAFd5g45MQqGLY2xCjAmJz4-xxHwBo9DBPphZdnQMHDe=d-2K_Q@mail.gmail.com>
References: <20200130230812.142642-1-brendanhiggins@google.com> <9e203718-dcca-3145-bc28-28979d41c278@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9e203718-dcca-3145-bc28-28979d41c278@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@goo>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 4, 2020 at 1:18 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> > ## TL;DR
> >
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.
>
> And the "couple of new features" are .... ?

Sorry, I thought I addressed that in the next section, specifically by
calling out: printing the test plan, and adding the new kernel command
line option. I will call these out here in any future cover letters.

> > ## What am I trying to do?
> >
> > Conceptually, I am trying to provide a mechanism by which test suites
> > can be grouped together so that they can be reasoned about collectively.
> > The last two of three patches in this series add features which depend
> > on this:
> >
> > PATCH 5/7 Prints out a test plan right before KUnit tests are run[1];
> >           this is valuable because it makes it possible for a test
> >           harness to detect whether the number of tests run matches the
> >           number of tests expected to be run, ensuring that no tests
> >           silently failed.
> >
> > PATCH 6/7 Add a new kernel command-line option which allows the user to
> >           specify that the kernel poweroff, halt, or reboot after
> >           completing all KUnit tests; this is very handy for running
> >           KUnit tests on UML or a VM so that the UML/VM process exits
> >           cleanly immediately after running all tests without needing a
> >           special initramfs.
> >
>
> > In addition, by dispatching tests from a single location, we can
> > guarantee that all KUnit tests run after late_init is complete, which
>
> That the tests will run after late init (and are guaranteed to do such)
> needs to be added to the documentation.

Yeah, that's reasonable. I am not sure where I should put this in the
documentation, however. This seems kind of a technical detail, and all
the pages I have now are more of how-tos, I think.

Maybe I should send a patch which adds a page detailing how KUnit works?

I would like to get some other people's thoughts on this. Such a
technical guide wouldn't provide me a lot of value, at least not now,
so I want to make sure that something like that would be valuable to
others.
