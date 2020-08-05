From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 13/17] x86/setup: simplify initrd relocation and
 reservation
Date: Wed, 5 Aug 2020 08:59:09 +0300
Message-ID: <20200805055909.GD8243@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-14-rppt@kernel.org>
 <20200805042024.GT10792@MiWiFi-R3L-srv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200805042024.GT10792@MiWiFi-R3L-srv>
Sender: sparclinux-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Emil Renner Berthing <kernel@esmil.dk>, Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Russell
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 05, 2020 at 12:20:24PM +0800, Baoquan He wrote:
> On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Currently, initrd image is reserved very early during setup and then it
> > might be relocated and re-reserved after the initial physical memory
> > mapping is created. The "late" reservation of memblock verifies that mapped
> > memory size exceeds the size of initrd, the checks whether the relocation
>                                           ~ then?

Right, thanks!

> > required and, if yes, relocates inirtd to a new memory allocated from
> > memblock and frees the old location.
