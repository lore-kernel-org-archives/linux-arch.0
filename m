From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
Date: Tue, 28 Jan 2020 22:27:08 -0800
Message-ID: <20200129062709.5B2A22067C@mail.kernel.org>
References: <20200128072002.79250-1-brendanhiggins@google.com> <20200128072002.79250-8-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200128072002.79250-8-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

Quoting Brendan Higgins (2020-01-27 23:20:02)
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index ade4e6ec23e03..0472b02ce16bb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2054,6 +2054,13 @@
>                         0: force disabled
>                         1: force enabled
> =20
> +       kunit_shutdown  [KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel a=
fter
> +                       running tests.
> +                       Default:        (flag not present) don't shutdown
> +                       poweroff:       poweroff the kernel after running=
 tests.
> +                       halt:           halt the kernel after running tes=
ts.
> +                       reboot:         reboot the kernel after running t=
ests.

Maybe drop the full stops on the short descriptions.

Otherwise,

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
