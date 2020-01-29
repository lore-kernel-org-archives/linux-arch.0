From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 3/7] kunit: test: create a single centralized executor for all tests
Date: Tue, 28 Jan 2020 22:38:16 -0800
Message-ID: <20200129063817.3E1BA2064C@mail.kernel.org>
References: <20200128072002.79250-1-brendanhiggins@google.com> <20200128072002.79250-4-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200128072002.79250-4-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

Quoting Brendan Higgins (2020-01-27 23:19:58)
> From: Alan Maguire <alan.maguire@oracle.com>
>=20
> Add a centralized executor to dispatch tests rather than relying on
> late_initcall to schedule each test suite separately.  Centralized
> execution is for built-in tests only; modules will execute tests
> when loaded.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
