From: Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v12 08/13] net, arm64: untag user pointers in tcp_zerocopy_receive
Date: Mon, 18 Mar 2019 10:35:14 -0700
Message-ID: <CANn89iJ4SeccE79gKiv5RFqaouFV8shFA+0dCS8+2D_1aRq_Kw@mail.gmail.com>
References: <cover.1552929301.git.andreyknvl@google.com> <80e79c47dc7c5ee3572034a1d69bb724fbed2ecb.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80e79c47dc7c5ee3572034a1d69bb724fbed2ecb.1552929301.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@ker>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 18, 2019 at 10:18 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
>
> tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
> can only by done with untagged pointers.
>
> Untag user pointers in this function.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  net/ipv4/tcp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 6baa6dc1b13b..e76beb5ff1ff 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1749,7 +1749,7 @@ EXPORT_SYMBOL(tcp_mmap);
>  static int tcp_zerocopy_receive(struct sock *sk,
>                                 struct tcp_zerocopy_receive *zc)
>  {
> -       unsigned long address = (unsigned long)zc->address;
> +       unsigned long address;
>         const skb_frag_t *frags = NULL;
>         u32 length = 0, seq, offset;
>         struct vm_area_struct *vma;
> @@ -1758,7 +1758,12 @@ static int tcp_zerocopy_receive(struct sock *sk,
>         int inq;
>         int ret;
>
> -       if (address & (PAGE_SIZE - 1) || address != zc->address)
> +       address = (unsigned long)untagged_addr(zc->address);
> +
> +       /* The second test in this if detects if the u64->unsigned long
> +        * conversion had any truncated bits.
> +        */
> +       if (address & (PAGE_SIZE - 1) || address != untagged_addr(zc->address))
>                 return -EINVAL;
>
>         if (sk->sk_state == TCP_LISTEN)


This is quite ugly, the comment does not really help nor belong to this patch.

What about using  untagged_addr()  only once ?

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6baa6dc1b13b0b94b1da238668b93e167cf444fe..855a1f68c1ea9b0d07a92bd7f5e7c24840a99d3d
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1761,6 +1761,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
        if (address & (PAGE_SIZE - 1) || address != zc->address)
                return -EINVAL;

+       address = untagged_addr(address);
+
        if (sk->sk_state == TCP_LISTEN)
                return -ENOTCONN;
