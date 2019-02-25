Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:55472 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfBYOxk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Feb 2019 09:53:40 -0500
Date: Mon, 25 Feb 2019 15:53:31 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 11/28] x86/asm/head: annotate data appropriatelly
Message-ID: <20190225145330.GF26145@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-12-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-12-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190225145331.BHThDig4vwCRtDoTINNBuAKgqFz1nJhnUn0vGiCjKFQ@z>

On Wed, Jan 30, 2019 at 01:46:54PM +0100, Jiri Slaby wrote:
> Use the new SYM_DATA, SYM_DATA_START, and SYM_DATA_END in both 32 and 64
> bit heads.  In the 64-bit version, define also
> SYM_DATA_START_PAGE_ALIGNED locally using the new SYM_START. It is used
> in the code instead of NEXT_PAGE() which was defined in this file and
> has been using the obsolete macro GLOBAL().
> 
> Now, the data in the 64-bit object file look sane:
> Value   Size Type    Bind   Vis      Ndx Name
>   0000  4096 OBJECT  GLOBAL DEFAULT   15 init_level4_pgt
>   1000  4096 OBJECT  GLOBAL DEFAULT   15 level3_kernel_pgt
>   2000  2048 OBJECT  GLOBAL DEFAULT   15 level2_kernel_pgt
	  ^^^^

Except that this size is kinda misleading.

We end up using a whole page for this because of the alignment of the
next one but because we're not filing it up properly, the symbol has the
size of a half a page:

ffffffff8200f000 <level2_kernel_pgt>:
ffffffff8200f7f6:       00 00                   add    %al,(%rax)
ffffffff8200f7f8:       e3 01                   jrcxz  ffffffff8200f7fb <level2_kernel_pgt+0x7fb>
ffffffff8200f7fa:       e0 1f                   loopne ffffffff8200f81b <level2_kernel_pgt+0x81b>
        ...

ffffffff82010000 <level2_fixmap_pgt>:

That's a whole page with 2K padding.

You can do this in a prepatch:

---
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 5b7a3b430dea..93a9fd294962 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -448,6 +448,7 @@ SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
+	.fill 512 - KERNEL_IMAGE_SIZE/PMD_SIZE,8,0
 SYM_DATA_END(level2_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
---

and then we get the proper symbol size:

 69952: ffffffff8200f000  4096 OBJECT  GLOBAL DEFAULT   11 level2_kernel_pgt

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
