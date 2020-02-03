From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches
 as usercopy caches
Date: Sun, 2 Feb 2020 23:46:44 -0800
Message-ID: <20200203074644.GD8731@bombadil.infradead.org>
References: <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com>
 <202001281457.FA11CC313A@keescook>
 <alpine.DEB.2.21.2001291640350.1546@www.lameter.com>
 <6844ea47-8e0e-4fb7-d86f-68046995a749@de.ibm.com>
 <20200129170939.GA4277@infradead.org>
 <771c5511-c5ab-3dd1-d938-5dbc40396daa@de.ibm.com>
 <202001300945.7D465B5F5@keescook>
 <CAG48ez1a4waGk9kB0WLaSbs4muSoK0AYAVk8=XYaKj4_+6e6Hg@mail.gmail.com>
 <202002010952.ACDA7A81@keescook>
 <CAG48ez2ms+TDEXQdDONuQ1GG0K20E69nV1r_yjKxxYjYKv1VCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG48ez2ms+TDEXQdDONuQ1GG0K20E69nV1r_yjKxxYjYKv1VCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Christopher Lameter <cl@linux.com>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, kernel list <linux-kernel@vger.kernel.org>, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 01, 2020 at 08:27:49PM +0100, Jann Horn wrote:
> FWIW, as far as I understand, usercopy doesn't actually have any
> effect on drivers that use the modern, proper APIs, since those don't
> use the slab allocator at all - as I pointed out in my last mail, the
> dma-kmalloc* slabs are used very rarely. (Which is good, because
> putting objects from less-than-page-size slabs into iommu entries is a
> terrible idea from a security and reliability perspective because it
> gives the hardware access to completely unrelated memory.) Instead,
> they get pages from the page allocator, and these pages may e.g. be
> allocated from the DMA, DMA32 or NORMAL zones depending on the
> restrictions imposed by hardware. So I think the usercopy restriction
> only affects a few oddball drivers (like this s390 stuff), which is
> why you're not seeing more bug reports caused by this.

Getting pages from the page allocator is true for dma_alloc_coherent()
and friends.  But it's not true for streaming DMA mappings (dma_map_*)
for which the memory usually comes from kmalloc().  If this is something
we want to fix (and I have an awful feeling we're going to regret it
if we say "no, we trust the hardware"), we're going to have to come up
with a new memory allocation API for these cases.  Or bounce bugger the
memory for devices we don't trust.

The problem with the dma_map_* API is that memory might end up being
allocated once and then used multiple times by different drivers.  eg if
I allocate an NFS packet, it might get sent first to eth0, then (when the
route fails) sent to eth1.  Similarly in storage, a RAID-5 driver might
map the same memory several times to send to different disk controllers.
