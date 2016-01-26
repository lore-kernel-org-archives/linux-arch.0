From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 12/17] memremap: Change region_intersects() to take @flags
 and @desc
Date: Tue, 26 Jan 2016 13:08:05 -0800
Message-ID: <CAPcyv4j1g2FRvMZfn28B7KkTHmv4z5nmca2bS7e4Xi3dWHqSTg@mail.gmail.com>
References: <1453841853-11383-1-git-send-email-bp@alien8.de>
	<1453841853-11383-13-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1453841853-11383-13-git-send-email-bp@alien8.de>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jakub Sitnicki <jsitnicki@gmail.com>, Jan Kara <jack@suse.cz>, Jiang Liu <jiang.liu@linux.intel.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 26, 2016 at 12:57 PM, Borislav Petkov <bp@alien8.de> wrote:
> From: Toshi Kani <toshi.kani@hpe.com>
>
> Change region_intersects() to identify a target with @flags and @desc,
> instead of @name with strcmp().
>
> Change the callers of region_intersects(), memremap() and
> devm_memremap(), to set IORESOURCE_SYSTEM_RAM in @flags and
> IORES_DESC_NONE in @desc when searching System RAM.
>
> Also, export region_intersects() so that the ACPI EINJ error injection
> driver can call this function in a later patch.
>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
