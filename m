From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 03/20] mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option
Date: Tue, 26 May 2020 18:11:59 +0100
Message-ID: <20200526171159.GJ17051@gaia>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-4-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200429121126.17989-4-rppt@kernel.org>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.co>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 29, 2020 at 03:11:09PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The CONFIG_HAVE_MEMBLOCK_NODE_MAP is used to differentiate initialization
> of nodes and zones structures between the systems that have region to node
> mapping in memblock and those that don't.
> 
> Currently all the NUMA architectures enable this option and for the
> non-NUMA systems we can presume that all the memory belongs to node 0 and
> therefore the compile time configuration option is not required.
> 
> The remaining few architectures that use DISCONTIGMEM without NUMA are
> easily updated to use memblock_add_node() instead of memblock_add() and
> thus have proper correspondence of memblock regions to NUMA nodes.
> 
> Still, free_area_init_node() must have a backward compatible version
> because its semantics with and without CONFIG_HAVE_MEMBLOCK_NODE_MAP is
> different. Once all the architectures will use the new semantics, the
> entire compatibility layer can be dropped.
> 
> To avoid addition of extra run time memory to store node id for
> architectures that keep memblock but have only a single node, the node id
> field of the memblock_region is guarded by CONFIG_NEED_MULTIPLE_NODES and
> the corresponding accessors presume that in those cases it is always 0.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .../vm/numa-memblock/arch-support.txt         |  34 ------
>  arch/alpha/mm/numa.c                          |   4 +-
>  arch/arm64/Kconfig                            |   1 -

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
