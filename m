Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46162 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCSQPA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Mar 2019 12:15:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id s23so14020774pfe.13
        for <linux-arch@vger.kernel.org>; Tue, 19 Mar 2019 09:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com> <80e79c47dc7c5ee3572034a1d69bb724fbed2ecb.1552929301.git.andreyknvl@google.com>
 <CANn89iJ4SeccE79gKiv5RFqaouFV8shFA+0dCS8+2D_1aRq_Kw@mail.gmail.com>
In-Reply-To: <CANn89iJ4SeccE79gKiv5RFqaouFV8shFA+0dCS8+2D_1aRq_Kw@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 19 Mar 2019 17:14:47 +0100
Message-ID: <CAAeHK+xi4-6pgDYG8ypM8NsbhgncpsxgJeEXL1-BpkARXONvEQ@mail.gmail.com>
Subject: Re: [PATCH v12 08/13] net, arm64: untag user pointers in tcp_zerocopy_receive
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190319161447.YexKX7y0Q3qAnIr12755gR0wydQpUeGmhh7dSswEj8Q@z>

On Mon, Mar 18, 2019 at 6:35 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Mar 18, 2019 at 10:18 AM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
> > can only by done with untagged pointers.
> >
> > Untag user pointers in this function.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  net/ipv4/tcp.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 6baa6dc1b13b..e76beb5ff1ff 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1749,7 +1749,7 @@ EXPORT_SYMBOL(tcp_mmap);
> >  static int tcp_zerocopy_receive(struct sock *sk,
> >                                 struct tcp_zerocopy_receive *zc)
> >  {
> > -       unsigned long address = (unsigned long)zc->address;
> > +       unsigned long address;
> >         const skb_frag_t *frags = NULL;
> >         u32 length = 0, seq, offset;
> >         struct vm_area_struct *vma;
> > @@ -1758,7 +1758,12 @@ static int tcp_zerocopy_receive(struct sock *sk,
> >         int inq;
> >         int ret;
> >
> > -       if (address & (PAGE_SIZE - 1) || address != zc->address)
> > +       address = (unsigned long)untagged_addr(zc->address);
> > +
> > +       /* The second test in this if detects if the u64->unsigned long
> > +        * conversion had any truncated bits.
> > +        */
> > +       if (address & (PAGE_SIZE - 1) || address != untagged_addr(zc->address))
> >                 return -EINVAL;
> >
> >         if (sk->sk_state == TCP_LISTEN)
>
>
> This is quite ugly, the comment does not really help nor belong to this patch.
>
> What about using  untagged_addr()  only once ?
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 6baa6dc1b13b0b94b1da238668b93e167cf444fe..855a1f68c1ea9b0d07a92bd7f5e7c24840a99d3d
> 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1761,6 +1761,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
>         if (address & (PAGE_SIZE - 1) || address != zc->address)
>                 return -EINVAL;
>
> +       address = untagged_addr(address);
> +
>         if (sk->sk_state == TCP_LISTEN)
>                 return -ENOTCONN;

Looks good, will do it like this in the next version. Thanks!
