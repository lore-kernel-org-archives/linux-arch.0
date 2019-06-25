From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2] bpf: fix uapi bpf_prog_info fields alignment
Date: Tue, 25 Jun 2019 08:19:35 -0700
Message-ID: <CAADnVQJNLk7tAHRHr7V7ugvCX9iCjaH4_vS9YuNWcMpwnA6ZyA@mail.gmail.com>
References: <a5fb2545a0cf151bc443efa10c16c5a4de6f2670.1561460681.git.baruch@tkos.co.il>
 <CAADnVQJ3MPVCL-0x2gDYbUQsrmu8WipnisqXoU8ja4vZ-5nTmA@mail.gmail.com> <20190625150835.GA24947@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190625150835.GA24947@altlinux.org>
Sender: netdev-owner@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Baruch Siach <baruch@tkos.co.il>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 25, 2019 at 8:08 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On Tue, Jun 25, 2019 at 07:16:55AM -0700, Alexei Starovoitov wrote:
> > On Tue, Jun 25, 2019 at 4:07 AM Baruch Siach <baruch@tkos.co.il> wrote:
> > >
> > > Merge commit 1c8c5a9d38f60 ("Merge
> > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next") undid the
> > > fix from commit 36f9814a494 ("bpf: fix uapi hole for 32 bit compat
> > > applications") by taking the gpl_compatible 1-bit field definition from
> > > commit b85fab0e67b162 ("bpf: Add gpl_compatible flag to struct
> > > bpf_prog_info") as is. That breaks architectures with 16-bit alignment
> > > like m68k. Embed gpl_compatible into an anonymous union with 32-bit pad
> > > member to restore alignment of following fields.
> > >
> > > Thanks to Dmitry V. Levin his analysis of this bug history.
> > >
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > ---
> > > v2:
> > > Use anonymous union with pad to make it less likely to break again in
> > > the future.
> > > ---
> > >  include/uapi/linux/bpf.h       | 5 ++++-
> > >  tools/include/uapi/linux/bpf.h | 5 ++++-
> > >  2 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index a8b823c30b43..766eae02d7ae 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -3142,7 +3142,10 @@ struct bpf_prog_info {
> > >         __aligned_u64 map_ids;
> > >         char name[BPF_OBJ_NAME_LEN];
> > >         __u32 ifindex;
> > > -       __u32 gpl_compatible:1;
> > > +       union {
> > > +               __u32 gpl_compatible:1;
> > > +               __u32 pad;
> > > +       };
> >
> > Nack for the reasons explained in the previous thread
> > on the same subject.
> > Why cannot you go with earlier suggestion of _u32 :31; ?
>
> By the way, why not use aligned types as suggested by Geert?
> They are already used for other members of struct bpf_prog_info anyway.
>
> FWIW, we use aligned types for bpf in strace and that approach
> proved to be more robust than manual padding.

because __aligned_u64 is used for pointers.
