Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43554 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbcLHS1H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Dec 2016 13:27:07 -0500
In-Reply-To: <CA+55aFz+-8RmOMqyqQOWSjJ82byy7BpJ791-gj=xO2rPKG6KFA@mail.gmail.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com> <CA+55aFz+-8RmOMqyqQOWSjJ82byy7BpJ791-gj=xO2rPKG6KFA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
From: hpa@zytor.com
Date: Thu, 08 Dec 2016 10:26:38 -0800
Message-ID: <6D8D56F4-6056-4533-BCFE-5FE292195D34@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161208182638.4HTYRDUkL4mg44ZlGdd8XXYWjxrY75P1TT3ZsE4QrK4@z>

On December 8, 2016 10:16:07 AM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Thu, Dec 8, 2016 at 8:21 AM, Kirill A. Shutemov
><kirill.shutemov@linux.intel.com> wrote:
>>
>> This patchset is still very early. There are a number of things
>missing
>> that we have to do before asking anyone to merge it (listed below).
>> It would be great if folks can start testing applications now (in
>QEMU) to
>> look for breakage.
>> Any early comments on the design or the patches would be appreciated
>as
>> well.
>
>Looks ok to me. Starting off with a compile-time config option seems
>fine.
>
>I do think that the x86 cpuid part should (patch 15) should be the
>first patch, so that we see "la57" as a capability in /proc/cpuinfo
>whether it's being enabled or not? We should merge that part
>regardless of any mm patches, I think.
>
>               Linus

Definitely.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
