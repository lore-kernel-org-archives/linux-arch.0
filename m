From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm: fix section name for .data..ro_after_init
Date: Tue, 28 Mar 2017 07:35:39 +0200
Message-ID: <20170328053539.GA4902@osiris>
References: <20170327192213.GA129375@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170327192213.GA129375@beast>
Sender: owner-linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Eddie Kovsky <ewk@edkovsky.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 27, 2017 at 12:22:13PM -0700, Kees Cook wrote:
> A section name for .data..ro_after_init was added by both:
> 
>     commit d07a980c1b8d ("s390: add proper __ro_after_init support")
> 
> and
> 
>     commit d7c19b066dcf ("mm: kmemleak: scan .data.ro_after_init")
> 
> The latter adds incorrect wrapping around the existing s390 section,
> and came later. I'd prefer the s390 naming, so this moves the
> s390-specific name up to the asm-generic/sections.h and renames the
> section as used by kmemleak (and in the future, kernel/extable.c).
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Eddie Kovsky <ewk@edkovsky.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/s390/include/asm/sections.h  | 1 -
>  arch/s390/kernel/vmlinux.lds.S    | 2 --
>  include/asm-generic/sections.h    | 6 +++---
>  include/asm-generic/vmlinux.lds.h | 4 ++--
>  mm/kmemleak.c                     | 2 +-
>  5 files changed, 6 insertions(+), 9 deletions(-)

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
