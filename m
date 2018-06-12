From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with
 precise TLB ranges in mmu_gather
Date: Wed, 13 Jun 2018 09:09:50 +1000
Message-ID: <20180613090950.50566245@roar.ozlabs.ibm.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-4-npiggin@gmail.com>
 <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
 <20180613083131.139a3c34@roar.ozlabs.ibm.com>
 <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, linux-mm <linux-mm@kvack.org>, "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 12 Jun 2018 15:42:34 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jun 12, 2018 at 3:31 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Okay sure, and this is the reason for the wide cc list. Intel does
> > need it of course, from 4.10.3.1 of the dev manual:
> >
> >   =E2=80=94 The processor may create a PML4-cache entry even if there a=
re no
> >     translations for any linear address that might use that entry
> >     (e.g., because the P flags are 0 in all entries in the referenced
> >     page-directory-pointer table). =20
>=20
> But does intel need it?
>=20
> Because I don't see it. We already do the __tlb_adjust_range(), and we
> never tear down the highest-level page tables afaik.
>=20
> Am I missing something?


Sorry I mean Intel needs the existing behaviour of range flush expanded
to cover page table pages.... right? The manual has similar wording for
lower levels of page tables too. So it does need to send an invalidate
*somewhere* that a freed page table page covers, even if no valid pte
was torn down.

Thanks,
Nick
