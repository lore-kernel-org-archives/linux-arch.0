From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Date: Tue, 8 Oct 2019 17:47:06 +0300
Message-ID: <20191008144706.yu6jrthweyn4kgdm@box>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-2-leonardo@linux.ibm.com>
 <20191003071145.GM4536@hirez.programming.kicks-ass.net>
 <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
 <651856af-30de-15ad-2312-158f3ad5292e@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <651856af-30de-15ad-2312-158f3ad5292e@linux.ibm.com>
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
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Oct 05, 2019 at 02:05:29PM +0530, Aneesh Kumar K.V wrote:
> MADV_DONTNEED has caused us multiple issues due to the fact that it can run
> in parallel to page fault. I am not sure whether we have a known/noticeable
> performance gain in allowing that with mmap_sem held in read mode.

Yes we do. MADV_DONTNEED used a lot by userspace memory allocators and it
will be very noticible performance regression if we would switch it to
down_write(mmap_sem).

-- 
 Kirill A. Shutemov
