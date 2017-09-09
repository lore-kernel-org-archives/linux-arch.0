From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: module: use relative references for __ksymtab entries
Date: Sat, 9 Sep 2017 17:48:27 +0100
Message-ID: <3EB4CC1A-6163-4F63-B689-86A04F385516@linaro.org>
References: <20170819181035.969-1-ard.biesheuvel@linaro.org> <20170819181035.969-3-ard.biesheuvel@linaro.org> <20170909130831.kpsoaytew5cyvtb3@redbean> <CAJcbSZFmuGO53hCac9ik-Mv=Zdk00znG-KgWMGkOfTJMM+-Bog@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJcbSZFmuGO53hCac9ik-Mv=Zdk00znG-KgWMGkOfTJMM+-Bog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Garnier <thgarnie@google.com>
Cc: Jessica Yu <jeyu@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Steven
List-Id: linux-arch.vger.kernel.org


> On 9 Sep 2017, at 16:33, Thomas Garnier <thgarnie@google.com> wrote:
>=20
>> On Sat, Sep 9, 2017 at 6:08 AM, Jessica Yu <jeyu@kernel.org> wrote:
>> +++ Ard Biesheuvel [19/08/17 19:10 +0100]:
>>=20
>>> An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
>>> entries, each consisting of two 64-bit fields containing absolute
>>> references, to the symbol itself and to a char array containing
>>> its name, respectively.
>>>=20
>>> When we build the same configuration with KASLR enabled, we end
>>> up with an additional ~192 KB of relocations in the .init section,
>>> i.e., one 24 byte entry for each absolute reference, which all need
>>> to be processed at boot time.
>>>=20
>>> Given how the struct kernel_symbol that describes each entry is
>>> completely local to module.c (except for the references emitted
>>> by EXPORT_SYMBOL() itself), we can easily modify it to contain
>>> two 32-bit relative references instead. This reduces the size of
>>> the __ksymtab section by 50% for all 64-bit architectures, and
>>> gets rid of the runtime relocations entirely for architectures
>>> implementing KASLR, either via standard PIE linking (arm64) or
>>> using custom host tools (x86).
>>>=20
>>> Note that the binary search involving __ksymtab contents relies
>>> on each section being sorted by symbol name. This is implemented
>>> based on the input section names, not the names in the ksymtab
>>> entries, so this patch does not interfere with that.
>>>=20
>>> Given that the use of place-relative relocations requires support
>>> both in the toolchain and in the module loader, we cannot enable
>>> this feature for all architectures. So make it dependend on whether
>>> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is defined.
>=20
> Good idea, I assume we may still get relocations given the compiler is
> pretty bad at optimizing (_ptr - .) but I might be wrong.

The point is that the resulting place relative static relocations are fixed u=
p at link time (and discarded) rather than being converted into dynamic R_xx=
x_RELATIVE relocations that require fixing up at runtime.

The compiler rarely emits place relative relocations, in my experience, but t=
his is probably highly arch and CFLAGS dependent. I am not sure what you mea=
n by 'optimizing' (<sym> - . ): if such expressions are emitted into asm, it=
 is up to the assembler to fully resolve the expression or emit a place rela=
tive relocation, depending in whether <sym> has external linkage.

> Anyway, the
> size decrease is great and we can ignore these relocations if need be.

Yes, if you are using --emit-relocs and mangling static relocations manually=
 (which I suppose is the case for x86), you can add any resulting place rela=
tive relocations to the ignore list, although I would assume they are alread=
y on it.

Thanks.

>>>=20
>>> Cc: Jessica Yu <jeyu@kernel.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Thomas Garnier <thgarnie@google.com>
>>> Cc: Nicolas Pitre <nico@linaro.org>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>=20
>>=20
>> I ran this through some light testing and the relative ksymtab
>> references seem to work just fine:
>>=20
>> Acked-by: Jessica Yu <jeyu@kernel.org> (for module changes)
>>=20
>>=20
>>> arch/x86/include/asm/Kbuild   |  1 +
>>> arch/x86/include/asm/export.h |  4 --
>>> include/asm-generic/export.h  | 12 +++++-
>>> include/linux/compiler.h      | 11 +++++
>>> include/linux/export.h        | 45 +++++++++++++++-----
>>> kernel/module.c               | 33 +++++++++++---
>>> 6 files changed, 83 insertions(+), 23 deletions(-)
>>>=20
>>> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
>>> index 5d6a53fd7521..3e8a88dcaa1d 100644
>>> --- a/arch/x86/include/asm/Kbuild
>>> +++ b/arch/x86/include/asm/Kbuild
>>> @@ -9,5 +9,6 @@ generated-y +=3D xen-hypercalls.h
>>> generic-y +=3D clkdev.h
>>> generic-y +=3D dma-contiguous.h
>>> generic-y +=3D early_ioremap.h
>>> +generic-y +=3D export.h
>>> generic-y +=3D mcs_spinlock.h
>>> generic-y +=3D mm-arch-hooks.h
>>> diff --git a/arch/x86/include/asm/export.h b/arch/x86/include/asm/export=
.h
>>> deleted file mode 100644
>>> index 138de56b13eb..000000000000
>>> --- a/arch/x86/include/asm/export.h
>>> +++ /dev/null
>>> @@ -1,4 +0,0 @@
>>> -#ifdef CONFIG_64BIT
>>> -#define KSYM_ALIGN 16
>>> -#endif
>>> -#include <asm-generic/export.h>
>>> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h=

