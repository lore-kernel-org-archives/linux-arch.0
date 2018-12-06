From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 1/8] arm64: add type casts to untagged_addr macro
Date: Thu, 6 Dec 2018 13:34:28 +0100
Message-ID: <CAAeHK+z3uJrkwunH6DDuJOVg_trk6pmKgN4QLx7LnDLEP1TSDw@mail.gmail.com>
References: <cover.1541687720.git.andreyknvl@google.com> <4a4063a3e074608b99cf22ab447fecc36d056251.1541687720.git.andreyknvl@google.com>
 <20181129182218.GH22027@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129182218.GH22027@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Jac
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 29, 2018 at 7:22 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:36:08PM +0100, Andrey Konovalov wrote:
> > This patch makes the untagged_addr macro accept all kinds of address types
> > (void *, unsigned long, etc.) and allows not to specify type casts in each
> > place where it is used. This is done by using __typeof__.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 07c34087bd5e..c1325271e368 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -101,7 +101,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
> >   * up with a tagged userland pointer. Clear the tag to get a sane pointer to
> >   * pass on to access_ok(), for instance.
> >   */
> > -#define untagged_addr(addr)          sign_extend64(addr, 55)
> > +#define untagged_addr(addr)          \
> > +     ((__typeof__(addr))sign_extend64((__u64)(addr), 55))
>
> Nitpick: same comment as here (use u64):
>
> http://lkml.kernel.org/r/20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com

Will do in v9.

>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> (not acking the whole series just yet, only specific patches to remember
> what I reviewed)

OK.

Thanks!
