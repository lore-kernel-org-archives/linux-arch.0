Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37018 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfJDM7F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Oct 2019 08:59:05 -0400
Date: Fri, 4 Oct 2019 14:57:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 00/11] Introduces new count-based method for tracking
 lockless pagetable walks
Message-ID: <20191004125756.GA32620@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003072952.GN4536@hirez.programming.kicks-ass.net>
 <c46d6c7301314a2d998cffc47d69b404f2c26ad3.camel@linux.ibm.com>
 <20191004114236.GD19463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004114236.GD19463@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm-ppc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Reza Arbab <arbab@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Christian Brauner <christian.brauner@ubuntu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Souptick Joarder <jrdr.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Roman Gushchin <guro@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20191004125756.c4A4MDfZxNBOOPpjkbND_PeS2CRg3tCxVTMXM2wEQR0@z>

On Fri, Oct 04, 2019 at 01:42:36PM +0200, Peter Zijlstra wrote:
> If you can find anything there that isn't right, please explain that in
> detail and we'll need to look hard at fixing _that_.

Also, I can't imagine Nick is happy with 128 CPUs banging on that atomic
counter, esp. since atomics are horrifically slow on Power.
