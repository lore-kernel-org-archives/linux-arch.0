From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v1 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
Date: Thu, 30 Jan 2020 15:04:47 -0800
Message-ID: <CAFd5g47cha8DJdS9x=Qjj-vLXjGOugQK38Ln85eznfuN11cLrQ@mail.gmail.com>
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-8-brendanhiggins@google.com> <20200129062709.5B2A22067C@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38148 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3XFA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 18:05:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so2265953pfc.5
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 15:05:00 -0800 (PST)
In-Reply-To: <20200129062709.5B2A22067C@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Maguire <alan.maguire@oracle.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>, Frank Rowand <frowand.list@gmail.com>, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com, Shuah Khan <skhan@linuxfoundation.org>, Iurii Zaikin <yzaikin@google.com>, Greg KH <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-d>

On Tue, Jan 28, 2020 at 10:27 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-27 23:20:02)
> > Add kunit_shutdown, an option to specify that the kernel shutsdown after
> > running KUnit tests, to the kernel-parameters.txt documentation.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index ade4e6ec23e03..0472b02ce16bb 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2054,6 +2054,13 @@
> >                         0: force disabled
> >                         1: force enabled
> >
> > +       kunit_shutdown  [KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> > +                       running tests.
> > +                       Default:        (flag not present) don't shutdown
> > +                       poweroff:       poweroff the kernel after running tests.
> > +                       halt:           halt the kernel after running tests.
> > +                       reboot:         reboot the kernel after running tests.
>
> Maybe drop the full stops on the short descriptions.

Will fix.

> Otherwise,
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>

Thanks!
