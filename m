Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33047 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdE0Wqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 May 2017 18:46:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so9608178wmh.0
        for <linux-arch@vger.kernel.org>; Sat, 27 May 2017 15:46:33 -0700 (PDT)
Date: Sun, 28 May 2017 01:46:24 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv1, RFC 5/8] x86/mm: Fold p4d page table layer at runtime
Message-ID: <20170527224624.opc4yg4m7irvwbjl@node.shutemov.name>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <20170525203334.867-6-kirill.shutemov@linux.intel.com>
 <CAMzpN2j+CMCn-5pgEVZBNm9JMK1GEodvXqEtpAB2NXwTTHSM6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2j+CMCn-5pgEVZBNm9JMK1GEodvXqEtpAB2NXwTTHSM6g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170527224624.qZsYLFHuCYYLDS9vQO7mxrK1auLH2a9K1I8FPrjNPUs@z>

On Sat, May 27, 2017 at 11:09:54AM -0400, Brian Gerst wrote:
> >  static inline int pgd_none(pgd_t pgd)
> >  {
> > +       if (p4d_folded)
> > +               return 0;
> >         /*
> >          * There is no need to do a workaround for the KNL stray
> >          * A/D bit erratum here.  PGDs only point to page tables
> 
> These should use static_cpu_has(X86_FEATURE_LA57), so that it gets
> patched by alternatives.

Right, eventually we would likely need something like this. But at this
point I'm more worried about correctness than performance. Performance
will be the next step.

And I haven't tried it yet, but I would expect direct use of alternatives
wouldn't be possible. If I read code correctly, we enable paging way
before we apply alternatives. But we need to have something functional in
between.

I guess it will be fun :)

-- 
 Kirill A. Shutemov
