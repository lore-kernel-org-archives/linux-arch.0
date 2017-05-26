Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:54059 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754444AbdEZTqF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 15:46:05 -0400
Date: Fri, 26 May 2017 12:36:31 -0700
In-Reply-To: <40d58ba7-277c-6f4e-a4d7-15425d675dbf@intel.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com> <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com> <20170526130057.t7zsynihkdtsepkf@node.shutemov.name> <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com> <83F4880B-5D1F-4576-A9B6-7DDF4173E2E5@zytor.com> <40d58ba7-277c-6f4e-a4d7-15425d675dbf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
From: hpa@zytor.com
Message-ID: <B4C5A54B-FC84-4B73-8ECC-CD14532CBA2C@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170526193631.p-drbx3ZH8Ja0lo7TN-sXIFkw9RYSupfHaR3BAkH5Io@z>

On May 26, 2017 12:23:18 PM PDT, Dave Hansen <dave.hansen@intel.com> wrote:
>On 05/26/2017 11:24 AM, hpa@zytor.com wrote:
>> The only case where that even has any utility is for an application
>> to want more than 128 TiB address space on a machine with no more
>> than 64 TiB of RAM.  It is kind of a narrow use case, I think.
>
>Doesn't more address space increase the effectiveness of ASLR?  I
>thought KASLR, especially, was limited in its effectiveness because of
>a
>lack of address space.

The shortage of address space for KASLR is not addressable by LA57; rather, it would have to be addressed by compiling the kernel using a different (less efficient) memory model, presumably the "medium" memory model.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
