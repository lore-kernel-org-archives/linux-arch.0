From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7/7] x86/mm: Switch to generic get_user_page_fast()
 implementation
Date: Thu, 16 Mar 2017 18:20:46 +0100
Message-ID: <20170316172046.sl7j5elg77yjevau@hirez.programming.kicks-ass.net>
References: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
 <20170316152655.37789-8-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170316152655.37789-8-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Dann Frazier <dann.frazier@canonical.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 16, 2017 at 06:26:55PM +0300, Kirill A. Shutemov wrote:
> +config HAVE_GENERIC_RCU_GUP
> +	def_bool y
> +

Nothing immediately jumped out to me; except that this option might be
misnamed.

AFAICT that code does not in fact rely on HAVE_RCU_TABLE_FREE; it will
happily work with the (x86) broadcast IPI invalidate model, as you show
here.

Architectures that do not do that obviously need HAVE_RCU_TABLE_FREE,
but that is not the point I feel.

Also, this code hard relies on IRQ-disable delaying grace periods, which
is mostly true I think, but has always been something Paul didn't really
want to commit too firmly to.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
