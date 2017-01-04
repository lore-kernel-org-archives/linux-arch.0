Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33006 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758164AbdADOUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2017 09:20:02 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so91727849wmu.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Jan 2017 06:20:02 -0800 (PST)
Date: Wed, 4 Jan 2017 17:19:59 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
Message-ID: <20170104141959.GC17319@node.shutemov.name>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
 <2736959.3MfCab47fD@wuerfel>
 <CALCETrV_qejd-Ozqo4vTqz=LuukMUPeQ7EVUQbfTxs_xNbO3oQ@mail.gmail.com>
 <20170103160457.GB17319@node.shutemov.name>
 <CALCETrW3=SsQeC-gWOVqwTtg022+gHei=xfUc2ei3kkX0CACpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW3=SsQeC-gWOVqwTtg022+gHei=xfUc2ei3kkX0CACpg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20170104141959.6pON0lCpfptCmgHTeo5wsatFOQALCkgQNSy-8I5hceg@z>

On Tue, Jan 03, 2017 at 10:27:22AM -0800, Andy Lutomirski wrote:
> On Tue, Jan 3, 2017 at 8:04 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > And what about stack? I'm not sure that everybody would be happy with
> > stack in the middle of address space.
> 
> I would, personally.  I think that, for very large address spaces, we
> should allocate a large block of stack and get rid of the "stack grows
> down forever" legacy idea.  Then we would never need to worry about
> the stack eventually hitting some other allocation.  And 2^57 bytes is
> hilariously large for a default stack.

The stack in the middle of address space can prevent creating other huuuge
contiguous mapping. Databases may want this.

-- 
 Kirill A. Shutemov
