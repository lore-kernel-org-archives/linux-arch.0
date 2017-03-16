From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] Switch x86 to generic get_user_pages_fast() implementation
Date: Thu, 16 Mar 2017 11:03:07 -0700
Message-ID: <CA+55aFxh7E4OzCUgN-42jYzQGXCZEUoT8dZfnmkGTXi6fxrbmw@mail.gmail.com>
References: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37751 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdCPSDJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2017 14:03:09 -0400
In-Reply-To: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Dann Frazier <dann.frazier@canonical.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 16, 2017 at 8:26 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The patcheset generalize mm/gup.c implementation of get_user_pages_fast()
> to be usable for x86 and switches x86 over.

Thanks for doing this, it looks good and removes more lines than it adds.

And despite removing lines, it should make it easier for other
architectures to support devmap if they ever want to. I hadn't even
noticed that difference in the GUP implementations.

             Linus
