From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Date: Thu, 6 Aug 2020 14:11:02 +0300
Message-ID: <20200806111102.GK163101@linux.ibm.com>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-4-rppt@kernel.org>
 <1f52d43e-29e4-b175-73d5-0aa3c3e79f23@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1f52d43e-29e4-b175-73d5-0aa3c3e79f23@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>, Christopher Lameter <cl@linux.com>, Idan Yaniv <idan.yaniv@ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>, linux-nvdimm@lists.01.org, Will Deacon <will@kernel.org>, x86@kernel.org, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>, James Bottomley <jejb@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A. Shutemov" <kirill@shutemov.name>Da
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 05, 2020 at 06:05:18AM -0700, Randy Dunlap wrote:
> On 8/4/20 2:50 AM, Mike Rapoport wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index f2104cc0d35c..8378175e72a4 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -872,4 +872,8 @@ config ARCH_HAS_HUGEPD
> >  config MAPPING_DIRTY_HELPERS
> >          bool
> >  
> > +config SECRETMEM
> > +        def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> 
> use tab above, not spaces.

Will fix.

> > +	select GENERIC_ALLOCATOR
> > +
> >  endmenu
> 
> 
> -- 
> ~Randy
> 

-- 
Sincerely yours,
Mike.
