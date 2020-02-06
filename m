From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 5/7] kunit: test: add test plan to KUnit TAP format
Date: Thu, 6 Feb 2020 10:47:28 -0800
Message-ID: <CAFd5g45jHKXoMU4k103cqfeTAtUpaZh7ZK2ALpzHkRZTuVYa-g@mail.gmail.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-6-brendanhiggins@google.com> <69582db9-d379-7d2a-1342-6de9a5d79141@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <69582db9-d379-7d2a-1342-6de9a5d79141@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@goo>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 4, 2020 at 3:01 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> > TAP 14 allows an optional test plan to be emitted before the start of
> > the start of testing[1]; this is valuable because it makes it possible
> > for a test harness to detect whether the number of tests run matches the
> > number of tests expected to be run, ensuring that no tests silently
> > failed.
> >
> > Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  lib/kunit/executor.c                          | 17 +++++
> >  lib/kunit/test.c                              | 11 ---
> >  tools/testing/kunit/kunit_parser.py           | 74 ++++++++++++++++---
> >  .../test_is_test_passed-all_passed.log        |  1 +
> >  .../test_data/test_is_test_passed-crash.log   |  1 +
> >  .../test_data/test_is_test_passed-failure.log |  1 +
> >  6 files changed, 82 insertions(+), 23 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index b75a46c560847..7fd16feff157e 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -11,11 +11,28 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> > +static void kunit_print_tap_header(void)
> > +{
> > +     struct kunit_suite * const * const *suites, * const *subsuite;
> > +     int num_of_suites = 0;
> > +
> > +     for (suites = __kunit_suites_start;
> > +          suites < __kunit_suites_end;
> > +          suites++)
> > +             for (subsuite = *suites; *subsuite != NULL; subsuite++)
> > +                     num_of_suites++;
> > +
> > +     pr_info("TAP version 14\n");
> > +     pr_info("1..%d\n", num_of_suites);
> > +}
> > +
>
> Subsuites are not in Linux 5.5, as far as I can tell, so it is hard to review
> this.
>
> But I think this observation will still be valid even though I am not up
> to speed on subsuites.

"substitutes" are just an artifact from having to group together all
suites that occur in a module. It should be mostly immaterial to most
users, but we have to have all the suites that occur in a module
grouped together in order to support KUnit tests as loadable modules.

I just call them subsuites here because I didn't know what else to
call them. Still, the relationship between them should be mostly
ignored by users as you seem to recognize below.

Also, module support for KUnit was just recently accepted into torvalds/master:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08a3ef8f6b0b1341c670caba35f782c9a452d488

You should be able to apply this change to torvalds/master now.

> num_of_suites is all test suites declared (as built in).  In Linux 5.5,
> each kunit_suite contains one or more test cases.  Each test case leads
> to either "ok" or "not ok".  So instead of counting number of tests
> suites, the number of test cases needs to be counted.

Nope, but I think you understand correctly below...

> Ahhh, I think my lack of visibility of what tree this series is against
> is about to lead me astray!  Are the test cases in the subsuite
> implemented as what TAP 14 calls "subtests"?  If so, then the above
> code that counts suites instead of test cases would be correct.

Yep! You got it! Test cases are "subtests" in TAP 14. So there is a
ok/not ok line for each suite, and nested as subtests above that are
indented ok/not ok lines for each test case. KUnit already does this
today. We are just moving some of the printing logic out so we can
count the suites and print a test plan.

Technically, what we print today (before this change) is legal TAP 14.
The test plan is not required. However, the test plan is very helpful
as it makes it possible to know if some tests just never ran for some
reason.

> I'm spinning my wheels now, since I don't know what I am
> reviewing against, so I'm going to stop reviewing, other
> than maybe a quick scan.

I just applied this patch series against torvalds/master which I
pulled this morning, and it applied cleanly. I will specify in any
subsequent revisions that this is based on linux-kselftest/kunit since
that's where these patches will be applied, but they should apply
against any rc of 5.6 just fine once they are cut.

Cheers!
