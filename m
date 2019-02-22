Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfBVXHq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 18:07:46 -0500
Subject: Re: [PATCH v10 04/12] mm, arm64: untag user pointers passed to memory
 syscalls
References: <cover.1550839937.git.andreyknvl@google.com>
 <3875fa863b755d8cb43afa7bb0fe543e5fd05a5d.1550839937.git.andreyknvl@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <81ea4e77-90a4-4fd9-2bc8-135e0da30044@intel.com>
Date: Fri, 22 Feb 2019 15:07:45 -0800
MIME-Version: 1.0
In-Reply-To: <3875fa863b755d8cb43afa7bb0fe543e5fd05a5d.1550839937.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190222230745.H_8YJAFy2WwzaMP6K4H6CJyKDe78TA-oG2YhJ2q2YmY@z>

On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -578,6 +578,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
>  		unsigned long, prot)
>  {
> +	start = untagged_addr(start);
>  	return do_mprotect_pkey(start, len, prot, -1);
>  }
>  
> @@ -586,6 +587,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
>  SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
>  		unsigned long, prot, int, pkey)
>  {
> +	start = untagged_addr(start);
>  	return do_mprotect_pkey(start, len, prot, pkey);
>  }

This seems to have taken the approach of going as close as possible to
the syscall boundary and untagging the pointer there.  I guess that's
OK, but it does lead to more churn than necessary.  For instance, why
not just do the untagging in do_mprotect_pkey()?

I think that's an overall design question.  I kinda asked the same thing
about patching call sites vs. VMA lookup functions.
