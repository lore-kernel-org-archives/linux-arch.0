From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 02/21] mm: make early_pfn_to_nid() and related defintions
 close to each other
Date: Tue, 21 Apr 2020 17:33:43 +0800
Message-ID: <20200421093343.GR4247@MiWiFi-R3L-srv>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-3-rppt@kernel.org>
 <20200421022435.GP4247@MiWiFi-R3L-srv>
 <20200421084935.GB14260@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200421084935.GB14260@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.>
List-Id: linux-arch.vger.kernel.org

On 04/21/20 at 11:49am, Mike Rapoport wrote:
> On Tue, Apr 21, 2020 at 10:24:35AM +0800, Baoquan He wrote:
> > On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > The early_pfn_to_nid() and it's helper __early_pfn_to_nid() are spread
> > > around include/linux/mm.h, include/linux/mmzone.h and mm/page_alloc.c.
> > > 
> > > Drop unused stub for __early_pfn_to_nid() and move its actual generic
> > > implementation close to its users.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  include/linux/mm.h     |  4 ++--
> > >  include/linux/mmzone.h |  9 --------
> > >  mm/page_alloc.c        | 51 +++++++++++++++++++++---------------------
> > >  3 files changed, 27 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 5a323422d783..a404026d14d4 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -2388,9 +2388,9 @@ extern void sparse_memory_present_with_active_regions(int nid);
> > >  
> > >  #if !defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) && \
> > >      !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID)
> > > -static inline int __early_pfn_to_nid(unsigned long pfn,
> > > -					struct mminit_pfnnid_cache *state)
> > > +static inline int early_pfn_to_nid(unsigned long pfn)
> > >  {
> > > +	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
> > >  	return 0;
> > >  }
> > 
> > It's better to make a separate patch to drop __early_pfn_to_nid() here.
> 
> Not sure it's really worth it.
> This patch anyway only moves the code around without any actual changes.

OK, it's fine to me.
