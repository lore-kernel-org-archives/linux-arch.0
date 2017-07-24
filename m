From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: KASAN vs. boot-time switching between 4- and 5-level paging
Date: Mon, 24 Jul 2017 15:13:31 +0300
Message-ID: <20170724121331.k3fl4xjrsmznqk2t@node.shutemov.name>
References: <CALCETrVpNUq3-zEu1Q1O77N8r4kv4kFdefXp7XEs3Hpf-JPAjg@mail.gmail.com>
 <d3caf8c4-4575-c1b5-6b0f-95527efaf2f9@virtuozzo.com>
 <f11d9e07-6b31-1add-7677-6a29d15ab608@virtuozzo.com>
 <20170711170332.wlaudicepkg35dmm@node.shutemov.name>
 <e9a395f4-018e-4c8c-2098-170172e438f3@virtuozzo.com>
 <20170711190554.zxkpjeg2bt65wtir@black.fi.intel.com>
 <20939b37-efd8-2d32-0040-3682fff927c2@virtuozzo.com>
 <20170713135228.vhvpe7mqdcqzpslw@node.shutemov.name>
 <20170713141528.rwuz5n2p57omq6wi@node.shutemov.name>
 <e201423e-5f4e-8bd6-144a-2374f7b7bb3f@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38782 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbdGXMNh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jul 2017 08:13:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id m85so15655177wma.1
        for <linux-arch@vger.kernel.org>; Mon, 24 Jul 2017 05:13:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e201423e-5f4e-8bd6-144a-2374f7b7bb3f@virtuozzo.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>

On Thu, Jul 13, 2017 at 05:19:22PM +0300, Andrey Ryabinin wrote:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?h=la57/boot-switching/v2&id=13327fec85ffe95d9c8a3f57ba174bf5d5c1fb01
> >>
> >>> As for KASAN, I think it would be better just to make it work faster,
> >>> the patch below demonstrates the idea.
> >>
> >> Okay, let me test this.
> > 
> > The patch works for me.
> > 
> > The problem is not exclusive to 5-level paging, so could you prepare and
> > push proper patch upstream?
> > 
> 
> Sure, will do

Andrey, any follow up on this?

-- 
 Kirill A. Shutemov
