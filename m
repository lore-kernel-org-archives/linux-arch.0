From: John Reiser <jreiser@bitwagon.com>
Subject: Re: [PATCH 2/3] ftrace/x86: Add support for C version of recordmcount
Date: Thu, 28 Oct 2010 19:34:31 -0700
Message-ID: <4CCA32B7.4020605@bitwagon.com>
References: <20101014210014.895157788@goodmis.org> <20101014210136.230687571@goodmis.org> <20101027032548.GA5341@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20101027032548.GA5341@linux-sh.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

[Note that I have trimmed the addressees for this reply.]
On 10/26/2010, Paul Mundt wrote:

>> This patch adds the support for the C version of recordmcount and
>> compile times show ~ 12% improvement.

> While I haven't had the chance to debug this yet, turning it on for SH
> blows up immediately:
> 
> ftrace: allocating 15200 entries in 30 pages
> ------------[ cut here ]------------
> WARNING: at /home/pmundt/devel/git/sh-2.6/kernel/trace/ftrace.c:1007
> Modules linked in:
> 
> Pid : 0, Comm:           swapper
> CPU : 0                  Not tainted  (2.6.36-05622-g38ab134-dirty #508)
> 
> PC is at ftrace_bug+0x78/0x23c
> PR is at ftrace_bug+0x74/0x23c

> Call trace:
>  [<80066a86>] ftrace_process_locs+0x15a/0x284
>  [<803b15d8>] dns_query+0x0/0x26c

> Code:
>   80064dee:  mov       r9, r5
>   80064df0:  tst       r9, r9
>   80064df2:  bt        80064df6
> ->80064df4:  trapa     #62
>   80064df6:  bra       80064ef2

> ---[ end trace 4eaa2a86a8e2da22 ]---
> ftrace failed to modify [<803b15d8>] dns_query+0x0/0x26c
>  actual: 02:d1:22:4f
> Testing tracer nop: PASSED
> 
> Suggestions?


This looks like a disagreement over the interpretation of relocation type
R_SH_DIR32 in Elf32_Rela on a 32-bit EM_SH (SuperH) machine.

arch/sh/kernel/module.c says:
-----
                sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
                        + ELF32_R_SYM(rel[i].r_info);
                relocation = sym->st_value + rel[i].r_addend;
   ...
                case R_SH_DIR32:
                        value = get_unaligned(location);
                        value += relocation;
                        put_unaligned(value, location);
-----

Paul Mundt sent to me an actual kernel object file main.o compiled -pg for EM_SH.
According to 'readelf', the Perl script recordmcount.pl generates:
-----
Relocation section '.rela__mcount_loc' at offset 0x17ec8 contains 3 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000000  00006a01 R_SH_DIR32        00000000   do_one_initcall + 0
00000004  00006a01 R_SH_DIR32        00000000   do_one_initcall + 0
00000008  00006a01 R_SH_DIR32        00000000   do_one_initcall + 0

Symbol table '.symtab' contains 198 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
   106: 00000000   364 FUNC    GLOBAL DEFAULT    1 do_one_initcall
###  (1==Ndx) ==> .text, so do_one_initcall is first in .text
###  106==0x6a

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 1] .text             PROGBITS        00000000 000034 00026c 00  AX  0   0  4
  [17] __mcount_loc      PROGBITS        00000000 001140 00000c 00   A  0   0  4
  [18] .rela__mcount_loc RELA            00000000 017ec8 000024 0c     46  17  4
  [46] .symtab           SYMTAB          00000000 022ac4 000c60 10     47  71  4
-----
where section 17, __mcount_loc, has three 32-bit words with values 0xc, 0x178, 0x1b0.

Also according to 'readelf', the C program recordmcount generates:
-----
Relocation section '.rela__mcount_loc' at offset 0x249f4 contains 3 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000000  00000201 R_SH_DIR32        00000000   .text + c
00000004  00000201 R_SH_DIR32        00000000   .text + 178
00000008  00000201 R_SH_DIR32        00000000   .text + 1b0

Symbol table '.symtab' contains 198 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     2: 00000000     0 SECTION LOCAL  DEFAULT    1
### (1==Ndx) ==> .text

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 1] .text             PROGBITS        00000000 000034 00026c 00  AX  0   0  4
  [44] .symtab           SYMTAB          00000000 017440 000c50 10     45  70  4
  [46] __mcount_loc      PROGBITS        00000000 0249e8 00000c 04   A  0   0  4
  [47] .rela__mcount_loc RELA            00000000 0249f4 000024 0c     44  46  4
-----
where section 46, __mcount_loc, has three 32-bit words with values 0, 0, 0.

Assuming the code in arch/sh/kernel/module.c, then I believe that those two
descriptions are equivalent.  The output of the Perl script calls for

   *location = *location + do_one_initcall.st_value + .r_addend

with  0==.r_addend  and initially  *location==offset .
The output of the C version calls for

   *location = *location + .text.st_value           + .r_addend

with  offset==.r_addend  and initially  *location==0.

I did find in binutils-2.18.50.0.9/bfd/elf32-sh.c this ominous comment:
-----
      switch ((int) r_type)
        {
        final_link_relocate:
          /* COFF relocs don't use the addend. The addend is used for
             R_SH_DIR32 to be compatible with other compilers.  */
          r = _bfd_final_link_relocate (howto, input_bfd, input_section,
                                        contents, rel->r_offset,
                                        relocation, addend);
-----

The natural question is, "Does /bin/ld for EM_SH ignore the .r_addend,
or does /bin/ld process .r_addend just like arch/sh/kernel/module.c ?"
If /bin/ld ignores .r_addend for R_SH_DIR32, as hinted in the comment,
then that would explain the crash.

Another question is, "Does the SECTION LOCAL symbol for .text have
.st_value equal to the virtual address of the start of the section?"
If a SECTION LOCAL symbol was not relocated like this, and thus had
the value 0, then that also would explain the crash.

That's my analysis.  If anyone can shed more light, then please do!

-- 
John Reiser, jreiser@BitWagon.com
