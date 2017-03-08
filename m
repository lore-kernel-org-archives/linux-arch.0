From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/7] 5-level paging: prepare generic code
Date: Wed, 8 Mar 2017 18:07:42 +0300
Message-ID: <20170308150742.aaqfknxhurvvrvsl@black.fi.intel.com>
References: <20170306204514.1852-1-kirill.shutemov@linux.intel.com>
 <20170308142501.GB11034@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170308142501.GB11034@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 08, 2017 at 03:25:01PM +0100, Michal Hocko wrote:
> Btw. my build test machinery has reported this:
> microblaze/allnoconfig

Thanks.

Fixup is below. I guess it should be folded into 4/7.

diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index fd850879854d..d506bb0893f9 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -95,7 +95,8 @@ typedef struct { unsigned long pgd; } pgd_t;
 #   else /* CONFIG_MMU */
 typedef struct { unsigned long	ste[64]; }	pmd_t;
 typedef struct { pmd_t		pue[1]; }	pud_t;
-typedef struct { pud_t		pge[1]; }	pgd_t;
+typedef struct { pud_t		p4e[1]; }	p4d_t;
+typedef struct { p4d_t		pge[1]; }	pgd_t;
 #   endif /* CONFIG_MMU */
 
 # define pte_val(x)	((x).pte)
-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
