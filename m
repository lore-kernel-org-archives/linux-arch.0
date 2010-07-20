From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/3] Cache maintenance on VIPT caches
Date: Tue, 20 Jul 2010 17:22:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007201718570.25803@xanadu.home>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
	<20100716131908.GA15032@bnru02.bnr.st.com>
	<1279291157.17878.49.camel@e102109-lin.cambridge.arm.com>
	<20100720185611I.fujita.tomonori@lab.ntt.co.jp>
	<1279633178.10002.28.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1279633178.10002.28.camel@e102109-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-arch@vger.kernel.org, rabin.vincent@stericsson.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, 20 Jul 2010, Catalin Marinas wrote:

> On Tue, 2010-07-20 at 18:56 +0900, FUJITA Tomonori wrote:
> > On Fri, 16 Jul 2010 15:39:17 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > I'm not sure why sg_miter doesn't call flush_dcache_page() but
> > > flush_kernel_dcache_page() (I cc'ed Fujita as he seems to have added
> > > this code).
> > 
> > It is intended to handle D aliasing due to kmap. As cachetlb.txt says
> > that it is assumed here that the user has no incoherent cached copies
> > (it was already addressed elsewhere). So flush_dcache_page() does too
> > much there.
> 
> A related question here - does flush_kernel_dcache_page() need to do
> anything for non-highmem pages? For highmem pages, on ARM, we already
> handle the cache flushing in kunmap().

Well, with your proposed patch we wouldn't anymore.  And semantically we 
shouldn't have to.  Even the fact that kunmap_atomic() does flush the 
cache on VIVT system is an implementation issue not a semantic 
definition (incidentally on VIPT it is not flushed).


Nicolas
