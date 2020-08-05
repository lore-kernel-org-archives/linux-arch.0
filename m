Return-Path: <SRS0=VHN+=BP=vger.kernel.org=linux-doc-owner@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200804204745.987648-6-brendanhiggins@google.com>
References: <20200804204745.987648-1-brendanhiggins@google.com> <20200804204745.987648-6-brendanhiggins@google.com>
Subject: Re: [PATCH v6 5/5] Documentation: kunit: add a brief blurb about kunit_test_suite
From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 04 Aug 2020 23:01:01 -0700
Message-ID: <159660726105.1360974.11438808412702251122@swboyd.mtv.corp.google.com>
Sender: linux-doc-owner@vger.kernel.org
To: akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200805060101.xOcducnkmgkmYrv8g_wWWgMQ0cT_j1t-eyS-Pr79JSQ@z>

Quoting Brendan Higgins (2020-08-04 13:47:45)
> Add a brief blurb saying how and when the kunit_test_suite() macro
> works to the usage documentation.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 3c3fe8b5feccf..961d3ea3ca19a 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -211,6 +211,11 @@ KUnit test framework.
>  .. note::
>     A test case will only be run if it is associated with a test suite.
> =20
> +``kunit_test_suite(...)`` is a macro which tells the linker to put the s=
pecified
> +test suite in a special linker section so that it can be run by KUnit ei=
ther
> +after late_init, or when the test module is loaded (depending on whether=
 the

"late_init" probably needs some italics or something, but otherwise.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
