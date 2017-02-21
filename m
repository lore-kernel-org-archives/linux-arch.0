Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33116 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdBUMmV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2017 07:42:21 -0500
Received: by mail-wr0-f195.google.com with SMTP id s27so5939204wrb.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Feb 2017 04:42:20 -0800 (PST)
Date: Tue, 21 Feb 2017 15:42:17 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv3 33/33] mm, x86: introduce PR_SET_MAX_VADDR and
 PR_GET_MAX_VADDR
Message-ID: <20170221124217.GB13174@node.shutemov.name>
References: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
 <20170217141328.164563-34-kirill.shutemov@linux.intel.com>
 <CALCETrVKKU_eJVH3scF=89z98dba8iHwuNfdUPE9Hx=-3b_+Pg@mail.gmail.com>
 <CAJwJo6ajrum1AkMS4Mu7nXBzAui_9+fjARBN8NpsFEdA+ZeN7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6ajrum1AkMS4Mu7nXBzAui_9+fjARBN8NpsFEdA+ZeN7A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20170221124217.QZRhyQJMEynFxSMzYDsmKCChjfbsp0VNpME3GIrsr5Q@z>

On Tue, Feb 21, 2017 at 02:54:20PM +0300, Dmitry Safonov wrote:
> 2017-02-17 19:50 GMT+03:00 Andy Lutomirski <luto@amacapital.net>:
> > On Fri, Feb 17, 2017 at 6:13 AM, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> >> This patch introduces two new prctl(2) handles to manage maximum virtual
> >> address available to userspace to map.
> ...
> > Anyway, can you and Dmitry try to reconcile your patches?
> 
> So, how can I help that?
> Is there the patch's version, on which I could rebase?
> Here are BTW the last patches, which I will resend with trivial ifdef-fixup
> after the merge window:
> http://marc.info/?i=20170214183621.2537-1-dsafonov%20()%20virtuozzo%20!%20com

Could you check if this patch collides with anything you do:

http://lkml.kernel.org/r/20170220131515.GA9502@node.shutemov.name

-- 
 Kirill A. Shutemov
