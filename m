From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 21/21] csky: support dword access for get_user_size()
Date: Wed, 17 Oct 2018 17:44:17 +0200
Message-ID: <CAK8P3a1wfeWboHvU1o_kooMc2hML8iWcNrz=mp6tYT52iGwfjw@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com> <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 5:33 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Support dword access for get_user_size and redesign put_user_size with
> the same style of get_user_size. It's Ok to use xxx_user_asm_common for
> all size of variable with ldb, ldh, ldw, ld.d
>
> ld.d rx, (addr, 0) could "rx <= addr" "and r(x+1) <= addr+4" and this also
> follow abiv2 gcc ABI for dword access.

Are you sure this is correct for this?

static inline u32 get_64_to_32(__u64 __user *p)
{
      u32 ret;
      get_user(ret, p);
      return ret;
}

If I read __get_user_asm_common() right, the ld.d would overwrite
two registers, but the caller only expects one, so it clobbers one
that might be in use.

     Arnd
