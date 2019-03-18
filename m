From: Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH v11 03/14] lib, arm64: untag user pointers in strn*_user
Date: Mon, 18 Mar 2019 11:33:14 +0000
Message-ID: <5de82e7d-6091-e694-8397-fbcfd59f9d0b__29180.413430889$1552908887$gmane$org@arm.com>
References: <cover.1552679409.git.andreyknvl@google.com>
 <f7fa36ec55ed4b45f61d841f9b726772a04cc0a5.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f7fa36ec55ed4b45f61d841f9b726772a04cc0a5.1552679409.git.andreyknvl@google.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrey Konovalov <andreyknvl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-arm-kernel@lists.infradead.orglin
Cc: Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
List-Id: linux-arch.vger.kernel.org

On 15/03/2019 19:51, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
>
> strncpy_from_user and strnlen_user accept user addresses as arguments, and
> do not go through the same path as copy_from_user and others, so here we
> need to handle the case of tagged user addresses separately.
>
> Untag user pointers passed to these functions.
>
> Note, that this patch only temporarily untags the pointers to perform
> validity checks, but then uses them as is to perform user memory accesses.

Thank you for this new version, looks good to me.

To give a bit of context to the readers, I asked Andrey to make this change, because 
it makes a difference with hardware memory tagging. Indeed, in that situation, it is 
always preferable to access the memory using the user-provided tag, so that tag 
checking can take place; if there is a mismatch, a tag fault will occur (which is 
handled in a way similar to a page fault). It is also preferable not to assume that 
an untagged user pointer (tag 0x0) bypasses tag checks.

Kevin

>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>   lib/strncpy_from_user.c | 3 ++-
>   lib/strnlen_user.c      | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 58eacd41526c..6209bb9507c7 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -6,6 +6,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/kernel.h>
>   #include <linux/errno.h>
> +#include <linux/mm.h>
>   
>   #include <asm/byteorder.h>
>   #include <asm/word-at-a-time.h>
> @@ -107,7 +108,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
>   		return 0;
>   
>   	max_addr = user_addr_max();
> -	src_addr = (unsigned long)src;
> +	src_addr = (unsigned long)untagged_addr(src);
>   	if (likely(src_addr < max_addr)) {
>   		unsigned long max = max_addr - src_addr;
>   		long retval;
> diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> index 1c1a1b0e38a5..8ca3d2ac32ec 100644
> --- a/lib/strnlen_user.c
> +++ b/lib/strnlen_user.c
> @@ -2,6 +2,7 @@
>   #include <linux/kernel.h>
>   #include <linux/export.h>
>   #include <linux/uaccess.h>
> +#include <linux/mm.h>
>   
>   #include <asm/word-at-a-time.h>
>   
> @@ -109,7 +110,7 @@ long strnlen_user(const char __user *str, long count)
>   		return 0;
>   
>   	max_addr = user_addr_max();
> -	src_addr = (unsigned long)str;
> +	src_addr = (unsigned long)untagged_addr(str);
>   	if (likely(src_addr < max_addr)) {
>   		unsigned long max = max_addr - src_addr;
>   		long retval;
