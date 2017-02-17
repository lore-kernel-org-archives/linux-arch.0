Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:3175 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbdBQRT5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Feb 2017 12:19:57 -0500
Subject: Re: [PATCHv3 33/33] mm, x86: introduce PR_SET_MAX_VADDR and
 PR_GET_MAX_VADDR
References: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
 <20170217141328.164563-34-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ae15457f-731d-bb1b-c60d-14d641c265f0@intel.com>
Date: Fri, 17 Feb 2017 09:19:56 -0800
MIME-Version: 1.0
In-Reply-To: <20170217141328.164563-34-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-api@vger.kernel.org
Message-ID: <20170217171956.-j11pS15rRowLpP327ClUQtby1pEMpHEfF8bOS674OQ@z>

On 02/17/2017 06:13 AM, Kirill A. Shutemov wrote:
> +/*
> + * Default maximum virtual address. This is required for
> + * compatibility with applications that assumes 47-bit VA.
> + * The limit can be changed with prctl(PR_SET_MAX_VADDR).
> + */
> +#define MAX_VADDR_DEFAULT	((1UL << 47) - PAGE_SIZE)

This is a bit goofy.  It's not the largest virtual adddress that can be
accessed, but the beginning of the last page.

Isn't this easier to deal with in userspace if we make it a "limit", so
we can do:

	if (addr >= limit)
		// error

Now, we have to do:
	
	prctl(PR_GET_MAX_VADDR, &max_vaddr, 0, 0, 0);
	if (addr > (max_vaddr + PAGE_SIZE))
		// error

I don't care what you track in the kernel, but I think we need to
provide a more usable number out to userspace.
