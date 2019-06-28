Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46794 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfF1UTQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jun 2019 16:19:16 -0400
MIME-Version: 1.0
References: <02938ce219d535a8c7c29ce796b3d6ea59c3ed15.1561694925.git.baruch@tkos.co.il>
In-Reply-To: <02938ce219d535a8c7c29ce796b3d6ea59c3ed15.1561694925.git.baruch@tkos.co.il>
From: Song Liu <liu.song.a23@gmail.com>
Date: Fri, 28 Jun 2019 13:19:03 -0700
Message-ID: <CAPhsuW4woTdoK1gMrFG=BZAXGD=ovYgm1YJ5G88DcWBrhSOYww@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: fix uapi bpf_prog_info fields alignment
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "Dmitry V . Levin" <ldv@altlinux.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190628201903.vUB47n9H4N6a5J3T44ArzEkmkGDm-xcZCHIzl3dZBg4@z>

On Thu, Jun 27, 2019 at 9:11 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Merge commit 1c8c5a9d38f60 ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next") undid the
> fix from commit 36f9814a494 ("bpf: fix uapi hole for 32 bit compat
> applications") by taking the gpl_compatible 1-bit field definition from
> commit b85fab0e67b162 ("bpf: Add gpl_compatible flag to struct
> bpf_prog_info") as is. That breaks architectures with 16-bit alignment
> like m68k. Add 31-bit pad after gpl_compatible to restore alignment of
> following fields.
>
> Thanks to Dmitry V. Levin his analysis of this bug history.
>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Song Liu <songliubraving@fb.com>

> ---
> v3:
> Use alignment pad as Alexei Starovoitov suggested
>
> v2:
> Use anonymous union with pad to make it less likely to break again in
> the future.
> ---
>  include/uapi/linux/bpf.h       | 1 +
>  tools/include/uapi/linux/bpf.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a8b823c30b43..29a5bc3d5c66 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3143,6 +3143,7 @@ struct bpf_prog_info {
>         char name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
>         __u32 gpl_compatible:1;
> +       __u32 :31; /* alignment pad */
>         __u64 netns_dev;
>         __u64 netns_ino;
>         __u32 nr_jited_ksyms;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a8b823c30b43..29a5bc3d5c66 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3143,6 +3143,7 @@ struct bpf_prog_info {
>         char name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
>         __u32 gpl_compatible:1;
> +       __u32 :31; /* alignment pad */
>         __u64 netns_dev;
>         __u64 netns_ino;
>         __u32 nr_jited_ksyms;
> --
> 2.20.1
>
