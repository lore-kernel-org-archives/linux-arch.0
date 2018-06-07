Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933108AbeFGSmO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 14:42:14 -0400
Date: Thu, 7 Jun 2018 20:41:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 02/10] x86/cet: Introduce WRUSS instruction
Message-ID: <20180607184142.GJ12217@hirez.programming.kicks-ass.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-3-yu-cheng.yu@intel.com>
 <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607184142.hmcoCTRFmdu95tqDzdCJpAr8G2pEkQqoHR-lWggCsrA@z>

On Thu, Jun 07, 2018 at 09:40:02AM -0700, Andy Lutomirski wrote:
> Peterz, isn't there some fancy better way we're supposed to handle the
> error return these days?

Don't think so. I played with a few things but that never really went
anywhere.

Also, both asm things look suspicously similar, it might make sense to
share. Also, maybe do the instruction .byte sequence in a #define INSN
or something.
