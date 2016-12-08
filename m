From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC, PATCHv1 24/28] x86/mm: add sync_global_pgds() for
 configuration with 5-level paging
Date: Thu, 8 Dec 2016 10:42:19 -0800
Message-ID: <CALCETrWE2WSUe-m9MKmKEK44zNQuuECJ_2agnTv=AkLdOFgR=A@mail.gmail.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com> <20161208162150.148763-26-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35173 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbcLHSmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2016 13:42:42 -0500
Received: by mail-ua0-f182.google.com with SMTP id 12so456677612uas.2
        for <linux-arch@vger.kernel.org>; Thu, 08 Dec 2016 10:42:42 -0800 (PST)
In-Reply-To: <20161208162150.148763-26-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Dec 8, 2016 at 8:21 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> This basically restores slightly modified version of original
> sync_global_pgds() which we had before foldedl p4d was introduced.
>
> The only modification is protection against 'address' overflow.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/mm/init_64.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index a991f5c4c2c4..d637893ac8c2 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -92,6 +92,52 @@ __setup("noexec32=", nonx32_setup);
>   * When memory was added/removed make sure all the processes MM have
>   * suitable PGD entries in the local PGD level page.
>   */
> +#ifdef CONFIG_X86_5LEVEL
> +void sync_global_pgds(unsigned long start, unsigned long end, int removed)
> +{
> +        unsigned long address;
> +
> +       for (address = start; address <= end && address >= start;
> +                       address += PGDIR_SIZE) {
> +                const pgd_t *pgd_ref = pgd_offset_k(address);
> +                struct page *page;
> +
> +                /*
> +                 * When it is called after memory hot remove, pgd_none()
> +                 * returns true. In this case (removed == 1), we must clear
> +                 * the PGD entries in the local PGD level page.
> +                 */
> +                if (pgd_none(*pgd_ref) && !removed)
> +                        continue;

This isn't quite specific to your patch, but can we assert that, if
removed=1, then we're not operating on the vmalloc range?  Because if
we do, this will be racy is nasty ways.
