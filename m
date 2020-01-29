Return-Path: <SRS0=sBCo=3S=vger.kernel.org=linux-doc-owner@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200128072002.79250-5-brendanhiggins@google.com>
References: <20200128072002.79250-1-brendanhiggins@google.com> <20200128072002.79250-5-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 4/7] init: main: add KUnit to kernel init
Date: Tue, 28 Jan 2020 22:38:35 -0800
Message-ID: <20200129063836.6C2A62064C@mail.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200129063835._Q9bk1sVduyu53NH1e-jfVwIKEd1owjxj4yFGPH6BkY@z>

Quoting Brendan Higgins (2020-01-27 23:19:59)
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
>=20
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Although, why can't it be squashed with the previous patch?