>>> index 719db1968d81..97ce606459ae 100644
>>> --- a/include/asm-generic/export.h
>>> +++ b/include/asm-generic/export.h
>>> @@ -5,12 +5,10 @@
>>> #define KSYM_FUNC(x) x
>>> #endif
>>> #ifdef CONFIG_64BIT
>>> -#define __put .quad
>>> #ifndef KSYM_ALIGN
>>> #define KSYM_ALIGN 8
>>> #endif
>>> #else
>>> -#define __put .long
>>> #ifndef KSYM_ALIGN
>>> #define KSYM_ALIGN 4
>>> #endif
>>> @@ -25,6 +23,16 @@
>>> #define KSYM(name) name
>>> #endif
>>>=20
>>> +.macro __put, val, name
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +       .long   \val - ., \name - .
>>> +#elif defined(CONFIG_64BIT)
>>> +       .quad   \val, \name
>>> +#else
>>> +       .long   \val, \name
>>> +#endif
>>> +.endm
>>> +
>>> /*
>>> * note on .section use: @progbits vs %progbits nastiness doesn't matter,=

>>> * since we immediately emit into those sections anyway.
>>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>>> index eca8ad75e28b..363fb3e734ec 100644
>>> --- a/include/linux/compiler.h
>>> +++ b/include/linux/compiler.h
>>> @@ -590,4 +590,15 @@ static __always_inline void
>>> __write_once_size(volatile void *p, void *res, int s
>>>        (_________p1); \
>>> })
>>>=20
>>> +/*
>>> + * Force the compiler to emit 'sym' as a symbol, so that we can referen=
ce
>>> + * it from inline assembler. Necessary in case 'sym' could be inlined
>>> + * otherwise, or eliminated entirely due to lack of references that are=

>>> + * visibile to the compiler.
>>> + */
>>> +#define __ADDRESSABLE(sym) \
>>> +       static void *__attribute__((section(".discard.text"), used))    \=

