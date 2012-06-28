From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 14/20] mm, sh: Convert sh to generic tlb
Date: Thu, 28 Jun 2012 22:27:16 +0200
Message-ID: <1340915236.28750.84.camel@twins>
References: <20120627211540.459910855@chello.nl>
	 <20120627212831.578578936@chello.nl> <20120628183251.GA7250@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20120628183251.GA7250@linux-sh.org>
Sender: owner-linux-mm@kvack.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Alex Shi <alex.shi@intel.com>, "Nikunj A.
 Dadhania" <nikunj@linux.vnet.ibm.com>, Konrad Rzeszutek Wilk <konrad@darnok.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tony Luck <tony.luck@intel.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Hans-Christian Egtvedt <hans-christian.egtvedt@atm>
List-Id: linux-arch.vger.kernel.org

On Fri, 2012-06-29 at 03:32 +0900, Paul Mundt wrote:
> On Wed, Jun 27, 2012 at 11:15:54PM +0200, Peter Zijlstra wrote:
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > ---
> >  arch/sh/Kconfig           |    1=20
> >  arch/sh/include/asm/tlb.h |   98 ++-----------------------------------=
---------
> >  2 files changed, 6 insertions(+), 93 deletions(-)
>=20
> This blows up in the same way as last time.
>=20
> I direct you to the same bug report and patch as before:
>=20
> http://marc.info/?l=3Dlinux-kernel&m=3D133722116507075&w=3D2

Sorry about that.. /me goes amend.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
