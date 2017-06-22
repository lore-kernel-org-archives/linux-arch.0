Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36468 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdFVJY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2017 05:24:58 -0400
Date: Thu, 22 Jun 2017 11:24:54 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv7 13/14] x86: Enable 5-level paging support
Message-ID: <20170622092454.n4f2uho5lsp6ox4q@gmail.com>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170606113133.22974-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606113133.22974-14-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170622092454.mdraGMOImZmpCR4pjOcqtMLAWLCoUN2ms6GoSHfAsR4@z>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> Most of things are in place and we can enable support of 5-level paging.
> 
> The patch makes XEN_PV dependent on !X86_5LEVEL. XEN_PV is not ready to
> work with 5-level paging.

Please make a short comment about that in the Kconfig code as well, instead of a 
silent, undocumented 'depends' clause.

>  config PGTABLE_LEVELS
>  	int
> +	default 5 if X86_5LEVEL
>  	default 4 if X86_64
>  	default 3 if X86_PAE
>  	default 2
> @@ -1390,6 +1391,10 @@ config X86_PAE
>  	  has the cost of more pagetable lookup overhead, and also
>  	  consumes more pagetable space per process.
>  
> +config X86_5LEVEL
> +	bool "Enable 5-level page tables support"
> +	depends on X86_64

So since users will be enabling it, this needs a proper help text that explains 
what hardware supports it ("future Intel CPUs" will do if models are not public 
yet), a short blurb about what it's good for - and a link to the Documentation/ 
file explaining it all.

Thanks,

	Ingo
