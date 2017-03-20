From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above 47-bits
Date: Mon, 20 Mar 2017 10:40:20 +0530
Message-ID: <8760j4sfcz.fsf@skywalker.in.ibm.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com> <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
 @@ -168,6 +182,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	unsigned long addr = addr0;
>  	struct vm_unmapped_area_info info;
>  
> +	addr = mpx_unmapped_area_check(addr, len, flags);
> +	if (IS_ERR_VALUE(addr))
> +		return addr;
> +
>  	/* requested length too big for entire address space */
>  	if (len > TASK_SIZE)
>  		return -ENOMEM;
> @@ -192,6 +210,14 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	info.length = len;
>  	info.low_limit = PAGE_SIZE;
>  	info.high_limit = mm->mmap_base;
> +
> +	/*
> +	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
> +	 * in the full address space.
> +	 */
> +	if (addr > DEFAULT_MAP_WINDOW)
> +		info.high_limit += TASK_SIZE - DEFAULT_MAP_WINDOW;
> +

Is this ok for 32 bit application ?


>  	info.align_mask = 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;
>  	if (filp) {


-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
