Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35980 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbcLHSQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2016 13:16:08 -0500
MIME-Version: 1.0
In-Reply-To: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Dec 2016 10:16:07 -0800
Message-ID: <CA+55aFz+-8RmOMqyqQOWSjJ82byy7BpJ791-gj=xO2rPKG6KFA@mail.gmail.com>
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161208181607.WrkIeTQtioCpF8rKtDHlM3kRohZjQ_CzdrjMxFFhnN0@z>

On Thu, Dec 8, 2016 at 8:21 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> This patchset is still very early. There are a number of things missing
> that we have to do before asking anyone to merge it (listed below).
> It would be great if folks can start testing applications now (in QEMU) to
> look for breakage.
> Any early comments on the design or the patches would be appreciated as
> well.

Looks ok to me. Starting off with a compile-time config option seems fine.

I do think that the x86 cpuid part should (patch 15) should be the
first patch, so that we see "la57" as a capability in /proc/cpuinfo
whether it's being enabled or not? We should merge that part
regardless of any mm patches, I think.

               Linus
