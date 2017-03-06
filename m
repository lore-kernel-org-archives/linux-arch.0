Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38532 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbdCFTBT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2017 14:01:19 -0500
Received: by mail-it0-f54.google.com with SMTP id m27so56635839iti.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2017 10:59:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Mar 2017 10:27:18 -0800
Message-ID: <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com>
Subject: Re: [PATCHv4 00/33] 5-level paging
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170306182718.Lh-NayjV-IdaZZfIX-NzS3LnpXAA1zRacP1v_kqDYqE@z>

On Mon, Mar 6, 2017 at 5:53 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Here is v4 of 5-level paging patchset. Please review and consider applying.

I think we should just aim for this being in 4.12. I don't see any
real reason to delay merging it, the main question in my mind is which
tree it would go through. A separate x86 -tip branch, or Andrew's mm
tree or me just pulling directly, or what?

I basically think it's in good enough shape that future work might as
well be based on this being merged. No?

                   Linus
