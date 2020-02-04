Return-Path: <sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch all KUnit tests
Date: Mon, 03 Feb 2020 23:19:14 -0800
Message-ID: <20200204071915.AF32B21582@mail.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200204071914.pBY6mNQ7XiZZUE68AqpwYYR19CZkYR1mYqFYJXThOKA@z>

Quoting Brendan Higgins (2020-01-30 15:08:05)
> ## TL;DR
>=20
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

Is there any diff from v1 to v2? I don't know what changed, but I see
that my Reviewed-by tag has been put on everything, so I guess
everything I said was addressed or discussed in the previous round.
