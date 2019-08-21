From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] csky: Fixup arch_get_unmapped_area() implementation
Date: Tue, 20 Aug 2019 19:16:50 -0700
Message-ID: <20190821021650.GA32710@infradead.org>
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566304469-5601-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

> +/*
> + * We need to ensure that shared mappings are correctly aligned to
> + * avoid aliasing issues with VIPT caches.  We need to ensure that
> + * a specific page of an object is always mapped at a multiple of
> + * SHMLBA bytes.
> + *
> + * We unconditionally provide this function for all cases.
> + */

On something unrelated: If csky has virtually indexed caches you also
need to implement the flush_kernel_vmap_range and
invalidate_kernel_vmap_range functions to avoid data corruption when
doing I/O on vmalloc/vmap ranges.
