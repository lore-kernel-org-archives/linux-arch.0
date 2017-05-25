From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 6/6] kernel.h: handle pointers to arrays better in container_of()
Date: Thu, 25 May 2017 11:35:42 -0700
Message-ID: <CAGXu5jJvNBEi07=VDtvhC4+p6NAv21y09DCUuxry7o-9=JzcrQ@mail.gmail.com>
References: <20170525120316.24473-1-abbotti@mev.co.uk> <20170525120316.24473-7-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170525120316.24473-7-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 25, 2017 at 5:03 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
> If the first parameter of container_of() is a pointer to a
> non-const-qualified array type (and the third parameter names a
> non-const-qualified array member), the local variable __mptr will be
> defined with a const-qualified array type.  In ISO C, these types are
> incompatible.  They work as expected in GNU C, but some versions will
> issue warnings.  For example, GCC 4.9 produces the warning
> "initialization from incompatible pointer type".
>
> Here is an example of where the problem occurs:
>
> -------------------------------------------------------
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>
> MODULE_LICENSE("GPL");
>
> struct st {
>         int a;
>         char b[16];
> };
>
> static int __init example_init(void) {
>         struct st t =3D { .a =3D 101, .b =3D "hello" };
>         char (*p)[16] =3D &t.b;
>         struct st *x =3D container_of(p, struct st, b);
>         printk(KERN_DEBUG "%p %p\n", (void *)&t, (void *)x);
>         return 0;
> }
>
> static void __exit example_exit(void) {
> }
>
> module_init(example_init);
> module_exit(example_exit);
> -------------------------------------------------------
>
> Building the module with gcc-4.9 results in these warnings (where '{m}'
> is the module source and '{k}' is the kernel source):
>
> -------------------------------------------------------
> In file included from {m}/example.c:1:0:
> {m}/example.c: In function =E2=80=98example_init=E2=80=99:
> {k}/include/linux/kernel.h:854:48: warning: initialization from
> incompatible pointer type
>   const typeof( ((type *)0)->member ) *__mptr =3D (ptr); \
>                                                 ^
> {m}/example.c:14:17: note: in expansion of macro =E2=80=98container_of=E2=
=80=99
>   struct st *x =3D container_of(p, struct st, b);
>                  ^
> {k}/include/linux/kernel.h:854:48: warning: (near initialization for
> =E2=80=98x=E2=80=99)
>   const typeof( ((type *)0)->member ) *__mptr =3D (ptr); \
>                                                 ^
> {m}/example.c:14:17: note: in expansion of macro =E2=80=98container_of=E2=
=80=99
>   struct st *x =3D container_of(p, struct st, b);
>                  ^
> -------------------------------------------------------
>
> Replace the type checking performed by the macro to avoid these
> warnings.  Make sure `*(ptr)` either has type compatible with the
> member, or has type compatible with `void`, ignoring qualifiers.  Raise
> compiler errors if this is not true.  This is stronger than the previous
> behaviour, which only resulted in compiler warnings for a type mismatch.
>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Nazarewicz <mina86@mina86.com>
> Cc: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexander Potapenko <glider@google.com>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>

Seems reasonable to me. I think this actually improves the errors
reported when something is mismatched in container_of(). Silly
question: does this pass an allyesconfig?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> v2: Rebased and altered description to provide an example of when the
> compiler warnings occur.  v1 (from 2016-10-10) also modified a
> 'container_of_safe()' macro that never made it out of "linux-next".
> v3: Added back some type checking at the suggestion of Michal
> Nazarewicz with some helpful hints by Peter Zijlstra.
> v4: No change.
> v5: Added Acked-by for Michal Nazarewicz.  Included <linux/build_bug.h>
> instead of <linux/bug.h> to avoid a circular dependency that resulted in
> build failures when <asm/bug.h> was included before <linux/kernel.h>.
> ---
>  include/linux/kernel.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 13bc08aba704..1c9c11c9f1a8 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/typecheck.h>
>  #include <linux/printk.h>
> +#include <linux/build_bug.h>
>  #include <asm/byteorder.h>
>  #include <uapi/linux/kernel.h>
>
> @@ -850,9 +851,11 @@ static inline void ftrace_dump(enum ftrace_dump_mode=
 oops_dump_mode) { }
>   * @member:    the name of the member within the struct.
>   *
>   */
> -#define container_of(ptr, type, member) ({                     \
> -       const typeof( ((type *)0)->member ) *__mptr =3D (ptr);    \
> -       (type *)( (char *)__mptr - offsetof(type,member) );})
> +#define container_of(ptr, type, member) ({                             \
> +       BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
> +                        !__same_type(*(ptr), void),                    \
> +                        "pointer type mismatch in container_of()");    \
> +       ((type *)((char *)(ptr) - offsetof(type, member))); })
>
>  /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
> --
> 2.11.0
>



--=20
Kees Cook
Pixel Security
