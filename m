Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34272 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbdC1VPL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 17:15:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so21785037wrb.1
        for <linux-arch@vger.kernel.org>; Tue, 28 Mar 2017 14:15:10 -0700 (PDT)
Date: Wed, 29 Mar 2017 00:15:07 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 6/8] x86/dump_pagetables: Add support 5-level paging
Message-ID: <20170328211507.ungejuigkewn6prl@node.shutemov.name>
References: <20170328093946.GA30567@gmail.com>
 <20170328104806.41711-1-kirill.shutemov@linux.intel.com>
 <20170328185522.5akqgfh4niqi3ptf@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328185522.5akqgfh4niqi3ptf@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170328211507.vaBA_FbCJtGKK8-Wkt7InU077aWDvFCNAeO9VpmPWWM@z>

On Tue, Mar 28, 2017 at 08:55:22PM +0200, Borislav Petkov wrote:
> On Tue, Mar 28, 2017 at 01:48:06PM +0300, Kirill A. Shutemov wrote:
> > Simple extension to support one more page table level.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/mm/dump_pagetables.c | 59 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 45 insertions(+), 14 deletions(-)
> 
> Hmm, so without this I get the splat below.

On current tip/master?

> Can we do something about this bisection breakage? I mean, this is the
> second explosion caused by 5level paging I trigger. Maybe we should
> merge the whole thing into a single big patch when everything is applied
> and tested, more or less, so that bisection is fine.
> 
> Or someone might have a better idea...

I'm not sure that collapsing history in one commit to fix bisectability is
any better than having broken bisectability.

I'll try to look more into this issue tomorrow.

Sorry for this.

-- 
 Kirill A. Shutemov
