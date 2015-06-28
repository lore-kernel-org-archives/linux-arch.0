From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: atomic64 on 32-bit vs 64-bit (was: Re: Add virtio gpu driver.)
Date: Sun, 28 Jun 2015 11:24:19 +0200
Message-ID: <CAMuHMdVywrFUN0ho-D6bmf9u4ePxBCvtc5zVK=6DEjkML6ohdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34589 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbbF1JYU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Jun 2015 05:24:20 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Airlie <airlied@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Jun 26, 2015 at 10:52 PM, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Gitweb:     http://git.kernel.org/linus/;a=3Dcommit;h=3Ddc5698e80cf72=
4770283e10414054662bdf6ccfa
> Commit:     dc5698e80cf724770283e10414054662bdf6ccfa
> Parent:     16e3247da7f71f8c31f4330f739f6192a00c8b51
> Refname:    refs/heads/master
> Author:     Dave Airlie <airlied@gmail.com>
> AuthorDate: Mon Sep 9 10:02:56 2013 +1000
> Committer:  Gerd Hoffmann <kraxel@redhat.com>
> CommitDate: Wed Jun 3 14:17:38 2015 +0200
>
>     Add virtio gpu driver.
>
>     This patch adds a kms driver for the virtio gpu.  The xorg modese=
tting
>     driver can handle the device just fine, the framebuffer for fbcon=
 is
>     there too.
>
>     Qemu patches for the host side are under review currently.
>
>     The pci version of the device comes in two variants: with and wit=
hout
>     vga compatibility.  The former has a extra memory bar for the vga
>     framebuffer, the later is a pure virtio device.  The only concern=
 for
>     this driver is that in the virtio-vga case we have to kick out th=
e
>     firmware framebuffer.
>
>     Initial revision has only 2d support, 3d (virgl) support requires
>     some more work on the qemu side and will be added later.
>
>     Signed-off-by: Dave Airlie <airlied@redhat.com>
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>     Acked-by: Michael S. Tsirkin <mst@redhat.com>

> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c

> +static int
> +virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
> +{
> +       struct drm_info_node *node =3D (struct drm_info_node *) m->pr=
ivate;
> +       struct virtio_gpu_device *vgdev =3D node->minor->dev->dev_pri=
vate;
> +
> +       seq_printf(m, "fence %ld %lld\n",
> +                  atomic64_read(&vgdev->fence_drv.last_seq),
> +                  vgdev->fence_drv.sync_seq);

On m68k (32-bit):

drivers/gpu/drm/virtio/virtgpu_debugfs.c: In function
=E2=80=98virtio_gpu_debugfs_irq_info=E2=80=99:
drivers/gpu/drm/virtio/virtgpu_debugfs.c:39: warning: format =E2=80=98%=
ld=E2=80=99
expects type =E2=80=98long int=E2=80=99, but argument 3 has type =E2=80=
=98long long int=E2=80=99

> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c

> +static bool virtio_signaled(struct fence *f)
> +{
> +       struct virtio_gpu_fence *fence =3D to_virtio_fence(f);
> +
> +       if (atomic64_read(&fence->drv->last_seq) >=3D fence->seq)
> +               return true;

drivers/gpu/drm/virtio/virtgpu_fence.c: In function =E2=80=98virtio_tim=
eline_value_str=E2=80=99:
drivers/gpu/drm/virtio/virtgpu_fence.c:64: warning: format =E2=80=98%lu=
=E2=80=99
expects type =E2=80=98long unsigned int=E2=80=99, but argument 4 has ty=
pe =E2=80=98long long
int=E2=80=99

interestingly, this was reported almost one year ago:
https://lists.01.org/pipermail/kbuild-all/2014-September/006409.html

Instead of sprinkling casts, is there any good reason why atomic64_read=
()
and atomic64_t aren't "long long" everywhere, cfr. u64?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
