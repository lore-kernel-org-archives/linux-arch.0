Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfLQISp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 03:18:45 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216220555.245089-6-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-6-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 5/6] kunit: test: add test plan to KUnit TAP format
Date: Tue, 17 Dec 2019 00:18:44 -0800
Message-ID: <20191217081845.141F4206A5@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
Message-ID: <20191217081844.vqMf7lL9z6o6Ou18DSkd2DgJLQzfHgTWa7lACjNrzYo@z>

Quoting Brendan Higgins (2019-12-16 14:05:54)
> TAP 14 allows an optional test plan to be emitted before the start of
> the start of testing[1]; this is valuable because it makes it possible
> for a test harness to detect whether the number of tests run matches the
> number of tests expected to be run, ensuring that no tests silently
> failed.
>=20
> Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-=
version-14-specification.md#the-plan
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
