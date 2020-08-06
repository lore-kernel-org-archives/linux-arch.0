From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/6] mm: add definition of PMD_PAGE_ORDER
Date: Thu, 6 Aug 2020 14:10:36 +0300
Message-ID: <20200806111036.GJ163101@linux.ibm.com>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-2-rppt@kernel.org>
 <20200806101112.bjw4mxu2odpsg2hh@box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200806101112.bjw4mxu2odpsg2hh@box>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>, Christopher Lameter <cl@linux.com>, Idan Yaniv <idan.yaniv@ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>, linux-nvdimm@lists.01.org, Will Deacon <will@kernel.org>, x86@kernel.org, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>, James Bottomley <jejb@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Dan Williams <dan.j.williams@intel.com>linux-a
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 06, 2020 at 01:11:12PM +0300, Kirill A. Shutemov wrote:
> On Tue, Aug 04, 2020 at 12:50:30PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The definition of PMD_PAGE_ORDER denoting the number of base pages in the
> > second-level leaf page is already used by DAX and maybe handy in other
> > cases as well.
> > 
> > Several architectures already have definition of PMD_ORDER as the size of
> > second level page table, so to avoid conflict with these definitions use
> > PMD_PAGE_ORDER name and update DAX respectively.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  fs/dax.c                | 10 +++++-----
> >  include/linux/pgtable.h |  3 +++
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 11b16729b86f..b91d8c8dda45 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -50,7 +50,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
> >  #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
> >  
> >  /* The order of a PMD entry */
> > -#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> > +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> 
> Hm. Wouldn't it conflict with definition in pgtable.h? Or should we
> include it instead?

Actually I meant to remove it here and keep only the definition in
pgtable.h.
Will fix.

> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 56c1e8eb7bb0..79f8443609e7 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -28,6 +28,9 @@
> >  #define USER_PGTABLES_CEILING	0UL
> >  #endif
> >  
> > +/* Number of base pages in a second level leaf page */
> > +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> > +
> >  /*
> >   * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
> >   *
> 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
