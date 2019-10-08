From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH v5 02/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Tue, 8 Oct 2019 17:43:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.1910081741460.2923@www.lameter.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-3-leonardo@linux.ibm.com>
 <alpine.DEB.2.21.1910081509070.1734@www.lameter.com>
 <6e8877bff034603e75b35599797a39d9bc4840f1.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <6e8877bff034603e75b35599797a39d9bc4840f1.camel@linux.ibm.com>
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
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christian Brauner <christian.brauner@ubuntu.com>, Ira Weiny <ira.weiny@intel.com>, Ingo Molnar <mingo@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Allison Randal <allison@lohutok.net>, Jesper Dangaard Brouer <brouer@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrea
List-Id: linux-arch.vger.kernel.org

On Tue, 8 Oct 2019, Leonardo Bras wrote:

> > You are creating contention on a single exclusive cacheline. Doesnt this
> > defeat the whole purpose of the lockless page table walk? Use mmap_sem or
> > so should cause the same performance regression?
>
> Sorry, I did not understand that question.
> I mean, this is just a refcount and never causes a lock.

Locks also use atomic operations like a refcount increment. Both require
the cacheline to be in exclusive state. So the impact is very similar.
