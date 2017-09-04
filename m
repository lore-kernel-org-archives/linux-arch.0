From: Kees Cook <keescook@chromium.org>
Subject: Re: [tip:locking/core] locking/refcount: Create unchecked atomic_t implementation
Date: Mon, 4 Sep 2017 10:11:37 -0700
Message-ID: <CAGXu5jJdpFk0GNWiw6sswthf3=gAptmLi6xmQqMvUigUYDFsQg@mail.gmail.com>
References: <20170621200026.GA115679@beast> <tip-fd25d19f6b8da315332bb75936605fb45d3ea981@git.kernel.org>
 <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, Manfred Spraul <manfred@colorfullife.com>, Rik van Riel <riel@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Eric Biggers <ebiggers3@gmail.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, Alexey Dobriyan <adobriyan@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Hans Liljestrand <ishkamiel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-founda>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 4, 2017 at 5:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jun 28, 2017 at 09:58:15AM -0700, tip-bot for Kees Cook wrote:
>> locking/refcount: Create unchecked atomic_t implementation
>
> This seems to do only half the job. Here's the rest.
>
> ---
> Subject: locking/refcount: Finish unchecked atomic_t implementation
>
> For some reason the unchecked atomic_t implementation stopped half-way
> through, complete it it.

Hmm? The reason is that the implementation of the remaining functions
is unchanged between full, unchecked, and x86.

>
> Fixes: fd25d19f6b8d ("locking/refcount: Create unchecked atomic_t implementation")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/refcount.h | 35 ++++++++++++++++++++++++++++++-----
>  lib/Makefile             |  7 +++----
>  lib/refcount.c           |  3 ---
>  3 files changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index 48b7c9c68c4d..ef714e4347d9 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -52,10 +52,17 @@ extern __must_check bool refcount_sub_and_test(unsigned int i, refcount_t *r);
>
>  extern __must_check bool refcount_dec_and_test(refcount_t *r);
>  extern void refcount_dec(refcount_t *r);
> +
> +extern __must_check bool refcount_dec_if_one(refcount_t *r);
> +extern __must_check bool refcount_dec_not_one(refcount_t *r);
> +extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
> +extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
> +
>  #else
>  # ifdef CONFIG_ARCH_HAS_REFCOUNT
>  #  include <asm/refcount.h>
>  # else
> +
>  static inline __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r)
>  {
>         return atomic_add_unless(&r->refs, i, 0);
> @@ -90,12 +97,30 @@ static inline void refcount_dec(refcount_t *r)
>  {
>         atomic_dec(&r->refs);
>  }
> +
> +static inline __must_check bool refcount_dec_if_one(refcount_t *r)
> +{
> +       int val = 1;
> +
> +       return atomic_try_cmpxchg_release(&r->refs, &val, 0);
> +}
> +
> +static inline __must_check bool refcount_dec_not_one(refcount_t *r)
> +{
> +       return atomic_add_unless(&r->refs, -1, 1);
> +}
> +
> +static inline __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
> +{
> +       return atomic_dec_and_mutex_lock(&r->refs, lock);
> +}
> +
> +static inline __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
> +{
> +       return atomic_dec_and_lock(&r->refs, lock);
> +}
> +
>  # endif /* !CONFIG_ARCH_HAS_REFCOUNT */
>  #endif /* CONFIG_REFCOUNT_FULL */
>
> -extern __must_check bool refcount_dec_if_one(refcount_t *r);
> -extern __must_check bool refcount_dec_not_one(refcount_t *r);
> -extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
> -extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
> -
>  #endif /* _LINUX_REFCOUNT_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index 40c18372b301..b96859e69c57 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -38,12 +38,11 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
>          gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
>          bsearch.o find_bit.o llist.o memweight.o kfifo.o \
>          percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o \
> -        once.o refcount.o usercopy.o errseq.o
> -obj-y += string_helpers.o
> +        once.o usercopy.o errseq.o string_helpers.o hexdump.o kstrtox.o
> +
> +obj-$(CONFIG_REFCOUNT_FULL) += refcount.o
>  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
> -obj-y += hexdump.o
>  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> -obj-y += kstrtox.o
>  obj-$(CONFIG_TEST_BPF) += test_bpf.o
>  obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
>  obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
> diff --git a/lib/refcount.c b/lib/refcount.c
> index 5d0582a9480c..9f906783987e 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -37,8 +37,6 @@
>  #include <linux/refcount.h>
>  #include <linux/bug.h>
>
> -#ifdef CONFIG_REFCOUNT_FULL
> -
>  /**
>   * refcount_add_not_zero - add a value to a refcount unless it is 0
>   * @i: the value to add to the refcount
> @@ -227,7 +225,6 @@ void refcount_dec(refcount_t *r)
>         WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
>  }
>  EXPORT_SYMBOL(refcount_dec);
> -#endif /* CONFIG_REFCOUNT_FULL */
>
>  /**
>   * refcount_dec_if_one - decrement a refcount if it is 1



-- 
Kees Cook
Pixel Security
