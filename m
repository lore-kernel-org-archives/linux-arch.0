From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH, REBASED] asm-generic, mm: PTE_SPECIAL cleanup
Date: Fri, 7 Dec 2012 12:35:17 -0800
Message-ID: <20121207123517.3fc93a34.akpm@linux-foundation.org>
References: <1354881321-29363-1-git-send-email-kirill.shutemov@linux.intel.com>
	<20121207143002.GB21233@arm.com>
	<20121207144112.GA17044@otc-wbsnb-06>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20121207144112.GA17044@otc-wbsnb-06>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 7 Dec 2012 16:41:12 +0200
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Advertise PTE_SPECIAL through Kconfig option and consolidate dummy
> pte_special() and mkspecial() in <asm-generic/pgtable.h>

why?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
