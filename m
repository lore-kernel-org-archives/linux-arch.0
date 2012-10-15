From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] asm-generic, mm: PTE_SPECIAL cleanup
Date: Mon, 15 Oct 2012 17:16:13 +0100
Message-ID: <CAHkRjk7akwhcmeYV_Ank-YVotUMW0mN_1xeu5zbXWE+z5d9xdg@mail.gmail.com>
References: <1350302608-8322-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1350302608-8322-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 15 October 2012 13:03, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Advertise PTE_SPECIAL through Kconfig option and consolidate dummy
> pte_special() and mkspecial() in <asm-generic/pgtable.h>
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/Kconfig                             |    6 ++++++
>  arch/alpha/include/asm/pgtable.h         |    2 --
>  arch/arm/include/asm/pgtable.h           |    3 ---
>  arch/arm64/Kconfig                       |    1 +
>  arch/arm64/include/asm/pgtable.h         |    2 --

For the arm64 bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
