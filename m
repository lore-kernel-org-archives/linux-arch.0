Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45996 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbdJPWWi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Oct 2017 18:22:38 -0400
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/3] bpf: Don't check for current being NULL
Date: Tue, 17 Oct 2017 00:23:13 +0200
Message-ID: <1838884.qlCOuH57mO@blindfold>
In-Reply-To: <CAADnVQJzM3DH_gxAwo2mnGiv7bOsip1TAFF8YGPLx-dqSb1SPQ@mail.gmail.com>
References: <CAADnVQJzM3DH_gxAwo2mnGiv7bOsip1TAFF8YGPLx-dqSb1SPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Al Viro <viro@ftp.linux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20171016222313.OoHpB4aCh30EHTwOmXjZywxEi4YEFwNHd9c_8Ugtlj4@z>

Alexei,

Am Dienstag, 17. Oktober 2017, 00:06:08 CEST schrieb Alexei Starovoitov:
> On Mon, Oct 16, 2017 at 11:18 AM, Richard Weinberger <richard@nod.at> wrote:
> > current is never NULL.
> > 
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> > 
> >  kernel/bpf/helpers.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 3d24e238221e..e8845adcd15e 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -120,9 +120,6 @@ BPF_CALL_0(bpf_get_current_pid_tgid)
> > 
> >  {
> >  
> >         struct task_struct *task = current;
> > 
> > -       if (unlikely(!task))
> > -               return -EINVAL;
> > -
> 
> really? in all context? including irq and nmi?

I would be astonished current is NULL in such a context.

To be sure, let's CC linux-arch.
IIRC I talked also with Al about this and he also assumed that current
cannot be NULL.

Thanks,
//richard
