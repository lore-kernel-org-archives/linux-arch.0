From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
Date: Fri, 26 May 2017 00:21:41 -0700
Message-ID: <CALCETrUCsWxLNGTN=CUZWWagghEwVdPYr6UFzwTENFTr6JTfRA@mail.gmail.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
 <CALCETrWACTFPDrpuZgoPqeRLU4ZooDjHOpQaNCFmCfVCHM-sHQ@mail.gmail.com> <20170526041853.GA27213@la.guarana.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762110AbdEZHWE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 03:22:04 -0400
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com [209.85.217.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A21239F3
        for <linux-arch@vger.kernel.org>; Fri, 26 May 2017 07:22:03 +0000 (UTC)
Received: by mail-ua0-f174.google.com with SMTP id y4so1599537uay.2
        for <linux-arch@vger.kernel.org>; Fri, 26 May 2017 00:22:03 -0700 (PDT)
In-Reply-To: <20170526041853.GA27213@la.guarana.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kevin Easton <kevin@guarana.org>
Cc: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, May 25, 2017 at 9:18 PM, Kevin Easton <kevin@guarana.org> wrote:
> (If it weren't for that, maybe you could point the last entry in the PML4
> at the PML4 itself, so it also works as a PML5 for accessing kernel
> addresses? And of course make sure nothing gets loaded above
> 0xffffff8000000000).

This was an old trick done for a very different reason: it lets you
find your page tables at virtual addresses that depend only on the VA
whose page table you're looking for and the top-level slot that points
back to itself.  IIRC Windows used to do this for its own memory
management purposes.  A major downside is that an arbitrary write
vulnerability lets you write your own PTEs without any guesswork.

--Andy
