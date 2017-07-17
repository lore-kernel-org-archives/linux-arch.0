From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 3/8] x86/xen: Redefine XEN_ELFNOTE_INIT_P2M using PUD_SIZE
 * PTRS_PER_PUD
Date: Mon, 17 Jul 2017 07:45:24 +0200
Message-ID: <de750662-faee-ce5b-526e-3f03ab87419d@suse.com>
References: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
 <20170716225954.74185-4-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170716225954.74185-4-kirill.shutemov@linux.intel.com>
Content-Language: de-DE
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 17/07/17 00:59, Kirill A. Shutemov wrote:
> XEN_ELFNOTE_INIT_P2M has to be 512GB for both 4- and 5-level paging.
> (PUD_SIZE * PTRS_PER_PUD) would do this.
> 
> Unfortunately, we cannot use P4D_SIZE, which would fit here. With
> current headers structure it cannot be used in assembly, if p4d
> level is folded.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Thanks,

Juergen

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
