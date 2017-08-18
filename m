From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/5] add support for relative references in special sections
Date: Fri, 18 Aug 2017 07:12:42 +0100
Message-ID: <CAKv+Gu9MBz68SMpQFbw33qvOwbGYYVO=5HHuLESUtsa0qsBP5g@mail.gmail.com>
References: <20170814105231.14608-1-ard.biesheuvel@linaro.org> <20170818055655.GA495@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818055655.GA495@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Hi Sergey,

Thanks for taking a look

On 18 August 2017 at 06:56, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (08/14/17 11:52), Ard Biesheuvel wrote:
>> This adds support for emitting special sections such as initcall arrays,
>> PCI fixups and tracepoints as relative references rather than absolute
>> references. This reduces the size by 50% on 64-bit architectures, but
>> more importantly, it removes the need for carrying relocation metadata
>> for these sections in relocatables kernels (e.g., for KASLR) that need
>> to fix up these absolute references at boot time. On arm64, this reduces
>> the vmlinux footprint of such a reference by 8x (8 byte absolute reference
>> + 24 byte RELA entry vs 4 byte relative reference)
> [..]
>
> a side note,
> checkpatch complaints quite a lot.
>

Yeah, fair point. Many of them are debatable or completely bogus, though:

ERROR: "foo * bar" should be "foo *bar"
#114: FILE: include/linux/compiler.h:600:
+ static void * __attribute__((section(".discard.text"), used)) \

I think it is rather common to keep whitespace between * and what
follows if it is not the identifier.

ERROR: Macros with complex values should be enclosed in parentheses
#147: FILE: include/linux/export.h:64:
+#define __KSYMTAB_ENTRY(sym, sec) \
+ __ADDRESSABLE(sym) \
+ asm(" .section \"___ksymtab" sec "+" #sym "\", \"a\" \n" \
+    " .balign 8 \n" \
+    VMLINUX_SYMBOL_STR(__ksymtab_##sym) ": \n" \
+    " .long " VMLINUX_SYMBOL_STR(sym) "- . \n" \
+    " .long " VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n" \
+    " .previous \n")

WARNING: do not add new typedefs
#29: FILE: include/linux/init.h:114:
+typedef signed int initcall_entry_t;

WARNING: do not add new typedefs
#36: FILE: include/linux/init.h:121:
+typedef initcall_t initcall_entry_t;

This is a typedef that accompanies the existing typedef for
initcall_t, and it is the only way to parameterise this code without a
ton of changes to duplicate all extern declarations of initcall
arrays.

ERROR: Macros with multiple statements should be enclosed in a do - while loop
#55: FILE: include/linux/init.h:181:
+#define ___define_initcall(fn, id, __sec) \
+ __ADDRESSABLE(fn) \
+ asm(".section \"" #__sec ".init\", \"a\" \n" \
+ "__initcall_" #fn #id ": \n" \
+    ".long " VMLINUX_SYMBOL_STR(fn) " - . \n" \
+    ".previous \n");

This one is bogus. This macro is only used in file scope.

WARNING: externs should be avoided in .c files
#109: FILE: init/main.c:837:
+extern initcall_entry_t __initcall0_start[];

This changes the type of the existing initcall array declarations, and
I don't think moving them to a .h file for no other reason than to
appease checkpatch is pointless.

WARNING: unnecessary whitespace before a quoted newline
#63: FILE: include/linux/pci.h:1759:
+ asm(".section " #sec ", \"a\" \n" \

WARNING: unnecessary whitespace before a quoted newline
#64: FILE: include/linux/pci.h:1760:
+    ".balign 16 \n" \

WARNING: unnecessary whitespace before a quoted newline
#65: FILE: include/linux/pci.h:1761:
+    ".short " #vendor ", " #device " \n" \

These are not newlines that end up as strings in the program, and I
think it makes little sense to make the inline asm less readable by
putting the \n right after the text.

WARNING: braces {} are not necessary for single statement blocks
#83: FILE: kernel/tracepoint.c:515:
+ for (iter = begin; iter < (signed int *)end; iter++) {
+ fct((struct tracepoint *)((unsigned long)iter + *iter), priv);
+ }

This simply mirrors the existing code in the other branch of the if ()

I will clean up the meaningful ones in v2, but please don't expect
this series to be checkpatch clean: it simply doesn't deal with inline
asm very well, and some of this code predates checkpatch by a decade,
and I'd rather not mix up rather tricky functional changes with
checkpatch cleanup duty.

-- 
Ard.
