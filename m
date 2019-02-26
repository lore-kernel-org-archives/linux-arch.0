Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37867 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfBZRSi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 12:18:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so6557790pfh.4
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 09:18:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com> <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
In-Reply-To: <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 26 Feb 2019 18:18:25 +0100
Message-ID: <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190226171825._D2PH2h3JRnvGYbJdQhfroNYivXrsq-ydkftdZyCOaE@z>

On Fri, Feb 22, 2019 at 11:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > The following testing approaches has been taken to find potential issues
> > with user pointer untagging:
> >
> > 1. Static testing (with sparse [3] and separately with a custom static
> >    analyzer based on Clang) to track casts of __user pointers to integer
> >    types to find places where untagging needs to be done.
>
> First of all, it's really cool that you took this approach.  Sounds like
> there was a lot of systematic work to fix up the sites in the existing
> codebase.
>
> But, isn't this a _bit_ fragile going forward?  Folks can't just "make
> sparse" to find issues with missing untags.

Yes, this static approach can only be used as a hint to find some
places where untagging is needed, but certainly not all.

> This seems like something
> where we would ideally add an __tagged annotation (or something) to the
> source tree and then have sparse rules that can look for missed untags.

This has been suggested before, search for __untagged here [1].
However there are many places in the kernel where a __user pointer is
casted into unsigned long and passed further. I'm not sure if it's
possible apply a __tagged/__untagged kind of attribute to non-pointer
types, is it?

[1] https://patchwork.kernel.org/patch/10581535/
