Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:48167 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934246AbdEZT0V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 15:26:21 -0400
Date: Fri, 26 May 2017 11:24:39 -0700
In-Reply-To: <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com> <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com> <20170526130057.t7zsynihkdtsepkf@node.shutemov.name> <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
From: hpa@zytor.com
Message-ID: <83F4880B-5D1F-4576-A9B6-7DDF4173E2E5@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170526182439.XTOT01P5GzAnhy3rKdhlEPzF7Js-xboZ3GeFnyj6dU0@z>

On May 26, 2017 8:51:48 AM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, May 26, 2017 at 6:00 AM, Kirill A. Shutemov
><kirill@shutemov.name> wrote:
>>
>> I don't see how kernel threads can use 4-level paging. It doesn't
>work
>> from virtual memory layout POV. Kernel claims half of full virtual
>address
>> space for itself -- 256 PGD entries, not one as we would effectively
>have
>> in case of switching to 4-level paging. For instance, addresses,
>where
>> vmalloc and vmemmap are mapped, are not canonical with 4-level
>paging.
>
>I would have just assumed we'd map the kernel in the shared part that
>fits in the top 47 bits.
>
>But it sounds like you can't switch back and forth anyway, so I guess
>it's moot.
>
>Where *is* the LA57 documentation, btw? I had an old x86 architecture
>manual, so I updated it, but LA57 isn't mentioned in the new one
>either.
>
>                       Linus

As one of the major motivations for LA57 is that we expect that we will have machines with more than 2^46 bytes of memory in the near future, it isn't feasible in most cases to do per-VM LA57.

The only case where that even has any utility is for an application to want more than 128 TiB address space on a machine with no more than 64 TiB of RAM.  It is kind of a narrow use case, I think.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
