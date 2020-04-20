From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 24/29] mm: remove __vmalloc_node_flags_caller
Date: Mon, 20 Apr 2020 11:27:56 +0200
Message-ID: <CAMuHMdXktO=2n1tbE5RWRfE1CMd9bP-aHJQifO3J9HYxoQEuXQ@mail.gmail.com>
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-25-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200414131348.444715-25-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-hyperv-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "K. Y. Srinivasan" <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-s390 <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wei Liu <wei.liu-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Nitin Gupta <ngupta-KNmc09w0p+Ednm+yROfE0A@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, bpf <bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Minchan Kim <minchan@kernel.o>
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

On Tue, Apr 14, 2020 at 3:21 PM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> Just use __vmalloc_node instead which gets and extra argument.  To be
> able to to use __vmalloc_node in all caller make it available outside
> of vmalloc and implement it in nommu.c.
>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Acked-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

One more nommu failure below...

> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -150,8 +150,8 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc);
>
> -void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
> -               void *caller)
> +void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
> +               int node, const void *caller)
>  {
>         return __vmalloc(size, flags);

On Mon, Apr 20, 2020 at 10:39 AM <noreply-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org> wrote:
> FAILED linux-next/m5272c3_defconfig/m68k-gcc8 Mon Apr 20, 18:38
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14213623/
>
> mm/nommu.c:164:25: error: 'flags' undeclared (first use in this function); did you mean 'class'?

"return __vmalloc(size, gfp_mask);"

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
