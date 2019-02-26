Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34710 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfBZXRy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 18:17:54 -0500
Date: Wed, 27 Feb 2019 00:17:49 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Message-ID: <20190226231747.z3lc6yr6xmrw5q2z@ltop.local>
References: <cover.1550839937.git.andreyknvl@google.com>
 <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
 <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190226231749.z4sUOY5zW1GMY-Xs3fvUtWJpSDumjnvQLGToSnuN7AU@z>

On Tue, Feb 26, 2019 at 06:18:25PM +0100, Andrey Konovalov wrote:
> On Fri, Feb 22, 2019 at 11:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > > The following testing approaches has been taken to find potential issues
> > > with user pointer untagging:
> > >
> > > 1. Static testing (with sparse [3] and separately with a custom static
> > >    analyzer based on Clang) to track casts of __user pointers to integer
> > >    types to find places where untagging needs to be done.
> >
> > First of all, it's really cool that you took this approach.  Sounds like
> > there was a lot of systematic work to fix up the sites in the existing
> > codebase.
> >
> > But, isn't this a _bit_ fragile going forward?  Folks can't just "make
> > sparse" to find issues with missing untags.
> 
> Yes, this static approach can only be used as a hint to find some
> places where untagging is needed, but certainly not all.
> 
> > This seems like something
> > where we would ideally add an __tagged annotation (or something) to the
> > source tree and then have sparse rules that can look for missed untags.
> 
> This has been suggested before, search for __untagged here [1].
> However there are many places in the kernel where a __user pointer is
> casted into unsigned long and passed further. I'm not sure if it's
> possible apply a __tagged/__untagged kind of attribute to non-pointer
> types, is it?
> 
> [1] https://patchwork.kernel.org/patch/10581535/

It's something that should need to be added to sparse since it's
different from what sparse already have (the existing __bitwise and
concept of address-space doesn't seem to do the job here).

-- Luc Van Oostenryck
