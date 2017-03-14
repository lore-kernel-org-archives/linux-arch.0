Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:37530 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbdCNS5A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Mar 2017 14:57:00 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv2,6/7] mm: convert generic code to 5-level paging
Date: Tue, 14 Mar 2017 19:55:07 +0100
Message-ID: <15847703.KEZMYLnFVy@diego>
In-Reply-To: <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
References: <20170309142408.2868-7-kirill.shutemov@linux.intel.com> <2565467.lozgIVsiVn@diego> <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20170314185507.AAy5on3nsySgd2bClXhR9sv1XUUZWE9qn7X6vP3VQO4@z>

Am Dienstag, 14. März 2017, 20:06:25 CET schrieb Kirill A. Shutemov:
> On Tue, Mar 14, 2017 at 05:14:22PM +0100, Heiko Stübner wrote:
> > [added arm64 maintainers and arm list to recipients]
> > 
> > Hi,
> > 
> > Am Donnerstag, 9. März 2017, 17:24:07 CET schrieb Kirill A. Shutemov:
> > > Convert all non-architecture-specific code to 5-level paging.
> > > 
> > > It's mostly mechanical adding handling one more page table level in
> > > places where we deal with pud_t.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > This breaks (at least) arm64 Rockchip platforms it seems.
> > 
> > 4.11-rc1 worked just fine, while 4.11-rc2 kills the systems and I've
> > bisected it down to this one commit.
> 
> Have you tried current Linus' tree? There is important fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> d=ce70df089143c49385b4f32f39d41fb50fbf6a7c

thanks for the pointer ... my arm64 board seem to boot now again.

While I did look for responses to the original series [0] + [1], where there 
weren't any, I didn't think to just look into Linus' tree if there was some 
fixup already. 

So sorry for the noise and all seems well now
Heiko


[0] https://lkml.org/lkml/2017/3/9/442
[1] https://patchwork.kernel.org/patch/9613445/
