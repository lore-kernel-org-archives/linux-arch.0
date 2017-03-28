From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 6/8] x86/dump_pagetables: Add support 5-level paging
Date: Tue, 28 Mar 2017 08:12:59 +0200
Message-ID: <20170328061259.GC20135@gmail.com>
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
 <20170327162925.16092-7-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170327162925.16092-7-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> +#if PTRS_PER_P4D > 1
> +
> +static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
> +							unsigned long P)

Pretty ugly line break. Either don't break the line, or break it in a more logical 
place, like:

static void
walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr, unsigned long P)

> +	start = (p4d_t *) pgd_page_vaddr(addr);

The space between the type cast and the function invocation is not needed.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
