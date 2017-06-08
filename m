From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCHv7 05/14] x86/boot/efi: Define __KERNEL32_CS GDT on 64-bit
 configurations
Date: Thu, 8 Jun 2017 15:18:42 +0100
Message-ID: <20170608141842.GD3220@codeblueprint.co.uk>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170606113133.22974-6-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170606113133.22974-6-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 06 Jun, at 02:31:24PM, Kirill A. Shutemov wrote:
> We would need to switch temporarily to compatibility mode during booting
> with 5-level paging enabled. It would require 32-bit code segment
> descriptor.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> ---
>  arch/x86/boot/compressed/eboot.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
