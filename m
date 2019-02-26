Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbfBZRf1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 12:35:27 -0500
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
References: <cover.1550839937.git.andreyknvl@google.com>
 <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
 <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6abc8c6a-c7aa-72ec-8a4e-7dcfeb9ea09b@intel.com>
Date: Tue, 26 Feb 2019 09:35:26 -0800
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190226173526.mIso6bhF9rb0ygjSogq09fN8CpBiOdds_Gl6A53jhXg@z>

On 2/26/19 9:18 AM, Andrey Konovalov wrote:
>> This seems like something
>> where we would ideally add an __tagged annotation (or something) to the
>> source tree and then have sparse rules that can look for missed untags.
> This has been suggested before, search for __untagged here [1].
> However there are many places in the kernel where a __user pointer is
> casted into unsigned long and passed further. I'm not sure if it's
> possible apply a __tagged/__untagged kind of attribute to non-pointer
> types, is it?
> 
> [1] https://patchwork.kernel.org/patch/10581535/

I believe we have sparse checking __GFP_* flags.  We also have a gfp_t
for them and I'm unsure whether the sparse support is tied to _that_ or
whether it's just by tagging the type itself as being part of a discrete
address space.
