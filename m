From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 6/6] kunit: Add 'kunit_shutdown' option
Date: Tue, 17 Dec 2019 00:06:53 -0800
Message-ID: <20191217080653.B672B2082E@mail.kernel.org>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-7-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216220555.245089-7-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

Quoting Brendan Higgins (2019-12-16 14:05:55)
> From: David Gow <davidgow@google.com>
>=20
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  lib/kunit/executor.c                | 18 ++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  3 files changed, 20 insertions(+), 2 deletions(-)

Can you document it in Documentation/admin-guide/kernel-parameters.txt ?
