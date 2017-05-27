From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCHv1, RFC 5/8] x86/mm: Fold p4d page table layer at runtime
Date: Sat, 27 May 2017 18:56:54 -0400
Message-ID: <CAMzpN2gqK-QKwMh-tzXvU-tCKGWuhRdA6BFswsSQpT+YVuQyQQ@mail.gmail.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <20170525203334.867-6-kirill.shutemov@linux.intel.com> <CAMzpN2j+CMCn-5pgEVZBNm9JMK1GEodvXqEtpAB2NXwTTHSM6g@mail.gmail.com>
 <20170527224624.opc4yg4m7irvwbjl@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:35285 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdE0W44 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 May 2017 18:56:56 -0400
In-Reply-To: <20170527224624.opc4yg4m7irvwbjl@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, May 27, 2017 at 6:46 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Sat, May 27, 2017 at 11:09:54AM -0400, Brian Gerst wrote:
>> >  static inline int pgd_none(pgd_t pgd)
>> >  {
>> > +       if (p4d_folded)
>> > +               return 0;
>> >         /*
>> >          * There is no need to do a workaround for the KNL stray
>> >          * A/D bit erratum here.  PGDs only point to page tables
>>
>> These should use static_cpu_has(X86_FEATURE_LA57), so that it gets
>> patched by alternatives.
>
> Right, eventually we would likely need something like this. But at this
> point I'm more worried about correctness than performance. Performance
> will be the next step.
>
> And I haven't tried it yet, but I would expect direct use of alternatives
> wouldn't be possible. If I read code correctly, we enable paging way
> before we apply alternatives. But we need to have something functional in
> between.

static_cpu_has() does the check dynamically before alternatives are
applied, so using it early isn't a problem.
