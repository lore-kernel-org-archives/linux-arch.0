From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remove the ->mapping_error method from dma_map_ops V3
Date: Fri, 30 Nov 2018 11:43:18 -0800
Message-ID: <CAHk-=wia7wykuDu-mzbhF+rL1M9FnJfnoidsvkz5TPMPHUep7g@mail.gmail.com>
References: <20181130132231.16512-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, jdmason@kudzu.us, joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, robin.murphy@arm.com, the arch/x86 maintainers <x86@kernel.org>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 30, 2018 at 5:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Error reporting for the dma_map_single and dma_map_page operations is
> currently a mess. [..]

I don't see anything objectionable there, but it's not like I checked
any of the context of the patches. For all I know there are odd corner
cases where some zero vs DMA_MAPPING_ERROR confusion lurks, but I
guess we'll find out..

So you can add my acked-by, fwiw.

                Linus
