From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Mon, 30 Sep 2019 10:57:13 -0700
Message-ID: <48bf32ca-5d3e-5d69-4cd1-6720364a0d81@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-2-leonardo@linux.ibm.com>
 <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
 <2533a13f226a6e1fab387669b6cced2aa8d2e129.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <2533a13f226a6e1fab387669b6cced2aa8d2e129.camel@linux.ibm.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Keith Busch <keith.busch@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-arch.vger.kernel.org

On 9/30/19 8:14 AM, Leonardo Bras wrote:
> On Sun, 2019-09-29 at 15:40 -0700, John Hubbard wrote:
>> Hi, Leonardo,
> 
> Hello John, thanks for the feedback.
> 
>> Can we please do it as shown below, instead (compile-tested only)?
>>
>> This addresses all of the comments that I was going to make about structure
>> of this patch, which are:
>>
>> * The lockless synch is tricky, so it should be encapsulated in function
>>     calls if possible.
> 
> As I told before, there are cases where this function is called from
> 'real mode' in powerpc, which doesn't disable irqs and may have a
> tricky behavior if we do. So, encapsulate the irq disable in this
> function can be a bad choice.

You still haven't explained how this works in that case. So far, the
synchronization we've discussed has depended upon interrupt disabling
as part of the solution, in order to hold off page splitting and page
table freeing.

Simply skipping that means that an additional mechanism is required...which
btw might involve a new, ppc-specific routine, so maybe this is going to end
up pretty close to what I pasted in after all...

> 
> Of course, if we really need that, we can add a bool parameter to the
> function to choose about disabling/enabling irqs.
>>
>> * This is really a core mm function, so don't hide it away in arch layers.
>>     (If you're changing mm/ files, that's a big hint.)
> 
> My idea here is to let the arch decide on how this 'register' is going
> to work, as archs may have different needs (in powerpc for example, we
> can't always disable irqs, since we may be in realmode).
> 
> Maybe we can create a generic function instead of a dummy, and let it
> be replaced in case the arch needs to do so.

Yes, that might be what we need, if it turns out that ppc can't use this
approach (although let's see about that).


thanks,
-- 
John Hubbard
NVIDIA
