From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v5 00/11] Introduces new count-based method for tracking
 lockless pagetable walks
Date: Thu, 3 Oct 2019 13:49:57 -0700
Message-ID: <99754d82-33c5-a54f-8607-b6bf151069d4@nvidia.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003072952.GN4536@hirez.programming.kicks-ass.net>
 <c46d6c7301314a2d998cffc47d69b404f2c26ad3.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <c46d6c7301314a2d998cffc47d69b404f2c26ad3.camel@linux.ibm.com>
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
To: Leonardo Bras <leonardo@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, "Dmitry
 V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Ingo Molnar <mingo@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Allison Randal <allison@lohutok.net>, Jesper Dangaard Brouer <brouer@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>Ar
List-Id: linux-arch.vger.kernel.org

On 10/3/19 1:36 PM, Leonardo Bras wrote:
> On Thu, 2019-10-03 at 09:29 +0200, Peter Zijlstra wrote:
>> On Wed, Oct 02, 2019 at 10:33:14PM -0300, Leonardo Bras wrote:
...
>> This is something entirely specific to Power, you shouldn't be touching
>> generic code at all.
> 
> Up to v4, I was declaring dummy functions so it would not mess up with
> other archs: http://patchwork.ozlabs.org/patch/1168779/
> 
> But I was recommended to create a generic function that could guide the
> way to archs: http://patchwork.ozlabs.org/patch/1168775/

Yes. And to clarify, I was assuming that the changes to mm/gup.c were 
required in order to accomplish your goals. Given that assumption, I 
wanted the generic code to be "proper", and that's what that feedback
is about.

If you can somehow do it entirely as an arch-specific thing, then probably
that's even better. Although the other questions about file-backed THP
make it sound like some rethinking across the board is required now.


thanks,
-- 
John Hubbard
NVIDIA
