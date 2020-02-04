From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Date: Tue, 4 Feb 2020 11:35:30 -0800
Message-ID: <CAFd5g44ZG+E==gT24w49oKc6nHv4nBQFeipikKxXJH3oHdO99Q@mail.gmail.com>
References: <20200130230812.142642-1-brendanhiggins@google.com> <20200204071915.AF32B21582@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200204071915.AF32B21582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Maguire <alan.maguire@oracle.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>, Frank Rowand <frowand.list@gmail.com>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com, Shuah Khan <skhan@linuxfoundation.org>, Iurii Zaikin <yzaikin@google.com>, Greg KH <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-d>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 3, 2020 at 11:19 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-30 15:08:05)
> > ## TL;DR
> >
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.
>
> Is there any diff from v1 to v2? I don't know what changed, but I see
> that my Reviewed-by tag has been put on everything, so I guess
> everything I said was addressed or discussed in the previous round.

Oh yes, sorry about that. I have gotten a bit lazy in regard to
changing logs. I noticed that a lot of people don't seem to care. I'll
make a note that you do.

Changes since last revision:
- On patch 6/7, I flipped the include order and removed braces from the if
  statements.
- On patch 7/7, I removed the periods from the short descriptions.
