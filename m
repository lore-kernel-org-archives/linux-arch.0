Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37310 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165995AbdEYXY0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 19:24:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 May 2017 16:24:24 -0700
Message-ID: <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170525232424.1zalLdyvnVxqwc9ZFiZxLnCEpvFQms1ZTtk2LX0TdCs@z>

On Thu, May 25, 2017 at 1:33 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Here' my first attempt to bring boot-time between 4- and 5-level paging.
> It looks not too terrible to me. I've expected it to be worse.

If I read this right, you just made it a global on/off thing.

May I suggest possibly a different model entirely? Can you make it a
per-mm flag instead?

And then we

 (a) make all kthreads use the 4-level page tables

 (b) which means that all the init code uses the 4-level page tables

 (c) which means that all those checks for "start_secondary" etc can
just go away, because those all run with 4-level page tables.

Or is it just much too expensive to switch between 4-level and 5-level
paging at run-time?

              Linus
