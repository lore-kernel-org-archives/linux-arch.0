From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH v5 02/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Tue, 8 Oct 2019 15:11:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.1910081509070.1734@www.lameter.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-3-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20191003013325.2614-3-leonardo@linux.ibm.com>
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
To: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christian Brauner <christian.brauner@ubuntu.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org



On Wed, 2 Oct 2019, Leonardo Bras wrote:

> +
> +inline unsigned long __begin_lockless_pgtbl_walk(struct mm_struct *mm,
> +						 bool disable_irq)
> +{
> +	unsigned long irq_mask = 0;
> +
> +	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
> +		atomic_inc(&mm->lockless_pgtbl_walkers);
> +

You are creating contention on a single exclusive cacheline. Doesnt this
defeat the whole purpose of the lockless page table walk? Use mmap_sem or
so should cause the same performance regression?
