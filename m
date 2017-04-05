Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34137 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932797AbdDEPcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2017 11:32:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so3704811wrb.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Apr 2017 08:32:03 -0700 (PDT)
Date: Wed, 5 Apr 2017 18:32:00 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 21/26] x86/mm: add support of additional page table level
 during early boot
Message-ID: <20170405153200.t7r7c7lyycxm2wzg@node.shutemov.name>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
 <20170313055020.69655-22-kirill.shutemov@linux.intel.com>
 <20170313071810.GA28726@gmail.com>
 <20170405113624.y5iqjvpwbvayo2cd@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405113624.y5iqjvpwbvayo2cd@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170405153200.HfeHMJRd7Y9qSeTmmZIKw_eOfvAUn2qZ3_W5IwzIJLg@z>

On Wed, Apr 05, 2017 at 02:36:24PM +0300, Kirill A. Shutemov wrote:
> On Mon, Mar 13, 2017 at 08:18:10AM +0100, Ingo Molnar wrote:
> > 
> > * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> > 
> > > This patch adds support for 5-level paging during early boot.
> > > It generalizes boot for 4- and 5-level paging on 64-bit systems with
> > > compile-time switch between them.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  arch/x86/boot/compressed/head_64.S          | 23 +++++++++--
> > >  arch/x86/include/asm/pgtable.h              |  2 +-
> > >  arch/x86/include/asm/pgtable_64.h           |  6 ++-
> > >  arch/x86/include/uapi/asm/processor-flags.h |  2 +
> > >  arch/x86/kernel/espfix_64.c                 |  2 +-
> > >  arch/x86/kernel/head64.c                    | 40 +++++++++++++-----
> > >  arch/x86/kernel/head_64.S                   | 63 +++++++++++++++++++++--------
> > 
> > Ok, here I'd like to have a C version instead of further complicating an already 
> > complex assembly version...
> 
> Just head up: I work on this.
> 
> It's great deal of frustration (I can't really read assembly), but I'm
> slowly moving forward.
> 
> Most of logic in startup_64 in arch/x86/kernel/head_64.S is converted
> to C. Dealing with secondary_startup_64 now.

I'm stuck with secondary_startup_64 too. Stack breaks as soon as we switch
to new page tables when onlining secondary CPUs. I don't know how to get
around this.

Would it be sufficient if I only convert startup_64 in
arch/x86/kernel/head_64.S to C?

-- 
 Kirill A. Shutemov
