Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:20034 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbdCHPHs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Mar 2017 10:07:48 -0500
Date: Wed, 8 Mar 2017 18:07:42 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/7] 5-level paging: prepare generic code
Message-ID: <20170308150742.aaqfknxhurvvrvsl@black.fi.intel.com>
References: <20170306204514.1852-1-kirill.shutemov@linux.intel.com>
 <20170308142501.GB11034@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308142501.GB11034@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170308150742.TY9IijEW3yvvC_eCWJxtjV4016sdm9kpEAP3P8e_54c@z>

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
