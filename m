From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Date: Fri, 4 Oct 2019 13:24:21 +0200
Message-ID: <20191004112421.GB19463@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-2-leonardo@linux.ibm.com>
 <20191003071145.GM4536@hirez.programming.kicks-ass.net>
 <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
 <c127ee98-094b-d5c0-0a42-6d01c16a72d9@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <c127ee98-094b-d5c0-0a42-6d01c16a72d9@nvidia.com>
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
To: John Hubbard <jhubbard@nvidia.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@n>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 03, 2019 at 01:40:38PM -0700, John Hubbard wrote:
> On 10/3/19 4:51 AM, Peter Zijlstra wrote:
> > On Thu, Oct 03, 2019 at 09:11:45AM +0200, Peter Zijlstra wrote:
> >> On Wed, Oct 02, 2019 at 10:33:15PM -0300, Leonardo Bras wrote:
> ...
> > 
> > I'm still really confused about this barrier. It just doesn't make
> > sense.
> > 
> > If an interrupt happens before the local_irq_disable()/save(), then it
> > will discard any and all speculation that would be in progress to handle
> > the exception.
> > 
> 
> Hi Peter,
> 
> So, would that imply that it's correct to apply approximately the following
> patch:
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1adbb8a371c7..cf41eff37e24 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2099,9 +2099,9 @@ INTERRUPT DISABLING FUNCTIONS
>  -----------------------------
>  
>  Functions that disable interrupts (ACQUIRE equivalent) and enable interrupts
> -(RELEASE equivalent) will act as compiler barriers only.  So if memory or I/O
> -barriers are required in such a situation, they must be provided from some
> -other means.
> +(RELEASE equivalent) will act as full memory barriers. This is because, for
> +all supported CPU architectures, interrupt arrival causes all speculative
> +memory accesses to be discarded.
>  
> ?

No, you're misunderstanding. They imply nothing of the sort.
