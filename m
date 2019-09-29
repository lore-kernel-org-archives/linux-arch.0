From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Sun, 29 Sep 2019 16:17:20 -0700
Message-ID: <f8fca251-e31a-1d50-49e9-e69a893d9059@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-2-leonardo@linux.ibm.com>
 <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
Content-Language: en-US
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
To: Leonardo Bras <leonardo@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Keith Busch <keith.busch@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Allison Randal <allison@lohutok.net>
List-Id: linux-arch.vger.kernel.org

On 9/29/19 3:40 PM, John Hubbard wrote:
> On 9/27/19 4:39 PM, Leonardo Bras wrote:
...
> +config LOCKLESS_PAGE_TABLE_WALK_TRACKING
> +=C2=A0=C2=A0=C2=A0 bool "Tracking (and optimization) of lockless page ta=
ble walkers"
> +=C2=A0=C2=A0=C2=A0 default n
> +
> +=C2=A0=C2=A0=C2=A0 help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Maintain a reference count of active lock=
less page table
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 walkers. This adds 4 bytes to struct mm s=
ize, and two atomic
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 operations to calls such as get_user_page=
s_fast(). Some
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 architectures can optimize page table ope=
rations if this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is enabled.
> +
>  =C2=A0endmenu

Actually, the above should be an internal-only config option (PPC arch can
auto-select it), so just:

+config LOCKLESS_PAGE_TABLE_WALK_TRACKING
+	bool

...because it's entirely up to other code (as opposed to other people)
as to whether this should be selected.

I got carried away. :)

thanks,
--=20
John Hubbard
NVIDIA
