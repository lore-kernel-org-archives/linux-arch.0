From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/6] x86/xen: Change __xen_pgd_walk() and
 xen_cleanmfnmap() to support p4d
Date: Mon, 27 Mar 2017 08:34:23 +0200
Message-ID: <20170327063423.GA13876@gmail.com>
References: <20170317185515.8636-1-kirill.shutemov@linux.intel.com>
 <20170317185515.8636-6-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170317185515.8636-6-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Xiong Zhang <xiong.y.zhang@intel.com>
List-Id: linux-arch.vger.kernel.org

y
* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> Split these helpers into few per-level functions and add support of
> additional page table level.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> [kirill.shutemov@linux.intel.com: split off into separate patch]
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

So who's the primary author of this patch, you or Xiong Zhang? If the latter then 
a "From: " line is missing. For now I've added the missing "From" line.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
