From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 2/8] uaccess: add untagged_addr definition for other arches
Date: Thu, 6 Dec 2018 13:36:46 +0100
Message-ID: <CAAeHK+y7AwdXsEgBYqLUzps2K8aGcbDsSpS+obCs11voZX55og@mail.gmail.com>
References: <cover.1541687720.git.andreyknvl@google.com> <c9028422854fb5bfb79d798397b30d4701207062.1541687720.git.andreyknvl@google.com>
 <20181129182323.GI22027@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129182323.GI22027@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Jac
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 29, 2018 at 7:23 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:36:09PM +0100, Andrey Konovalov wrote:
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index efe79c1cdd47..c045b4eff95e 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -13,6 +13,10 @@
> >
> >  #include <asm/uaccess.h>
> >
> > +#ifndef untagged_addr
> > +#define untagged_addr(addr) addr
> > +#endif
>
> Nitpick: add braces around (addr). Otherwise:

Will do in v9, thanks!

>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
