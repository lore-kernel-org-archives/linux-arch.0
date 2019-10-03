From: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v5 10/11] mm/Kconfig: Adds config option to track lockless
 pagetable walks
Date: Wed, 2 Oct 2019 22:08:49 -0400
Message-ID: <88228CE0-81B2-4F2F-8C1D-F3376DB25A16@lca.pw>
References: <20191003013325.2614-11-leonardo@linux.ibm.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20191003013325.2614-11-leonardo@linux.ibm.com>
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
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea
List-Id: linux-arch.vger.kernel.org



> On Oct 2, 2019, at 9:36 PM, Leonardo Bras <leonardo@linux.ibm.com> wrote:
>=20
> Adds config option LOCKLESS_PAGE_TABLE_WALK_TRACKING to make possible
> enabling tracking lockless pagetable walks directly from kernel config.

Can=E2=80=99t this name and all those new *lockless* function names be short=
er? There are many functions name with *_locked, so how about dropping lockl=
ess at all, i.e., PAGE_TABLE_WALK_TRACKING blah blah?

>=20
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
> mm/Kconfig | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5dae9a7eb51..00f487a0122f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -736,4 +736,15 @@ config ARCH_HAS_PTE_SPECIAL
> config ARCH_HAS_HUGEPD
>    bool
>=20
> +config LOCKLESS_PAGE_TABLE_WALK_TRACKING
> +    bool "Track (and optimize) lockless page table walks"
> +    default n
> +
> +    help
> +      Maintain a reference count of active lockless page table
> +      walkers. This adds 4 bytes to struct mm size, and two atomic
> +      operations to calls such as get_user_pages_fast(). Some
> +      architectures can optimize lockless page table operations if
> +      this is enabled.
> +
> endmenu
> --=20
> 2.20.1
