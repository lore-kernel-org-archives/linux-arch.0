From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Date: Mon, 13 Jan 2020 18:42:25 +0100
Message-ID: <20200113174225.xs3n7t3obysbsmzd@ltop.local>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-7-will@kernel.org>
 <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
 <20200113145954.GB4458@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200113145954.GB4458@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 13, 2020 at 02:59:54PM +0000, Will Deacon wrote:
> // Insert big fat comment here
> #define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))
> 
> That apparently *requires* GCC 4.8, but I think the question is more about
> whether it's easier to stomach the funny use of _Atomic or the nested
> __builtin_choose_expr() I have here. I'm also worried about how reliable
> the _Atomic thing is, or whether it's just an artifact of how GCC happens
> to work today.

As far as I understand it, it's an artifact of how GCC works today (it
was added to support the type-generic macros in <tgmath.h>).
I also think it's also quite fragile, for example, the unqualified type
is returned if typeof's argument is an expression but not if it's a
'typename'. IOW:
	typeof(_Atomic typeof(const int))
returns 'const int', while
	typeof(({_Atomic typeof(const int) x; x; }))
returns 'int'.

-- Luc
