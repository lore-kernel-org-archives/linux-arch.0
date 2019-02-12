Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:53728 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfBLXGF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 18:06:05 -0500
Subject: Re: Semantics of symbol address in perf report -v
References: <da403654-f21d-9959-067f-b76581600741@synopsys.com>
From: Vineet Gupta <vineet.gupta1@synopsys.com>
Message-ID: <c7f4f000-6934-912e-f8eb-c163a04323d1@synopsys.com>
Date: Tue, 12 Feb 2019 15:05:53 -0800
MIME-Version: 1.0
In-Reply-To: <da403654-f21d-9959-067f-b76581600741@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, arcml <linux-snps-arc@lists.infradead.org>, Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Message-ID: <20190212230553.OQsh5UAy4Mi7ciJROZXTBxWmrR3YCHYSKKWRYo7DWyM@z>

On 1/23/19 11:55 AM, Vineet Gupta wrote:
> Hi,
> 
> I noticed a small anomaly in perf report -v output on ARC and x86 as well.
> 
> A simple program which sits in tight loop, compiled for x86_64
> 
> void main() { while(1) {} }
> 
> $ gcc -g tight.c
> $ ./a.out &
> $ perf record -e cycles -p 26703
> $ perf report -n -v  --stdio  | egrep "(main|Symbol)"
> 
> |# Overhead Samples Command  Shared Object         Symbol
> 
> |  99.93%    55753   a.out   /home/arc/test/a.out  0x4da     B [.] main
> 
> |                                                  ^^^^^
> 
> The printer address for Symbols is *not* the actual address in elf, but rather VMA
> start offset.
> 
> 0x4da = 0x4004da - 0x0000000000400000
> 
> $ objdump -d ./a.out
> 
> | 00000000004004d6 <main>:
> |  4004d6:	55                   	push   %rbp
> |  4004d7:	48 89 e5             	mov    %rsp,%rbp
> |  4004da:	eb fe                	jmp    4004da <main+0x4>
> |  4004dc:	0f 1f 40 00          	nopl   0x0(%rax)
> 
> $ readelf -a ./a.out
> 
> | Program Headers:
> |  Type           Offset             VirtAddr           PhysAddr
> |                 FileSiz            MemSiz              Flags  Align
> | Program Headers:
> |  LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
>                  0x000000000000068c 0x000000000000068c  R E    200000
> 
> 
> This is problematic in narrowing down the hotspot instruction, when the binary
> itself is. One needs to do the offset addition manually to find the actual hotspot
> location.
> 
> |   99.79%  100064  a.out  /home/arc/test/a.out  0x4da  B [.] 0x00000000000004da
> 
>                                                                ^^^^^^^^^^^^^^^^
> 
> Is this considered an issue ? Would the fix to print the actual symbol address
> (and recorded in raw perf event data) break some existing tooling etc.
> 

@Arnaldo any ideas ?

this is being done in tools/perf/util/symbol-elf.c

    symsrc__init
	if (dso->kernel == DSO_TYPE_USER)
		ss->adjust_symbols = true;

     dso__load_sym
	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);

		} else if ((used_opd && runtime_ss->adjust_symbols) ||
			   (!used_opd && syms_ss->adjust_symbols)) {

			*sym.st_value -= shdr.sh_addr - shdr.sh_offset;*
               }

I investigated a bit more and this goes back to 2009:

Initially the adj was done for prelink binaries: commit f5812a7a336fb
("perf_counter tools: Adjust only prelinked symbol's addresses")

+       self->prelinked = elf_section_by_name(elf, &ehdr, &shdr,
+                                             ".gnu.prelink_undo",
+                                             NULL) != NULL;
+      if (self->prelinked) {
          if (verbose >= 2)
            printf("adjusting symbol: ...
           sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+      }

commit 30d7a77dd5a97 ("perf_counter tools: Adjust symbols in ET_EXEC files too")
started doing this for any executable

-       self->prelinked = elf_section_by_name(elf, &ehdr, &shdr,
-                                             ".gnu.prelink_undo",
-                                             NULL) != NULL;
+       self->adjust_symbols = (ehdr.e_type == ET_EXEC ||
+                               elf_section_by_name(elf, &ehdr, &shdr,
+                                                    ".gnu.prelink_undo",
+
