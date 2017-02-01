From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] initity: try to improve __nocapture annotations
Date: Wed, 1 Feb 2017 22:05:15 +0100
Message-ID: <CAJZ5v0ioJO1HU6yRpuX70hVQB-P9Sx1SkyRiH+hL0mw0_qX3MQ@mail.gmail.com>
References: <20170201161311.2050831-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170201161311.2050831-1-arnd@arndb.de>
Sender: owner-linux-mm@kvack.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>, pageexec@freemail.hu, Emese Revfy <re.emese@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, yamada.masahiro@socionext.com, minipli@ld-linux.so, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, Linux Memory Management List <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 1, 2017 at 5:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> There are some additional declarations that got missed in the original patch,
> and some annotated functions that use the pointer is a correct but nonobvious
> way:
>
> mm/kasan/kasan.c: In function 'memmove':
> mm/kasan/kasan.c:346:7: error: 'memmove' captures its 2 ('src') parameter, please remove it from the nocapture attribute. [-Werror]
>  void *memmove(void *dest, const void *src, size_t len)
>        ^~~~~~~
> mm/kasan/kasan.c: In function 'memcpy':
> mm/kasan/kasan.c:355:7: error: 'memcpy' captures its 2 ('src') parameter, please remove it from the nocapture attribute. [-Werror]
>  void *memcpy(void *dest, const void *src, size_t len)
>        ^~~~~~
> drivers/acpi/acpica/utdebug.c: In function 'acpi_debug_print':
> drivers/acpi/acpica/utdebug.c:158:1: error: 'acpi_debug_print' captures its 3 ('function_name') parameter, please remove it from the nocapture attribute. [-Werror]
>
> lib/string.c:893:7: error: 'memchr_inv' captures its 1 ('start') parameter, please remove it from the nocapture attribute. [-Werror]
>  void *memchr_inv(const void *start, int c, size_t bytes)
> lib/string.c: In function 'strnstr':
> lib/string.c:832:7: error: 'strnstr' captures its 1 ('s1') parameter, please remove it from the nocapture attribute. [-Werror]
>  char *strnstr(const char *s1, const char *s2, size_t len)
>        ^~~~~~~
> lib/string.c:832:7: error: 'strnstr' captures its 2 ('s2') parameter, please remove it from the nocapture attribute. [-Werror]
>
> I'm not sure if these are all appropriate fixes, please have a careful look
>
> Fixes: c2bc07665495 ("initify: Mark functions with the __nocapture attribute")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/acpica/utdebug.c        | 2 +-
>  include/acpi/acpixf.h                | 2 +-
>  include/asm-generic/asm-prototypes.h | 8 ++++----
>  include/linux/string.h               | 2 +-
>  lib/string.c                         | 2 +-
>  mm/kasan/kasan.c                     | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
> index 044df9b0356e..de3c9cb305a2 100644
> --- a/drivers/acpi/acpica/utdebug.c
> +++ b/drivers/acpi/acpica/utdebug.c
> @@ -154,7 +154,7 @@ static const char *acpi_ut_trim_function_name(const char *function_name)
>   *
>   ******************************************************************************/
>
> -void ACPI_INTERNAL_VAR_XFACE
> +void __unverified_nocapture(3) ACPI_INTERNAL_VAR_XFACE

Generally speaking, there is a problem with adding annotations like
this to ACPICA code.

We get that code from an external project (upstream ACPICA) and the
more Linux-specific stuff is there in it, the more difficult to
maintain it becomes.

Thanks,
Rafael

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
