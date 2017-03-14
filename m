From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv2,6/7] mm: convert generic code to 5-level paging
Date: Tue, 14 Mar 2017 19:55:07 +0100
Message-ID: <15847703.KEZMYLnFVy@diego>
References: <20170309142408.2868-7-kirill.shutemov@linux.intel.com> <2565467.lozgIVsiVn@diego> <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170314170625.gwlfjlxooij3elsd@node.shutemov.name>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Am Dienstag, 14. M=E4rz 2017, 20:06:25 CET schrieb Kirill A. Shutemov:
> On Tue, Mar 14, 2017 at 05:14:22PM +0100, Heiko St=FCbner wrote:
> > [added arm64 maintainers and arm list to recipients]
> >=20
> > Hi,
> >=20
> > Am Donnerstag, 9. M=E4rz 2017, 17:24:07 CET schrieb Kirill A. Shutemov:
> > > Convert all non-architecture-specific code to 5-level paging.
> > >=20
> > > It's mostly mechanical adding handling one more page table level in
> > > places where we deal with pud_t.
> > >=20
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> >=20
> > This breaks (at least) arm64 Rockchip platforms it seems.
> >=20
> > 4.11-rc1 worked just fine, while 4.11-rc2 kills the systems and I've
> > bisected it down to this one commit.
>=20
> Have you tried current Linus' tree? There is important fix:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?i
> d=3Dce70df089143c49385b4f32f39d41fb50fbf6a7c

thanks for the pointer ... my arm64 board seem to boot now again.

While I did look for responses to the original series [0] + [1], where ther=
e=20
weren't any, I didn't think to just look into Linus' tree if there was some=
=20
fixup already.=20

So sorry for the noise and all seems well now
Heiko


[0] https://lkml.org/lkml/2017/3/9/442
[1] https://patchwork.kernel.org/patch/9613445/

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
