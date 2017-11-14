From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m68k: add missing SOFTIRQENTRY_TEXT linker section
Date: Tue, 14 Nov 2017 09:11:49 +0100
Message-ID: <CAMuHMdXYcP=rdhxBkCqS4VKvvM_BEq2P=8AdwU+iOaeE54dTrw@mail.gmail.com>
References: <1510639477-30734-1-git-send-email-gerg@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1510639477-30734-1-git-send-email-gerg@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Greg,

CC mingo, Hiramatsu-san, linux-arch, lkml

On Tue, Nov 14, 2017 at 7:04 AM, Greg Ungerer <gerg@linux-m68k.org> wrote:
> Commit be7635e7287e ("arch, ftrace: for KASAN put hard/soft IRQ entries
> into separate sections") added a new linker section, SOFTIRQENTRY_TEXT,
> to the linker scripts for most architectures. It didn't add it to any of
> the linker scripts for the m68k architecture. This was not really a problem
> because it is only defined if either of CONFIG_FUNCTION_GRAPH_TRACER or
> CONFIG_KASAN are enabled - which can never be true for m68k.
>
> However commit 229a71860547 ("irq: Make the irqentry text section
> unconditional") means that SOFTIRQENTRY_TEXT is now always defined. So on
> m68k we now end up with a separate ELF section for .softirqentry.text
> instead of it being part of the .text section. On some m68k targets in some

Nice catch!

+10 other architectures also don't have the section.

> configurations this can also cause a fatal link error:
>
>   LD      vmlinux
> /usr/local/bin/../m68k-uclinux/bin/ld.real: section .softirqentry.text loaded at [0000000010de10c0,0000000010de12dd] overlaps section .rodata loaded at [0000000010de10c0,0000000010e0fd67]

How does it cause the overlap?

For me, "readelf -S vmlinux" gives:

There are 21 section headers, starting at offset 0x524850:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        00001000 001000 2dacb4 00  AX  0   0  4
  [ 2] .softirqentry.tex PROGBITS        002dbcb4 2dbcb4 0001a0 00  AX  0   0  2
  [ 3] __ex_table        PROGBITS        002dbe60 2dbe60 0027f0 00   A  0   0  4
  [ 4] .rodata           PROGBITS        002df000 2df000 09ee20 00  WA  0   0 16
  [ 5] __ksymtab         PROGBITS        0037de20 37de20 006538 00   A  0   0  2
  [ 6] __ksymtab_gpl     PROGBITS        00384358 384358 003f08 00   A  0   0  2
  [ 7] __ksymtab_strings PROGBITS        00388260 388260 01747d 00   A  0   0  1
  [ 8] __param           PROGBITS        0039f6e0 39f6e0 000924 00   A  0   0  4
  [ 9] __modver          PROGBITS        003a0004 3a0004 000ffc 00   A  0   0  2
  [10] .data             PROGBITS        003a1000 3a1000 021c20 00  WA  0   0 32
  [11] .bss              NOBITS          003c2c20 3c2c20 02b2fc 00  WA  0   0 16
  [12] .init.text        PROGBITS        003ee000 3c4000 01a4b2 00  AX  0   0  4
  [13] .init.data        PROGBITS        004084b4 3de4b4 008180 00  WA  0   0  4
  [14] .m68k_fixup       PROGBITS        00410634 3e6634 001140 00  WA  0   0  1
  [15] .notes            NOTE            00411774 3e7774 000024 00   A  0   0  4
  [16] .init_end         NOBITS          00411798 3e7798 000868 00  WA  0   0  1
  [17] .comment          PROGBITS        00000000 3e7798 000039 01  MS  0   0  1
  [18] .shstrtab         STRTAB          00000000 524791 0000bd 00      0   0  1
  [19] .symtab           SYMTAB          00000000 3e77d4 0a66e0 10
20 32238  4
  [20] .strtab           STRTAB          00000000 48deb4 0968dd 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

> To fix add in the missing SOFTIRQENTRY_TEXT section into the m68k linker
> scripts. I noticed that m68k is also missing the IRQENTRY_TEXT section,
> so this patch also adds an entry for that too.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
>  arch/m68k/kernel/vmlinux-nommu.lds | 2 ++
>  arch/m68k/kernel/vmlinux-std.lds   | 2 ++
>  arch/m68k/kernel/vmlinux-sun3.lds  | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/arch/m68k/kernel/vmlinux-nommu.lds b/arch/m68k/kernel/vmlinux-nommu.lds
> index 3aa571a..cf6edda 100644
> --- a/arch/m68k/kernel/vmlinux-nommu.lds
> +++ b/arch/m68k/kernel/vmlinux-nommu.lds
> @@ -45,6 +45,8 @@ SECTIONS {
>         .text : {
>                 HEAD_TEXT
>                 TEXT_TEXT
> +               IRQENTRY_TEXT
> +               SOFTIRQENTRY_TEXT
>                 SCHED_TEXT
>                 CPUIDLE_TEXT
>                 LOCK_TEXT
> diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
> index 89172b8..625a578 100644
> --- a/arch/m68k/kernel/vmlinux-std.lds
> +++ b/arch/m68k/kernel/vmlinux-std.lds
> @@ -16,6 +16,8 @@ SECTIONS
>    .text : {
>         HEAD_TEXT
>         TEXT_TEXT
> +       IRQENTRY_TEXT
> +       SOFTIRQENTRY_TEXT
>         SCHED_TEXT
>         CPUIDLE_TEXT
>         LOCK_TEXT
> diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
> index 293990e..9868270 100644
> --- a/arch/m68k/kernel/vmlinux-sun3.lds
> +++ b/arch/m68k/kernel/vmlinux-sun3.lds
> @@ -16,6 +16,8 @@ SECTIONS
>    .text : {
>         HEAD_TEXT
>         TEXT_TEXT
> +       IRQENTRY_TEXT
> +       SOFTIRQENTRY_TEXT
>         SCHED_TEXT
>         CPUIDLE_TEXT
>         LOCK_TEXT

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
