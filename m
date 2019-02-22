Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:35507 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBVWyw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 17:54:52 -0500
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
References: <cover.1550839937.git.andreyknvl@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
Date: Fri, 22 Feb 2019 14:54:51 -0800
MIME-Version: 1.0
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190222225451.nDNJHiXeXcV-HBL9UbCX_kEFVOVg_wFVnftKfKLters@z>

On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> The following testing approaches has been taken to find potential issues
> with user pointer untagging:
> 
> 1. Static testing (with sparse [3] and separately with a custom static
>    analyzer based on Clang) to track casts of __user pointers to integer
>    types to find places where untagging needs to be done.

First of all, it's really cool that you took this approach.  Sounds like
there was a lot of systematic work to fix up the sites in the existing
codebase.

But, isn't this a _bit_ fragile going forward?  Folks can't just "make
sparse" to find issues with missing untags.  This seems like something
where we would ideally add an __tagged annotation (or something) to the
source tree and then have sparse rules that can look for missed untags.
