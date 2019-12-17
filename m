From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 2/6] arch: um: add linker section for KUnit test suites
Date: Tue, 17 Dec 2019 00:21:34 -0800
Message-ID: <20191217082134.DAC792072D@mail.kernel.org>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-3-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216220555.245089-3-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

Quoting Brendan Higgins (2019-12-16 14:05:51)
> Add a linker section to UML where KUnit can put references to its test
> suites. This patch is an early step in transitioning to dispatching all
> KUnit tests from a centralized executor rather than having each as its
> own separate late_initcall.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
