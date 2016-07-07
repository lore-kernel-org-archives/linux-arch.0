From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/9] mm: Hardened usercopy
Date: Thu, 7 Jul 2016 13:25:21 -0400
Message-ID: <CAGXu5jJV4ZQp4VQ44SPQ49RxXpFXzx6d233A3+_Ka7txYHmuMw@mail.gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org> <20160707053710.GH2118@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:32859 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcGGRZX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2016 13:25:23 -0400
Received: by mail-wm0-f43.google.com with SMTP id r190so4073255wmr.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Jul 2016 10:25:22 -0700 (PDT)
In-Reply-To: <20160707053710.GH2118@tarshish>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux-MM <linux-mm@kvack.org>, sparclinux <sparclinux@vger.kernel.org>, linux-ia64@vger.kernel.org, Christoph Lameter <cl@linux.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, PaX Team <pageexec@freemail.hu>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli@googlemail.com>, Fenghua Yu <fenghua.yu@intel.com>, Rik van Riel <riel@redhat.com>, Vitaly Wool <vitalywool@gmail>

On Thu, Jul 7, 2016 at 1:37 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Kees,
>
> On Wed, Jul 06, 2016 at 03:25:20PM -0700, Kees Cook wrote:
>> +#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
>
> Should be CONFIG_HARDENED_USERCOPY to match the slab/slub implementation
> condition.
>
>> +const char *__check_heap_object(const void *ptr, unsigned long n,
>> +                             struct page *page);
>> +#else
>> +static inline const char *__check_heap_object(const void *ptr,
>> +                                           unsigned long n,
>> +                                           struct page *page)
>> +{
>> +     return NULL;
>> +}
>> +#endif

Hmm, I think what I have is correct: if the allocator supports the
heap object checking, it defines __check_heap_object as existing via
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR. If usercopy checking is done
at all is controlled by CONFIG_HARDENED_USERCOPY.

I.e. you can have the other usercopy checks even if your allocator
doesn't support object size checking.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