>>> +               __PASTE(__discard_##sym, __LINE__)(void)                \=

>>> +                       { return (void *)&sym; }                        \=

>>> +
>>> #endif /* __LINUX_COMPILER_H */
>>> diff --git a/include/linux/export.h b/include/linux/export.h
>>> index 1a1dfdb2a5c6..156b974181a4 100644
>>> --- a/include/linux/export.h
>>> +++ b/include/linux/export.h
>>> @@ -24,12 +24,6 @@
>>> #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
>>>=20
>>> #ifndef __ASSEMBLY__
>>> -struct kernel_symbol
>>> -{
>>> -       unsigned long value;
>>> -       const char *name;
>>> -};
>>> -
>>> #ifdef MODULE
>>> extern struct module __this_module;
>>> #define THIS_MODULE (&__this_module)
>>> @@ -60,17 +54,46 @@ extern struct module __this_module;
>>> #define __CRC_SYMBOL(sym, sec)
>>> #endif
>>>=20
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +/*
>>> + * Emit the ksymtab entry as a pair of relative references: this reduce=
s
>>> + * the size by half on 64-bit architectures, and eliminates the need fo=
r
>>> + * absolute relocations that require runtime processing on relocatable
>>> + * kernels.
>>> + */
>>> +#define __KSYMTAB_ENTRY(sym, sec)                                      \=

>>> +       __ADDRESSABLE(sym)                                              \=

>>> +       asm("   .section \"___ksymtab" sec "+" #sym "\", \"a\"  \n"     \=

>>> +           "   .balign 8                                       \n"     \=

>>> +           VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":              \n"     \=

>>> +           "   .long " VMLINUX_SYMBOL_STR(sym) "- .            \n"     \=

>>> +           "   .long " VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"     \=

>>> +           "   .previous                                       \n")
>>> +
>>> +struct kernel_symbol {
>>> +       signed int value_offset;
>>> +       signed int name_offset;
>>> +};
>>> +#else
>>> +#define __KSYMTAB_ENTRY(sym, sec)                                      \=

>>> +       static const struct kernel_symbol __ksymtab_##sym               \=

>>> +       __attribute__((section("___ksymtab" sec "+" #sym), used))       \=

>>> +       =3D { (unsigned long)&sym, __kstrtab_##sym }
>>> +
>>> +struct kernel_symbol {
>>> +       unsigned long value;
>>> +       const char *name;
>>> +};
>>> +#endif
>>> +
>>> /* For every exported symbol, place a struct in the __ksymtab section */=

>>> #define ___EXPORT_SYMBOL(sym, sec)                                      \=

>>>        extern typeof(sym) sym;                                         \=

>>>        __CRC_SYMBOL(sym, sec)                                          \=

>>>        static const char __kstrtab_##sym[]                             \=

>>> -       __attribute__((section("__ksymtab_strings"), aligned(1)))       \=

>>> +       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \=

>>>        =3D VMLINUX_SYMBOL_STR(sym);                                     =
 \
>>> -       static const struct kernel_symbol __ksymtab_##sym               \=

>>> -       __used                                                          \=

>>> -       __attribute__((section("___ksymtab" sec "+" #sym), used))       \=

>>> -       =3D { (unsigned long)&sym, __kstrtab_##sym }
>>> +       __KSYMTAB_ENTRY(sym, sec)
>>>=20
>>> #if defined(__KSYM_DEPS__)
>>>=20
>>> diff --git a/kernel/module.c b/kernel/module.c
>>> index 40f983cbea81..a45423dcc32d 100644
>>> --- a/kernel/module.c
>>> +++ b/kernel/module.c
>>> @@ -539,12 +539,31 @@ static bool check_symbol(const struct symsearch
>>> *syms,
>>>        return true;
>>> }
>>>=20
>>> +static unsigned long kernel_symbol_value(const struct kernel_symbol *sy=
m)
>>> +{
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +       return (unsigned long)&sym->value_offset + sym->value_offset;
>>> +#else
>>> +       return sym->value;
>>> +#endif
>>> +}
>>> +
>>> +static const char *kernel_symbol_name(const struct kernel_symbol *sym)
>>> +{
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +       return (const char *)((unsigned long)&sym->name_offset +
>>> +                             sym->name_offset);
>>> +#else
>>> +       return sym->name;
>>> +#endif
>>> +}
>>> +
>>> static int cmp_name(const void *va, const void *vb)
>>> {
>>>        const char *a;
>>>        const struct kernel_symbol *b;
>>>        a =3D va; b =3D vb;
>>> -       return strcmp(a, b->name);
>>> +       return strcmp(a, kernel_symbol_name(b));
>>> }
>>>=20
>>> static bool find_symbol_in_section(const struct symsearch *syms,
>>> @@ -2190,7 +2209,7 @@ void *__symbol_get(const char *symbol)
>>>                sym =3D NULL;
>>>        preempt_enable();
>>>=20
>>> -       return sym ? (void *)sym->value : NULL;
>>> +       return sym ? (void *)kernel_symbol_value(sym) : NULL;
>>> }
>>> EXPORT_SYMBOL_GPL(__symbol_get);
>>>=20
>>> @@ -2220,10 +2239,12 @@ static int verify_export_symbols(struct module
>>> *mod)
>>>=20
>>>        for (i =3D 0; i < ARRAY_SIZE(arr); i++) {
>>>                for (s =3D arr[i].sym; s < arr[i].sym + arr[i].num; s++) {=

>>> -                       if (find_symbol(s->name, &owner, NULL, true,
>>> false)) {
>>> +                       if (find_symbol(kernel_symbol_name(s), &owner,
>>> NULL,
>>> +                                       true, false)) {
>>>                                pr_err("%s: exports duplicate symbol %s"
>>>                                       " (owned by %s)\n",
>>> -                                      mod->name, s->name,
>>> module_name(owner));
>>> +                                      mod->name, kernel_symbol_name(s),=

>>> +                                      module_name(owner));
>>>                                return -ENOEXEC;
>>>                        }
>>>                }
>>> @@ -2272,7 +2293,7 @@ static int simplify_symbols(struct module *mod,
>>> const struct load_info *info)
>>>                        ksym =3D resolve_symbol_wait(mod, info, name);
>>>                        /* Ok if resolved.  */
>>>                        if (ksym && !IS_ERR(ksym)) {
>>> -                               sym[i].st_value =3D ksym->value;
>>> +                               sym[i].st_value =3D
>>> kernel_symbol_value(ksym);
>>>                                break;
>>>                        }
>>>=20
>>> @@ -2532,7 +2553,7 @@ static int is_exported(const char *name, unsigned
>>> long value,
>>>                ks =3D lookup_symbol(name, __start___ksymtab,
>>> __stop___ksymtab);
>>>        else
>>>                ks =3D lookup_symbol(name, mod->syms, mod->syms +
>>> mod->num_syms);
>>> -       return ks !=3D NULL && ks->value =3D=3D value;
>>> +       return ks !=3D NULL && kernel_symbol_value(ks) =3D=3D value;
>>> }
>>>=20
>>> /* As per nm */
>>> --
>>> 2.11.0
>>>=20
>>=20
>=20
>=20
>=20
> --=20
> Thomas
