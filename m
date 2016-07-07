From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 1/9] mm: Hardened usercopy
Date: Thu, 7 Jul 2016 21:35:59 +0300
Message-ID: <20160707183559.GR2118@tarshish>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
 <20160707053710.GH2118@tarshish>
 <CAGXu5jJV4ZQp4VQ44SPQ49RxXpFXzx6d233A3+_Ka7txYHmuMw@mail.gmail.com>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-3847-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <CAGXu5jJV4ZQp4VQ44SPQ49RxXpFXzx6d233A3+_Ka7txYHmuMw@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux-MM <linux-mm@kvack.org>, sparclinux <sparclinux@vger.kernel.org>, linux-ia64@vger.kernel.org, Christoph Lameter <cl@linux.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, PaX Team <pageexec@freemail.hu>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Fenghua Yu <fenghua.yu@intel.com>, Rik van Riel <riel@redhat.com>, Vitaly Wool <vitalywool@gmail.com>
List-Id: linux-arch.vger.kernel.org

Hi Kees,

On Thu, Jul 07, 2016 at 01:25:21PM -0400, Kees Cook wrote:
> On Thu, Jul 7, 2016 at 1:37 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> > On Wed, Jul 06, 2016 at 03:25:20PM -0700, Kees Cook wrote:
> >> +#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
> >
> > Should be CONFIG_HARDENED_USERCOPY to match the slab/slub implementation
> > condition.
> >
> >> +const char *__check_heap_object(const void *ptr, unsigned long n,
> >> +                             struct page *page);
> >> +#else
> >> +static inline const char *__check_heap_object(const void *ptr,
> >> +                                           unsigned long n,
> >> +                                           struct page *page)
> >> +{
> >> +     return NULL;
> >> +}
> >> +#endif
> 
> Hmm, I think what I have is correct: if the allocator supports the
> heap object checking, it defines __check_heap_object as existing via
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR. If usercopy checking is done
> at all is controlled by CONFIG_HARDENED_USERCOPY.
> 
> I.e. you can have the other usercopy checks even if your allocator
> doesn't support object size checking.

Right. I missed the fact that usercopy.c build also depends on 
CONFIG_HARDENED_USERCOPY. Sorry for the noise.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
