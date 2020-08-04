From: =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Date: Mon, 3 Aug 2020 22:32:27 -0700
Message-ID: <20200804053227.k7zyozzrw5mhv6qi@google.com>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
 <20200801035128.GB2800311@rani.riverdale.lan>
 <20200803190506.GE1299820@tassilo.jf.intel.com>
 <20200803201525.GA1351390@rani.riverdale.lan>
 <20200804044532.GC1321588@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200804044532.GC1321588@tassilo.jf.intel.com>
Sender: stable-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Jian Cai <jiancai@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@g
List-Id: linux-arch.vger.kernel.org

On 2020-08-03, Andi Kleen wrote:
>> Why is that? Both .text and .text.hot have alignment of 2^4 (default
>> function alignment on x86) by default, so it doesn't seem like it should
>> matter for packing density.  Avoiding interspersing cold text among
>
>You may lose part of a cache line on each unit boundary. Linux has
>a lot of units, some of them small. All these bytes add up.
>
>It's bad for TLB locality too. Sadly with all the fine grained protection
>changes the 2MB coverage is eroding anyways, but this makes it even worse.

> Gives worse packing for the hot part
> if they are not aligned to 64byte boundaries, which they are usually
> not.

I do not see how the 64-byte argument is related to this patch.
If a function requires 64-byte alignment to be efficient, the compiler
should communicate this fact by setting the alignment of its containing
section to 64 bytes or above.

If a text section has a 16-byte alignment, the linker can reorder it to
an address which is a multiple of 16 but not a multiple of 64.

I agree with your other statement that having a single input section
description might be helpful. With more than one input section
descrition, the linker has to respect the ordering requirement. With
just one input section description, the linker has more freedom ordering
sections if profitable. For example, LLD performs two ordering
heuristics as my previous reply mentions.

It'd be good if someone can measure the benefit. Personally I don't
think this kind of ordering has significant benefit. (For
arm/aarch64/powerpc there might be some size benefit due to fewer range
extension thunks)

>> regular/hot text seems like it should be a net win.
>
>>
>> That old commit doesn't reference efficiency -- it says there was some
>> problem with matching when they were separated out, but there were no
>> wildcard section names back then.
>
>It was about efficiency.
>
>-Andi
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200804044532.GC1321588%40tassilo.jf.intel.com.
