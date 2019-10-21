From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2 2/8] objtool, kcsan: Add KCSAN runtime functions to whitelist
Date: Mon, 21 Oct 2019 17:15:18 +0200
Message-ID: <CACT4Y+b9VYz0wji085hvg3ZMMv6FR_WGc_NcEZETSOvME6hYOQ@mail.gmail.com>
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-3-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017141305.146193-3-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 17, 2019 at 4:13 PM Marco Elver <elver@google.com> wrote:
>
> This patch adds KCSAN runtime functions to the objtool whitelist.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  tools/objtool/check.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 044c9a3cb247..d1acc867b43c 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -466,6 +466,23 @@ static const char *uaccess_safe_builtin[] = {
>         "__asan_report_store4_noabort",
>         "__asan_report_store8_noabort",
>         "__asan_report_store16_noabort",
> +       /* KCSAN */
> +       "__kcsan_check_watchpoint",
> +       "__kcsan_setup_watchpoint",
> +       /* KCSAN/TSAN out-of-line */

There is no TSAN in-line instrumentation.

> +       "__tsan_func_entry",
> +       "__tsan_func_exit",
> +       "__tsan_read_range",

There is also __tsan_write_range(), right? Isn't it safer to add it right away?

> +       "__tsan_read1",
> +       "__tsan_read2",
> +       "__tsan_read4",
> +       "__tsan_read8",
> +       "__tsan_read16",
> +       "__tsan_write1",
> +       "__tsan_write2",
> +       "__tsan_write4",
> +       "__tsan_write8",
> +       "__tsan_write16",
>         /* KCOV */
>         "write_comp_data",
>         "__sanitizer_cov_trace_pc",
> --
> 2.23.0.866.gb869b98d4c-goog
>
