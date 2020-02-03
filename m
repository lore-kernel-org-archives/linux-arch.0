From: Christopher Lameter <cl@linux.com>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches
 as usercopy caches
Date: Mon, 3 Feb 2020 17:20:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.2002031716440.1668@www.lameter.com>
References: <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz> <202001271519.AA6ADEACF0@keescook> <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com> <202001281457.FA11CC313A@keescook> <alpine.DEB.2.21.2001291640350.1546@www.lameter.com>
 <6844ea47-8e0e-4fb7-d86f-68046995a749@de.ibm.com> <20200129170939.GA4277@infradead.org> <771c5511-c5ab-3dd1-d938-5dbc40396daa@de.ibm.com> <202001300945.7D465B5F5@keescook> <CAG48ez1a4waGk9kB0WLaSbs4muSoK0AYAVk8=XYaKj4_+6e6Hg@mail.gmail.com>
 <202002010952.ACDA7A81@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <202002010952.ACDA7A81@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, kernel list <linux-kernel@vger.kernel.org>, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-arch.vger.kernel.org

On Sat, 1 Feb 2020, Kees Cook wrote:
>
> I can't find where the address limit for dma-kmalloc is implemented.

include/linux/mmzones.h

enum zone_type {
        /*
         * ZONE_DMA and ZONE_DMA32 are used when there are peripherals not able
         * to DMA to all of the addressable memory (ZONE_NORMAL).
         * On architectures where this area covers the whole 32 bit address
         * space ZONE_DMA32 is used. ZONE_DMA is left for the ones with smaller
         * DMA addressing constraints. This distinction is important as a 32bit
         * DMA mask is assumed when ZONE_DMA32 is defined. Some 64-bit
         * platforms may need both zones as they support peripherals with
         * different DMA addressing limitations.
         *
         * Some examples:
         *
         *  - i386 and x86_64 have a fixed 16M ZONE_DMA and ZONE_DMA32 for the
         *    rest of the lower 4G.
         *
         *  - arm only uses ZONE_DMA, the size, up to 4G, may vary depending on
         *    the specific device.
         *
         *  - arm64 has a fixed 1G ZONE_DMA and ZONE_DMA32 for the rest of the
         *    lower 4G.
         *
         *  - powerpc only uses ZONE_DMA, the size, up to 2G, may vary
         *    depending on the specific device.
         *
         *  - s390 uses ZONE_DMA fixed to the lower 2G.
         *
         *  - ia64 and riscv only use ZONE_DMA32.
         *
         *  - parisc uses neither.
         */
#ifdef CONFIG_ZONE_DMA
        ZONE_DMA,
#endif
#ifdef CONFIG_ZONE_DMA32
        ZONE_DMA32,
#endif
        /*
         * Normal addressable memory is in ZONE_NORMAL. DMA operations can
be
         * performed on pages in ZONE_NORMAL if the DMA devices support
         * transfers to all addressable memory.
         */
        ZONE_NORMAL,
#ifdef CONFIG_HIGHMEM
        /*
         * A memory area that is only addressable by the kernel through
         * mapping portions into its own address space. This is for example
         * used by i386 to allow the kernel to address the memory beyond
         * 900MB. The kernel will set up special mappings (page
         * table entries on i386) for each page that the kernel needs to
         * access.
         */
        ZONE_HIGHMEM,
#endif
        ZONE_MOVABLE,
#ifdef CONFIG_ZONE_DEVICE
        ZONE_DEVICE,
#endif
        __MAX_NR_ZONES

};
