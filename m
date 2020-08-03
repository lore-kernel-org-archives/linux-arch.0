From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Date: Mon, 3 Aug 2020 16:15:25 -0400
Message-ID: <20200803201525.GA1351390@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
 <20200801035128.GB2800311@rani.riverdale.lan>
 <20200803190506.GE1299820@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200803190506.GE1299820@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Jian Cai <jiancai@google.com>, =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Arnd
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 03, 2020 at 12:05:06PM -0700, Andi Kleen wrote:
> > However, the history of their being together comes from
> > 
> >   9bebe9e5b0f3 ("kbuild: Fix .text.unlikely placement")
> > 
> > which seems to indicate there was some problem with having them separated out,
> > although I don't quite understand what the issue was from the commit message.
> 
> Separating it out is less efficient. Gives worse packing for the hot part
> if they are not aligned to 64byte boundaries, which they are usually not. 
> 
> It also improves packing of the cold part, but that probably doesn't matter.
> 
> -Andi

Why is that? Both .text and .text.hot have alignment of 2^4 (default
function alignment on x86) by default, so it doesn't seem like it should
matter for packing density.  Avoiding interspersing cold text among
regular/hot text seems like it should be a net win.

That old commit doesn't reference efficiency -- it says there was some
problem with matching when they were separated out, but there were no
wildcard section names back then.

commit 9bebe9e5b0f3109a14000df25308c2971f872605
Author: Andi Kleen <ak@linux.intel.com>
Date:   Sun Jul 19 18:01:19 2015 -0700

    kbuild: Fix .text.unlikely placement
    
    When building a kernel with .text.unlikely text the unlikely text for
    each translation unit was put next to the main .text code in the
    final vmlinux.
    
    The problem is that the linker doesn't allow more specific submatches
    of a section name in a different linker script statement after the
    main match.
    
    So we need to move them all into one line. With that change
    .text.unlikely is at the end of everything again.
    
    I also moved .text.hot into the same statement though, even though
    that's not strictly needed.
    
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Signed-off-by: Michal Marek <mmarek@suse.com>

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8bd374d3cf21..1781e54ea6d3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -412,12 +412,10 @@
  * during second ld run in second ld pass when generating System.map */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot)						\
-		*(.text .text.fixup)					\
+		*(.text.hot .text .text.fixup .text.unlikely)		\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\
-		*(.text.unlikely)
 
 
 /* sched.text is aling to function alignment to secure we have same
