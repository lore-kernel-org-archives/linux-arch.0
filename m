From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68k: add missing SOFTIRQENTRY_TEXT linker section
Date: Tue, 14 Nov 2017 23:19:25 +1000
Message-ID: <5cacb9df-9c0f-682f-875f-7af39a660e07@linux-m68k.org>
References: <1510639477-30734-1-git-send-email-gerg@linux-m68k.org>
 <CAMuHMdXYcP=rdhxBkCqS4VKvvM_BEq2P=8AdwU+iOaeE54dTrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXYcP=rdhxBkCqS4VKvvM_BEq2P=8AdwU+iOaeE54dTrw@mail.gmail.com>
Content-Language: en-US
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Geert,

On 14/11/17 18:11, Geert Uytterhoeven wrote:
> On Tue, Nov 14, 2017 at 7:04 AM, Greg Ungerer <gerg@linux-m68k.org> wrote:
>> Commit be7635e7287e ("arch, ftrace: for KASAN put hard/soft IRQ entries
>> into separate sections") added a new linker section, SOFTIRQENTRY_TEXT,
>> to the linker scripts for most architectures. It didn't add it to any of
>> the linker scripts for the m68k architecture. This was not really a problem
>> because it is only defined if either of CONFIG_FUNCTION_GRAPH_TRACER or
>> CONFIG_KASAN are enabled - which can never be true for m68k.
>>
>> However commit 229a71860547 ("irq: Make the irqentry text section
>> unconditional") means that SOFTIRQENTRY_TEXT is now always defined. So on
>> m68k we now end up with a separate ELF section for .softirqentry.text
>> instead of it being part of the .text section. On some m68k targets in some
> 
> Nice catch!
> 
> +10 other architectures also don't have the section.
> 
>> configurations this can also cause a fatal link error:
>>
>>    LD      vmlinux
>> /usr/local/bin/../m68k-uclinux/bin/ld.real: section .softirqentry.text loaded at [0000000010de10c0,0000000010de12dd] overlaps section .rodata loaded at [0000000010de10c0,0000000010e0fd67]
> 
> How does it cause the overlap?

The 68VZ328 uCdimm target has an unusual layout and normally it is built
as an "in-rom" image. Using objdump to dump the headers for a 4.13 build
gives this type of layout:

linux/vmlinux:     file format elf32-m68k

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
   0 .romvec       00000108  10c10000  10c10000  00222000  2**0
                   CONTENTS, READONLY
   1 .text         001d0ee0  10c10400  10c10400  00000400  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, CODE
   2 .rodata       0002eca8  00020000  10de12e0  001d2000  2**4
                   CONTENTS, ALLOC, LOAD, DATA
   3 __param       00000258  0004eca8  10e0ff88  00200ca8  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   4 __modver      00000100  0004ef00  10e101e0  00200f00  2**1
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   5 .data         00012440  0004f000  10e102e0  00201000  2**5
                   CONTENTS, ALLOC, LOAD, DATA
   6 .init.text    0000c39a  00062000  10e232e0  00214000  2**1
                   CONTENTS, ALLOC, LOAD, READONLY, CODE
   7 .init.data    00001c64  0006e39c  10e2f67c  0022039c  2**2
                   CONTENTS, ALLOC, LOAD, DATA
   8 .data..percpu 00000000  00070000  00070000  00222108  2**0
                   CONTENTS, ALLOC, LOAD, DATA
   9 .bss          0001407c  00070000  10e312e0  00222000  2**4
                   ALLOC
  10 .comment      00000011  00000000  00000000  00222108  2**0
                   CONTENTS, READONLY

The 4.14 link tries to put the .softirqentry.text section strait after
the .text section. But that has already been calculated as the offset
for the .rodata. Notice that the start address (000000010de10c0) is
identical in the error message.


> For me, "readelf -S vmlinux" gives:
> 
> There are 21 section headers, starting at offset 0x524850:
> 
> Section Headers:
>    [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>    [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>    [ 1] .text             PROGBITS        00001000 001000 2dacb4 00  AX  0   0  4
>    [ 2] .softirqentry.tex PROGBITS        002dbcb4 2dbcb4 0001a0 00  AX  0   0  2
>    [ 3] __ex_table        PROGBITS        002dbe60 2dbe60 0027f0 00   A  0   0  4
>    [ 4] .rodata           PROGBITS        002df000 2df000 09ee20 00  WA  0   0 16
>    [ 5] __ksymtab         PROGBITS        0037de20 37de20 006538 00   A  0   0  2
>    [ 6] __ksymtab_gpl     PROGBITS        00384358 384358 003f08 00   A  0   0  2
>    [ 7] __ksymtab_strings PROGBITS        00388260 388260 01747d 00   A  0   0  1
>    [ 8] __param           PROGBITS        0039f6e0 39f6e0 000924 00   A  0   0  4
>    [ 9] __modver          PROGBITS        003a0004 3a0004 000ffc 00   A  0   0  2
>    [10] .data             PROGBITS        003a1000 3a1000 021c20 00  WA  0   0 32
>    [11] .bss              NOBITS          003c2c20 3c2c20 02b2fc 00  WA  0   0 16
>    [12] .init.text        PROGBITS        003ee000 3c4000 01a4b2 00  AX  0   0  4
>    [13] .init.data        PROGBITS        004084b4 3de4b4 008180 00  WA  0   0  4
>    [14] .m68k_fixup       PROGBITS        00410634 3e6634 001140 00  WA  0   0  1
>    [15] .notes            NOTE            00411774 3e7774 000024 00   A  0   0  4
>    [16] .init_end         NOBITS          00411798 3e7798 000868 00  WA  0   0  1
>    [17] .comment          PROGBITS        00000000 3e7798 000039 01  MS  0   0  1
>    [18] .shstrtab         STRTAB          00000000 524791 0000bd 00      0   0  1
>    [19] .symtab           SYMTAB          00000000 3e77d4 0a66e0 10
> 20 32238  4
>    [20] .strtab           STRTAB          00000000 48deb4 0968dd 00      0   0  1
> Key to Flags:
>    W (write), A (alloc), X (execute), M (merge), S (strings)
>    I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
>    O (extra OS processing required) o (OS specific), p (processor specific)

For most of our other no-MMU links we end up with something similar and
that works ok for direct loads into RAM.

Regards
Greg



>> To fix add in the missing SOFTIRQENTRY_TEXT section into the m68k linker
>> scripts. I noticed that m68k is also missing the IRQENTRY_TEXT section,
>> so this patch also adds an entry for that too.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>> ---
>>   arch/m68k/kernel/vmlinux-nommu.lds | 2 ++
>>   arch/m68k/kernel/vmlinux-std.lds   | 2 ++
>>   arch/m68k/kernel/vmlinux-sun3.lds  | 2 ++
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/arch/m68k/kernel/vmlinux-nommu.lds b/arch/m68k/kernel/vmlinux-nommu.lds
>> index 3aa571a..cf6edda 100644
>> --- a/arch/m68k/kernel/vmlinux-nommu.lds
>> +++ b/arch/m68k/kernel/vmlinux-nommu.lds
>> @@ -45,6 +45,8 @@ SECTIONS {
>>          .text : {
>>                  HEAD_TEXT
>>                  TEXT_TEXT
>> +               IRQENTRY_TEXT
>> +               SOFTIRQENTRY_TEXT
>>                  SCHED_TEXT
>>                  CPUIDLE_TEXT
>>                  LOCK_TEXT
>> diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
>> index 89172b8..625a578 100644
>> --- a/arch/m68k/kernel/vmlinux-std.lds
>> +++ b/arch/m68k/kernel/vmlinux-std.lds
>> @@ -16,6 +16,8 @@ SECTIONS
>>     .text : {
>>          HEAD_TEXT
>>          TEXT_TEXT
>> +       IRQENTRY_TEXT
>> +       SOFTIRQENTRY_TEXT
>>          SCHED_TEXT
>>          CPUIDLE_TEXT
>>          LOCK_TEXT
>> diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
>> index 293990e..9868270 100644
>> --- a/arch/m68k/kernel/vmlinux-sun3.lds
>> +++ b/arch/m68k/kernel/vmlinux-sun3.lds
>> @@ -16,6 +16,8 @@ SECTIONS
>>     .text : {
>>          HEAD_TEXT
>>          TEXT_TEXT
>> +       IRQENTRY_TEXT
>> +       SOFTIRQENTRY_TEXT
>>          SCHED_TEXT
>>          CPUIDLE_TEXT
>>          LOCK_TEXT
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 
