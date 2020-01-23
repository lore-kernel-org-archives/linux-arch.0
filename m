From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Date: Thu, 23 Jan 2020 11:07:59 -0800
Message-ID: <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123153341.19947-3-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
>
> nf_remove_net_hook() uses WRITE_ONCE() to assign a 'const pointer to a
> 'non-const' pointer. Cleanups to the implementation of WRITE_ONCE() mean
> that this will give rise to a compiler warning, just like a plain old
> assignment would do:
>
>   | In file included from ./include/linux/export.h:43,
>   |                  from ./include/linux/linkage.h:7,
>   |                  from ./include/linux/kernel.h:8,
>   |                  from net/netfilter/core.c:9:
>   | net/netfilter/core.c: In function =E2=80=98nf_remove_net_hook=E2=80=
=99:
>   | ./include/linux/compiler.h:216:30: warning: assignment discards =E2=
=80=98const=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualif=
iers]
>   |   *(volatile typeof(x) *)&(x) =3D (val);  \
>   |                               ^
>   | net/netfilter/core.c:379:3: note: in expansion of macro =E2=80=98WRIT=
E_ONCE=E2=80=99
>   |    WRITE_ONCE(orig_ops[i], &dummy_ops);
>   |    ^~~~~~~~~~
>
> Follow the pattern used elsewhere in this file and add a cast to 'void *'
> to squash the warning.
>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  net/netfilter/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netfilter/core.c b/net/netfilter/core.c
> index 78f046ec506f..3ac7c8c1548d 100644
> --- a/net/netfilter/core.c
> +++ b/net/netfilter/core.c
> @@ -376,7 +376,7 @@ static bool nf_remove_net_hook(struct nf_hook_entries=
 *old,
>                 if (orig_ops[i] !=3D unreg)
>                         continue;
>                 WRITE_ONCE(old->hooks[i].hook, accept_all);
> -               WRITE_ONCE(orig_ops[i], &dummy_ops);
> +               WRITE_ONCE(orig_ops[i], (void *)&dummy_ops);

Good thing it's the variable being modified was not declared const; I
get spooked when I see -Wdiscarded-qualifiers because of Section
6.7.3.6 of the ISO C11 draft spec:

```
If an attempt is made to modify an object defined with a
const-qualified type through use
of an lvalue with non-const-qualified type, the behavior is undefined.
If an attempt is
made to refer to an object defined with a volatile-qualified type
through use of an lvalue
with non-volatile-qualified type, the behavior is undefined.133)

133) This applies to those objects that behave as if they were defined
with qualified types, even if they are
never actually defined as objects in the program (such as an object at
a memory-mapped input/output
address).
```

Which is about the modification of a const-declared variable (explicit
UB which Clang actively exploits), and doesn't apply in this case.  I
agree that this is the best way to fix this due to the use of typeof()
and it's semantics of dropping qualifiers; declaring `dummy_ops` as
non-const would be another, but that is worse IMO.  Thanks for the
patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 return true;
>         }
>
> --
> 2.25.0.341.g760bfbb309-goog
>


--=20
Thanks,
~Nick Desaulniers
