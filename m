Return-Path: <brendanhiggins@google.com>
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-3-brendanhiggins@google.com> <e060bdfc-5cdb-fb62-48b0-cc54c7bc72ce@gmail.com>
 <CAFd5g46irbQ7j_DOY+bQPoo1TWjwvu6n9iyQ7abe9pfqydeMYg@mail.gmail.com> <1da1538d-2e4c-0ed0-5fae-6f9033230c46@gmail.com>
In-Reply-To: <1da1538d-2e4c-0ed0-5fae-6f9033230c46@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Feb 2020 17:17:14 -0800
Message-ID: <CAFd5g45=m9Rvqf__5FW6HXjSytHJwX=mue-BO+TZMg0JP-BGmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] arch: um: add linker section for KUnit test suites
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>, David Gow <davidgow@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205011714.8OpvIzT87QVmTz1_6c5o_vcQJ8jA6t2cR1bmW4Z-754@z>

On Tue, Feb 4, 2020 at 3:17 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/4/20 4:30 PM, Brendan Higgins wrote:
> > On Tue, Feb 4, 2020 at 1:59 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> >>> Add a linker section to UML where KUnit can put references to its test
> >>> suites. This patch is an early step in transitioning to dispatching all
> >>> KUnit tests from a centralized executor rather than having each as its
> >>> own separate late_initcall.
> >>
> >> All architectures please.
> >
> > I *am* supporting all architectures with this patchset.
> >
> > The first patch in this series adds support to all architectures
> > except UML (admittedly I only tried x86 and ARM, 32 bit and 64 bit for
>
> Right you are.  My mind did not span from patch 1 to patch 2. Apologies for
> the noise.
>
>
> > both, but I am pretty sure someone tried it for POWER and something
> > else, so maybe I should try it with others before submission). A patch
> > specific for UML, this patch, was needed because UML is a special
> > snowflake and has a bunch of special linker scripts that don't make
> > the change in vmlinux.lds.h (the previous patch) sufficient.
> >
> >> The early versions of Kunit documented reliance on UML.  Discussion lead to
> >> the conclusion that real architectures and real hardware would be supported.
> >
> > I am *very* aware.
> >
> > I would never intentionally break support for other architectures. I
> > know it is very important to you, Alan, and others.
> >
> >> This like this are what make me reluctant to move devicetree unittests to
> >> KUnit.
> >
> > Hopefully I can reassure you then:
> >
> > With Alan as a regular contributor who cares very much about non-UML
> > architectures, it would be very unlikely for me to accidentally break
> > support for other architectures without us finding out before a
> > release.
> >
> > I also periodically test KUnit on linux-next on x86-64. I have gotten
> > bugs for other architectures from Arnd Bergmann and one of the m86k
> > maintainers who seems to play around with it as well.
> >
> > So yeah, other people care about this too, and I would really not want
> > to make any of them unhappy.
>
> Thanks for the extra reassurance.

No worries. This actually makes me think that we should probably have
some kind of automated test that at least makes sure that popular
KUnit architectures are not broken. Someone is currently adding KUnit
support to KernelCI; maybe we can have KernelCI run multiple
architecture tests after the initial support is complete.

> >> Can you please add a section to the KUnit documentation that lists things
> >> like the expectations, requirements, limitations, etc for a test case that
> >> is run by KUnit?  Some examples that pop to mind from recent discussions
> >> and my own experiences:
> >>
> >>   - Each test case is invoked after late_init is complete.
> >>       + Exception: the possible value of being able to run a unit test
> >>         at a specific runlevel has been expressed.  If an actual unit
> >>         test can be shown to require running earlier, this restriction
> >>         will be re-visited.
> >>
> >>   - Each test case must be idempotent.  Each test case may be called
> >>     multiple times, and must generate the same result each time it
> >>     is called.
> >>       + Exception 1: a test case can be declared to not be idempotent
> >>         [[ mechanism TBD ]], in which case KUnit will not call the
> >>         test case a second time without the kernel rebooting.
> >>       + Exception 2: hardware may not be deterministic, so a test that
> >>         always passes or fails when run under UML may not always to
> >>         so on real hardware.  <--- sentence copied from
> >>         Documentation/dev-tools/kunit/usage.rst
> >>           [[ This item and 1st exception do not exist yet, but will exist
> >>           in some form if the proposed proc filesystem interface is
> >>           added. ]]
> >>
> >>   - KUnit provides a helpful wrapper to simplify building a UML kernel
> >>     containing the KUnit test cases, booting the UML kernel, and
> >>     formatting the output from the test cases.  This wrapper MUST NOT
> >>     be required to run the test cases or to determine a test result.
> >>     The formatting may provide additional analysis and improve
> >>     readability of a test result.
> >>
> >>   - .... There is more that belongs here, but I'm getting side tracked
> >>     here, when I'm trying to instead convert devicetree unittests to
> >>     KUnit and want to get back to that.
> >
> > Sure, I think that's a great start! Thanks for that. I hope you don't
> > mind if I copy and paste some of it.
>
> Please do.  And no need to credit me.
>
>
> > It kind of sounds like you are talking about more of a requirements
> > doc than the design doc I was imagining in my reply to you on the
> > cover letter, which is fine. The documentation is primarily for people
> > other than me, so whatever you and others think is useful, I will do.
> >
>
> I wasn't really sure what to label it as.  My inspiration was based
> a little bit on reading through the Linux 5.5 KUnit source and
> documentation, and trying to understand the expectations of the
> KUnit framework and what the test cases have to either obey or
> can expect.
>
> I think there is a lot of history that you know, but is only visible
> to test implementors if they read through the past couple of years
> email threads.

Yeah, that's no good. We need to provide a better experience than
that. David has gotten deeply involved relatively recently: I suspect
that he might have some good insight on this.

David, you mentioned offline that there are some philosophical changes
in how we think about KUnit that has happened that you feel have never
quite been captured in the docs. Do you think this is part of what
Frank has pointed out here? If not, do you have any thoughts about
what we should call this documentation section?

Shuah's first KUnit PR seemed to imply that KUnit was primarily for
UML, or only fully supported under UML. So I think I might be the odd
one out thinking that that has changed and the documentation properly
conveys that.
