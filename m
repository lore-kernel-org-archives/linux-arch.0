Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33033 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbcGHIqo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jul 2016 04:46:44 -0400
Date: Fri, 8 Jul 2016 10:46:39 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/9] mm: Hardened usercopy
Message-ID: <20160708084639.GA4562@gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Jan Kara <jack@suse.cz>, Vitaly Wool <vitalywool@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, Laura Abbott <labbott@fedoraproject.org>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, kernel-hardening@lists.openwall.com, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Message-ID: <20160708084639.Ybqo1sSvzAj6cvFDq5d1YTVrL_HqVdQotHAKExJFotA@z>


* Kees Cook <keescook@chromium.org> wrote:

> - I couldn't detect a measurable performance change with these features
>   enabled. Kernel build times were unchanged, hackbench was unchanged,
>   etc. I think we could flip this to "on by default" at some point.

Could you please try to find some syscall workload that does many small user 
copies and thus excercises this code path aggressively?

If that measurement works out fine then I'd prefer to enable these security checks 
by default.

Thaks,

	Ingo
