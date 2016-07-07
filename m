From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 1/9] mm: Hardened usercopy
Date: Thu, 7 Jul 2016 08:37:10 +0300
Message-ID: <20160707053710.GH2118@tarshish>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1467843928-29351-2-git-send-email-keescook@chromium.org>
Sender: owner-linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, kernel-hardening@lists.openwall.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, Christoph Lameter <cl@linux.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, PaX Team <pageexec@freemail.hu>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Fenghua Yu <fenghua.yu@intel.com>, Rik van Riel <riel@redhat.com>, Vitaly Wool <vitalywool@gmail.com>, David Rientjes <rientjes@google.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-arch.vger.kernel.org

Hi Kees,

On Wed, Jul 06, 2016 at 03:25:20PM -0700, Kees Cook wrote:
> +#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR

Should be CONFIG_HARDENED_USERCOPY to match the slab/slub implementation 
condition.

> +const char *__check_heap_object(const void *ptr, unsigned long n,
> +				struct page *page);
> +#else
> +static inline const char *__check_heap_object(const void *ptr,
> +					      unsigned long n,
> +					      struct page *page)
> +{
> +	return NULL;
> +}
> +#endif

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
