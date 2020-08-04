From: =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Date: Mon, 3 Aug 2020 18:19:35 -0700
Message-ID: <20200804011935.b4asdxdxwvwic7js@google.com>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
 <20200801035128.GB2800311@rani.riverdale.lan>
 <20200803190506.GE1299820@tassilo.jf.intel.com>
 <20200803201525.GA1351390@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200803201525.GA1351390@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Sankar <nivedita@alum.mit.edu>, Kees Cook <keescook@chromium.org>
Cc: Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Jian Cai <jiancai@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2020-08-03, Arvind Sankar wrote:
>On Mon, Aug 03, 2020 at 12:05:06PM -0700, Andi Kleen wrote:
>> > However, the history of their being together comes from
>> >
>> >   9bebe9e5b0f3 ("kbuild: Fix .text.unlikely placement")
>> >
>> > which seems to indicate there was some problem with having them separated out,
>> > although I don't quite understand what the issue was from the commit message.
>>
>> Separating it out is less efficient. Gives worse packing for the hot part
>> if they are not aligned to 64byte boundaries, which they are usually not.
>>
>> It also improves packing of the cold part, but that probably doesn't matter.
>>
>> -Andi
>
>Why is that? Both .text and .text.hot have alignment of 2^4 (default
>function alignment on x86) by default, so it doesn't seem like it should
>matter for packing density.  Avoiding interspersing cold text among
>regular/hot text seems like it should be a net win.
>
>That old commit doesn't reference efficiency -- it says there was some
>problem with matching when they were separated out, but there were no
>wildcard section names back then.

I just want to share some context. GNU ld's internal linker script does
impose a particular input section order by specifying separate input section descriptions:

   .text           :
   {
     *(.text.unlikely .text.*_unlikely .text.unlikely.*)
     *(.text.exit .text.exit.*)
     *(.text.startup .text.startup.*)
     *(.text.hot .text.hot.*)
     *(SORT(.text.sorted.*))   # binutils 5fa5f8f5fe494ba4fe98c11899a5464cd164ec75, invented for GCC's call graph profiling. LLVM doesn't use it
     *(.text .stub .text.* .gnu.linkonce.t.*)
     ...

This order is a bit arbitrary. gold and LLD have -z keep-text-section-prefix. With the option,
there can be several output sections, with the '.unlikely'/'.exit'/'.startup'/etc suffix.
This has the advantage that the hot/unlikely/exit/etc attribution of a particular function is more obvious:

   [ 2] .text             PROGBITS        000000000040007c 00007c 000003 00  AX  0   0  4
   [ 3] .text.startup     PROGBITS        000000000040007f 00007f 000001 00  AX  0   0  1
   [ 4] .text.exit        PROGBITS        0000000000400080 000080 000002 00  AX  0   0  1
   [ 5] .text.unlikely    PROGBITS        0000000000400082 000082 000001 00  AX  0   0  1 
   ...

In our case we only need one output section.......

If we place all text sections in one input section description:

     *(.text.unlikely .text.*_unlikely .text.exit .text.exit.* .text.startup .text.startup.* .text.hot .text.hot.* ... )

In many cases the input sections are laid out in the input order. In LLD there are two ordering cases:

* If clang PGO (-fprofile-use=) is enabled, .llvm.call-graph-profile will be created automatically.
   LLD can perform reordering **within an input section description**. The ordering is quite complex,
   you can read https://github.com/llvm/llvm-project/blob/master/lld/ELF/CallGraphSort.cpp#L9 if you are curious:)

   I don't know the performance improvement of this heuristic. (I don't think the original paper
   cgo2017-hfsort-final1.pdf took ThinLTO into account, so the result might not
   reflect realistic work loads where both ThinLTO and PGO are used) This, if matters, likely only matters
   for very large executable, not the case for the kernel.
* On some RISC architectures (ARM/AArch64/PowerPC),
   the ordered sections (due to either .llvm.call-graph-profile or
   --symbol-reordering-file=; the two can't be used together) are placed in a
   suitable place in the input section description
   ( http://reviews.llvm.org/D44969 )


In summary, using one (large) input section description may have some
performance improvement with LLD but I don't think it will be significant.
There may be some size improvement for ARM/AArch64/PowerPC if someone wants to test.

>commit 9bebe9e5b0f3109a14000df25308c2971f872605
>Author: Andi Kleen <ak@linux.intel.com>
>Date:   Sun Jul 19 18:01:19 2015 -0700
>
>    kbuild: Fix .text.unlikely placement
>
>    When building a kernel with .text.unlikely text the unlikely text for
>    each translation unit was put next to the main .text code in the
>    final vmlinux.
>
>    The problem is that the linker doesn't allow more specific submatches
>    of a section name in a different linker script statement after the
>    main match.
>
>    So we need to move them all into one line. With that change
>    .text.unlikely is at the end of everything again.
>
>    I also moved .text.hot into the same statement though, even though
>    that's not strictly needed.
>
>    Signed-off-by: Andi Kleen <ak@linux.intel.com>
>    Signed-off-by: Michal Marek <mmarek@suse.com>
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index 8bd374d3cf21..1781e54ea6d3 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -412,12 +412,10 @@
>  * during second ld run in second ld pass when generating System.map */
> #define TEXT_TEXT							\
> 		ALIGN_FUNCTION();					\
>-		*(.text.hot)						\
>-		*(.text .text.fixup)					\
>+		*(.text.hot .text .text.fixup .text.unlikely)		\
> 		*(.ref.text)						\
> 	MEM_KEEP(init.text)						\
> 	MEM_KEEP(exit.text)						\
>-		*(.text.unlikely)
>
>
> /* sched.text is aling to function alignment to secure we have same
