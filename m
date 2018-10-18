From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 21/21] csky: support dword access for get_user_size()
Date: Thu, 18 Oct 2018 16:57:52 +0800
Message-ID: <20181018085751.GA21934@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a1wfeWboHvU1o_kooMc2hML8iWcNrz=mp6tYT52iGwfjw@mail.gmail.com>
 <20181018034117.GD15088@guoren-Inspiron-7460>
 <CAK8P3a0cFhBE1tX0xisP__MYiBfaAUQHsW6ZhkmTPocRf1Zb6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0cFhBE1tX0xisP__MYiBfaAUQHsW6ZhkmTPocRf1Zb6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 18, 2018 at 10:34:00AM +0200, Arnd Bergmann wrote:
> On Thu, Oct 18, 2018 at 5:41 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > On Wed, Oct 17, 2018 at 05:44:17PM +0200, Arnd Bergmann wrote:
> > > On Tue, Oct 16, 2018 at 5:33 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > >
> > > > Support dword access for get_user_size and redesign put_user_size with
> > > > the same style of get_user_size. It's Ok to use xxx_user_asm_common for
> > > > all size of variable with ldb, ldh, ldw, ld.d
> > > >
> > > > ld.d rx, (addr, 0) could "rx <= addr" "and r(x+1) <= addr+4" and this also
> > > > follow abiv2 gcc ABI for dword access.
> > >
> > > Are you sure this is correct for this?
> > >
> > > static inline u32 get_64_to_32(__u64 __user *p)
> > > {
> > >       u32 ret;
> > >       get_user(ret, p);
> > >       return ret;
> > > }
> > >
> > > If I read __get_user_asm_common() right, the ld.d would overwrite
> > > two registers, but the caller only expects one, so it clobbers one
> > > that might be in use.
> > Ah... BUG! I only consider the get_user(u64, u64 *) :P
> >
> > Change to:
> > case 8:                                                 \
> > __get_user_asm_dword((x), ptr, "ld.d", retval);         \
> > break;
> >
> > #define __get_user_asm_dword(x, ptr, err)               \
> > do {                                                    \
> >         u64 tmp;                                        \
> >         __get_user_asm_common(tmp, ptr, "ld.d", err);   \
> >         x = typeof(x) tmp;                              \
> > } while(0)
> >
> > #define __put_user_asm_dword(x, ptr, err)               \
> > do {                                                    \
> >         u64 tmp = (u64) x;                              \
> >         __put_user_asm_common(tmp, ptr, "st.d", err);   \
> > } while(0)
> >
> 
> I think this will cause warnings for code that passes a pointer.
> 
> The 64-bit __get_user() is really hard, and most 32-bit architectures don't
> implement it at all. If you really want to add it, have a look at what
> x86 and arm do. IIRC they both use __builtin_choose_expr(),
Thx for the tips and I'll drop the patch first for the upstream. 

I want to implement it because of make allmodconfig and
drivers/android/binder.c need it. I'll learn __builtin_choose_expr()
and prepare patch next.

Best Regards
 Guo Ren
