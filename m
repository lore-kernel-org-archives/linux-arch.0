From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2,6/7] mm: convert generic code to 5-level paging
Date: Tue, 14 Mar 2017 20:06:25 +0300
Message-ID: <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
References: <20170309142408.2868-7-kirill.shutemov@linux.intel.com>
 <2565467.lozgIVsiVn@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <2565467.lozgIVsiVn@diego>
Sender: owner-linux-mm@kvack.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 14, 2017 at 05:14:22PM +0100, Heiko Stübner wrote:
> [added arm64 maintainers and arm list to recipients]
> 
> Hi,
> 
> Am Donnerstag, 9. März 2017, 17:24:07 CET schrieb Kirill A. Shutemov:
> > Convert all non-architecture-specific code to 5-level paging.
> > 
> > It's mostly mechanical adding handling one more page table level in
> > places where we deal with pud_t.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> This breaks (at least) arm64 Rockchip platforms it seems.
> 
> 4.11-rc1 worked just fine, while 4.11-rc2 kills the systems and I've bisected 
> it down to this one commit.

Have you tried current Linus' tree? There is important fix:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce70df089143c49385b4f32f39d41fb50fbf6a7c

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
