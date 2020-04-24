From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 17/21] mm: free_area_init: allow defining max_zone_pfn in
 descending order
Date: Fri, 24 Apr 2020 08:33:56 +0800
Message-ID: <20200424003356.GA10119@MiWiFi-R3L-srv>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-18-rppt@kernel.org>
 <20200423025311.GZ4247@MiWiFi-R3L-srv>
 <20200423025720.GA4247@MiWiFi-R3L-srv>
 <20200423055559.GF14260@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200423055559.GF14260@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.>
List-Id: linux-arch.vger.kernel.org

On 04/23/20 at 08:55am, Mike Rapoport wrote:
> On Thu, Apr 23, 2020 at 10:57:20AM +0800, Baoquan He wrote:
> > On 04/23/20 at 10:53am, Baoquan He wrote:
> > > On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > Some architectures (e.g. ARC) have the ZONE_HIGHMEM zone below the
> > > > ZONE_NORMAL. Allowing free_area_init() parse max_zone_pfn array even it is
> > > > sorted in descending order allows using free_area_init() on such
> > > > architectures.
> > > > 
> > > > Add top -> down traversal of max_zone_pfn array in free_area_init() and use
> > > > the latter in ARC node/zone initialization.
> > > 
> > > Or maybe leave ARC as is. The change in this patchset doesn't impact
> > > ARC's handling about zone initialization, leaving it as is can reduce
> > > the complication in implementation of free_area_init(), which is a
> > > common function. So I personally don't see a strong motivation to have
> > > this patch.
> > 
> > OK, seems this patch is prepared to simplify free_area_init_node(), so
> > take back what I said at above.
> > 
> > Then this looks necessary, even though it introduces special case into
> > common function free_area_init().
> 
> The idea is to have a single free_area_init() for all architectures
> without keeping two completely different ways of calculating the zone
> extents.
> Another thing, is that with this we could eventually switch ARC from
> DISCONTIGMEM.

Yeah, I think uniting them into a single free_area_init() is a great
idea. Even though I had been through this patchset, when looked into
each of them, still may forget the detail in later patch :)
