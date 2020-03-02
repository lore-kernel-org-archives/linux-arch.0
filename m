Return-Path: <brendanhiggins@google.com>
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200302200337.GH11244@42.do-not-panic.com> <20200302211640.GA8364@roeck-us.net>
In-Reply-To: <20200302211640.GA8364@roeck-us.net>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 2 Mar 2020 14:19:57 -0800
Message-ID: <CAFd5g452oaKojBZfvTYw-L14wTFqsjDeX4mtYDM=kv6xhcTnig@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Content-Type: text/plain; charset="UTF-8"
To: Guenter Roeck <linux@roeck-us.net>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Frank Rowand <frowand.list@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200302221957.JfaVIIfw-lQENIkI-uvSvXmQLRmvZzHTVL6jKGHZPaQ@z>

On Mon, Mar 2, 2020 at 1:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Mar 02, 2020 at 08:03:37PM +0000, Luis Chamberlain wrote:
> > Guenter,
> >
> > are you still running your cross-architecture tests? If so any chance
>
> Yes
>
> > you can try this for your build tests?
> >
>
> I didn't have KUNIT_TEST enabled to start with. I did that now, and
> started a test run on mainline a minute ago. We'll see how that goes.

FYI, kbuild already found some architectures for which this change doesn't work.

So far, I need to fix:
- arm64 (32 bit seems to work fine)
- i386 in some cases.

> Afterwards, sure, I can run the series in a test branch. It would be great
> if I can pick it up from a repository somewhere.

Cool, I will post my next revision to a branch somewhere.

Thanks!
