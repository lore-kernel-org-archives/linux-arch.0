From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v3 1/7] vmlinux.lds.h: add linker section for KUnit test suites
Date: Thu, 27 Feb 2020 23:22:31 -0800
Message-ID: <CAFd5g46dVaV18=5mPLTHh06KQ6nDh4Xw4r8PAZDfSXASi=Qpmg@mail.gmail.com>
References: <20200228012036.15682-1-brendanhiggins@google.com> <20200228012036.15682-2-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200228012036.15682-2-brendanhiggins@google.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Frank Rowand <frowand.list@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit-dev@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 27, 2020 at 5:20 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add a linker section where KUnit can put references to its test suites.
> This patch is the first step in transitioning to dispatching all KUnit
> tests from a centralized executor rather than having each as its own
> separate late_initcall.
>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4f..99a866f49cb3d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -856,6 +856,13 @@
>                 KEEP(*(.con_initcall.init))                             \
>                 __con_initcall_end = .;
>
> +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> +#define KUNIT_TEST_SUITES                                              \
> +               . = ALIGN(8);                                           \

After posting this, I saw I had gotten an email from 0day[1]. After
some investigation, I discovered that this 8 byte alignment works for
x86 64 bit fine, but only *sometimes* for 32 bit. 4 byte alignment
seems to work in all cases (so far). I am not sure why we went with
such a large alignment in hindsight. In any case, I should have a
fixed revision out pretty soon.

> +               __kunit_suites_start = .;                               \
> +               KEEP(*(.kunit_test_suites))                             \
> +               __kunit_suites_end = .;
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS                                                    \
>         . = ALIGN(4);                                                   \
> @@ -1024,6 +1031,7 @@
>                 INIT_CALLS                                              \
>                 CON_INITCALL                                            \
>                 INIT_RAM_FS                                             \
> +               KUNIT_TEST_SUITES                                       \
>         }
>
>  #define BSS_SECTION(sbss_align, bss_align, stop_align)                 \
> --

[1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/4I4UW4OAT63ETMIEUJQTOF3BFTMO6ROD/
