From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: strace for m68k bpf_prog_info mismatch
Date: Fri, 3 May 2019 14:16:04 +0200
Message-ID: <CAMuHMdXooXuk8q1zC+KM==BiWPn9usWR6oM7xQ5VzwT6bjzcqg@mail.gmail.com>
References: <874l6c89nd.fsf@tarshish> <CAMuHMdUT3ug+SCzrnA2eD=QyOLaHUGAe-ZrbWfDUWxTJ4CWEtQ@mail.gmail.com>
 <8736lv92ls.fsf@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8736lv92ls.fsf@tarshish>
Sender: linux-kernel-owner@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: "Dmitry V . Levin" <ldv@altlinux.org>, strace-devel@lists.strace.io, linux-m68k <linux-m68k@lists.linux-m68k.org>, Daniel Borkmann <daniel@iogearbox.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Baruch,

On Fri, May 3, 2019 at 1:52 PM Baruch Siach <baruch@tkos.co.il> wrote:
> On Fri, May 03 2019, Geert Uytterhoeven wrote:
> > On Fri, May 3, 2019 at 6:06 AM Baruch Siach <baruch@tkos.co.il> wrote:
> >> strace 5.0 fails to build for m86k/5208 with the Buildroot generated
> >> toolchain:
> >>
> >> In file included from bpf_attr_check.c:6:0:
> >> static_assert.h:20:25: error: static assertion failed: "bpf_prog_info_struct.nr_jited_ksyms offset mismatch"
> >>  #  define static_assert _Static_assert
> >>                          ^
> >> bpf_attr_check.c:913:2: note: in expansion of macro ‘static_assert’
> >>   static_assert(offsetof(struct bpf_prog_info_struct, nr_jited_ksyms) == offsetof(struct bpf_prog_info, nr_jited_ksyms),
> >>   ^~~~~~~~~~~~~
> >>
> >> The direct cause is a difference in the hole after the gpl_compatible
> >> field. Here is pahole output for the kernel struct (from v4.19):
> >>
> >> struct bpf_prog_info {
> >>         ...
> >>         __u32                      ifindex;              /*    80     4 */
> >>         __u32                      gpl_compatible:1;     /*    84: 0  4 */
> >>
> >>         /* XXX 15 bits hole, try to pack */
> >>         /* Bitfield combined with next fields */
> >>
> >>         __u64                      netns_dev;            /*    86     8 */
> >
> > I guess that should be "__aligned_u64 netns_dev;", to not rely on
> > implicit alignment.
>
> Thanks. I can confirm that this minimal change fixes strace build:
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 929c8e537a14..709d4dddc229 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2869,7 +2869,7 @@ struct bpf_prog_info {
>         char name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
>         __u32 gpl_compatible:1;
> -       __u64 netns_dev;
> +       __aligned_u64 netns_dev;
>         __u64 netns_ino;
>         __u32 nr_jited_ksyms;
>         __u32 nr_jited_func_lens;
>
> Won't that break ABI compatibility for affected architectures?

Yes it will. Or it may have been unusable without the fix. I don't know
for sure.

> >> And this is for the strace struct:
> >>
> >> struct bpf_prog_info_struct {
> >>         ...
> >>         uint32_t                   ifindex;              /*    80     4 */
> >>         uint32_t                   gpl_compatible:1;     /*    84: 0  4 */
> >>
> >>         /* XXX 31 bits hole, try to pack */
> >
> > How come the uint64_t below is 8-byte aligned, not 2-byte aligned?
> > Does strace use a special definition of uint64_t?
>
> I guess this is because of the netns_dev field definition in struct
> bpf_prog_info_struct at bpf_attr.h:
>
> struct bpf_prog_info_struct {
>        ...
>         uint32_t gpl_compatible:1;
>         /*
>          * The kernel UAPI is broken by Linux commit
>          * v4.16-rc1~123^2~227^2~5^2~2 .
>          */
>         uint64_t ATTRIBUTE_ALIGNED(8) netns_dev; /* skip check */

Oh, the bug was even documented, with its cause ;-)
That's commit 675fc275a3a2d905 ("bpf: offload: report device information
for offloaded programs").

Partially fixed by commit 36f9814a494a874d ("bpf: fix uapi hole for 32 bit
compat applications"), which left architectures with 16-bit alignment
broken...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
