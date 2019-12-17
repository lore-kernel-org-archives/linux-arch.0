Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfLQH6h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 02:58:37 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216220555.245089-5-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-5-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 4/6] init: main: add KUnit to kernel init
Date: Mon, 16 Dec 2019 23:58:36 -0800
Message-ID: <20191217075836.C76942072D@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
Message-ID: <20191217075836.Kn7zHur6QBeQc91QPhb8X41r4v7DFXT2N1xlUJgjg6Q@z>

Quoting Brendan Higgins (2019-12-16 14:05:53)
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().

Yes, but why? Is it desired to run the unit tests earlier than opening
the console or something?

>=20
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 978086cfd257d..ca880224c0bab 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
>         return !has_test_failed;
>  }
> =20
> -static int kunit_executor_init(void)
> +int kunit_executor_init(void)

Should be marked __init? Even before this patch presumably.

>  {
>         if (kunit_run_all_tests())
>                 return 0;
>         else
>                 return -EFAULT;
>  }
> -
> -late_initcall(kunit_executor_init);
