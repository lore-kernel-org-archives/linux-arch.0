From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem
 implementation
Date: Wed, 13 Feb 2019 19:44:48 +0100
Message-ID: <20190213184448.GB20399@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-8-hch@lst.de> <20190213184139.GC15270@rapoport-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190213184139.GC15270@rapoport-lnx>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 13, 2019 at 08:41:40PM +0200, Mike Rapoport wrote:
> csky seems to open-code free_reserved_page with the only
> difference that it's also increments totalram_pages for the freed pages,
> which doesn't seem correct anyway...
> 
> That said, I suppose arch/csky can be also added to the party.

Yes, I noticed that.  But I'd rather move it over manually in
another patch post rc1 or for the next merge window.

> > +void __weak free_initrd_mem(unsigned long start, unsigned long end)
> > +{
> > +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> 
> Some architectures have pr_info("Freeing initrd memory..."), I'd add it for
> the generic version as well.

Well, if we think such a printk is useful it should probably be
moved to the caller in init/initramfs.c instead.  I can include a
patch for that in the next iteration of the series.

> Another thing that I was thinking of is that x86 has all those memory
> protection calls in its free_initrd_mem, maybe it'd make sense to have them
> in the generic version as well?

Maybe.  But I'd rather keep it out of the initial series as it looks
a little more complicated.  Having a single implementation
of free_initrd_mem would be great, though.
