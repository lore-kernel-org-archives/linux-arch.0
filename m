From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Date: Fri, 4 Oct 2019 13:28:44 +0200
Message-ID: <20191004112844.GC19463@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-2-leonardo@linux.ibm.com>
 <20191003071145.GM4536@hirez.programming.kicks-ass.net>
 <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
 <c46ba8cec981ad28383bb7b23161fb83ccda4a60.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c46ba8cec981ad28383bb7b23161fb83ccda4a60.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 03, 2019 at 06:24:07PM -0300, Leonardo Bras wrote:
> Hello Peter, thanks for the feedback!
>=20
> On Thu, 2019-10-03 at 13:51 +0200, Peter Zijlstra wrote:
> > On Thu, Oct 03, 2019 at 09:11:45AM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 02, 2019 at 10:33:15PM -0300, Leonardo Bras wrote:
> > > > diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pg=
table.h
> > > > index 818691846c90..3043ea9812d5 100644
> > > > --- a/include/asm-generic/pgtable.h
> > > > +++ b/include/asm-generic/pgtable.h
> > > > @@ -1171,6 +1171,64 @@ static inline bool arch_has_pfn_modify_check=
(void)
> > > >  #endif
> > > >  #endif
> > > > =20
> > > > +#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> > > > +static inline unsigned long begin_lockless_pgtbl_walk(struct mm_st=
ruct *mm)
> > > > +{
> > > > +	unsigned long irq_mask;
> > > > +
> > > > +	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
> > > > +		atomic_inc(&mm->lockless_pgtbl_walkers);
> > >=20
> > > This will not work for file backed THP. Also, this is a fairly serious
> > > contention point all on its own.
> >=20
> > Kiryl says we have tmpfs-thp, this would be broken vs that, as would
> > your (PowerPC) use of mm_cpumask() for that IPI.
>=20
> Could you please explain it?
> I mean, why this breaks tmpfs-thp?
> Also, why mm_cpumask() is also broken?

Because shared pages are not bound by a mm; or does it not share the thp
state between mappings?

> > And I still think all that wrong, you really shouldn't need to wait on
> > munmap().
>=20
> That is something I need to better understand. I mean, before coming
> with this patch, I thought exactly this: not serialize when on munmap.=20
>=20
> But on the way I was convinced it would not work on munmap. I need to
> recall why, and if it was false to assume this, re-think the whole
> solution.

And once you (re)figure it out, please write it down. It is a crucial
bit of the puzzle and needs to be part of the Changelogs.
