From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-mapping: Add BUG_ON for uninitialized dma_ops
Date: Tue, 11 Jun 2013 13:02:47 +0200
Message-ID: <51B703D7.8050804@samsung.com>
References: <f35c5051a207b0a117f2fff27365d0ea892d1610.1370263476.git.michal.simek@xilinx.com>
 <CAErSpo6kss-v0w_1ker__vPqNCRNLx+z8nk+0r=D-40D3TuDCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAErSpo6kss-v0w_1ker__vPqNCRNLx+z8nk+0r=D-40D3TuDCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello,

On 6/11/2013 4:34 AM, Bjorn Helgaas wrote:
> [+cc Marek]
>
> On Mon, Jun 3, 2013 at 6:44 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> > Check that dma_ops are initialized correctly.
> >
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > Functions dma_mmap_attrs(), dma_get_sgtable_attrs()
> > already have this checking.
> >
> > ---
> >  include/asm-generic/dma-mapping-common.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
> > index de8bf89..d430cab 100644
> > --- a/include/asm-generic/dma-mapping-common.h
> > +++ b/include/asm-generic/dma-mapping-common.h
> > @@ -16,6 +16,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> >         dma_addr_t addr;
> >
> >         kmemcheck_mark_initialized(ptr, size);
> > +       BUG_ON(!ops);
>
> Does this actually help anything?  I expected that if "ops" is NULL,
> we would just oops anyway when we attempted to call "ops->map_page()"
> because we already trap null pointer dereferences.  At least, when I
> tried leaving a pci_bus.ops pointer NULL, I got a nice panic and
> backtrace even without adding an explicit BUG_ON().
>
> I cc'd Marek, who added the similar BUG_ON()s in dma_mmap_attrs() and
> dma_get_sgtable_attrs() with d2b7428eb0 and 64ccc9c033.

I think that I've copied it from dma_alloc_coherent() in microblaze. You 
are right that lack
of this check will also trigger oops in ops==NULL case, but I think that 
adding explicit check
in all functions, which use it, is a good idea. It serves as a kind of 
documentation and
emphasizes that missing ops is really an issue.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
