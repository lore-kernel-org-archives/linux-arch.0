Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36779 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbdC1GGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 02:06:14 -0400
Date: Tue, 28 Mar 2017 08:06:04 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/8] x86/boot: Detect 5-level paging support
Message-ID: <20170328060604.GA20135@gmail.com>
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
 <20170327162925.16092-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327162925.16092-2-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170328060604.uuV_8HqR6ryQ5Ak4yogWcbFWDk0oipU3aoxANAh9scg@z>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> +#ifdef CONFIG_X86_5LEVEL
> +#define DISABLE_LA57	0
> +#else
> +#define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
> +#endif

> +#ifdef CONFIG_X86_5LEVEL
> +# define NEED_LA57	(1<<(X86_FEATURE_LA57 & 31))
> +#else
> +# define NEED_LA57	0
> +#endif

Please use consistent style.

Thanks,

	Ingo
