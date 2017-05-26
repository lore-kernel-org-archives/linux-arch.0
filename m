From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level
 paging
Date: Fri, 26 May 2017 12:23:18 -0700
Message-ID: <40d58ba7-277c-6f4e-a4d7-15425d675dbf@intel.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
 <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
 <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com>
 <83F4880B-5D1F-4576-A9B6-7DDF4173E2E5@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26915 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754322AbdEZTXe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 15:23:34 -0400
In-Reply-To: <83F4880B-5D1F-4576-A9B6-7DDF4173E2E5@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com, Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/26/2017 11:24 AM, hpa@zytor.com wrote:
> The only case where that even has any utility is for an application
> to want more than 128 TiB address space on a machine with no more
> than 64 TiB of RAM.  It is kind of a narrow use case, I think.

Doesn't more address space increase the effectiveness of ASLR?  I
thought KASLR, especially, was limited in its effectiveness because of a
lack of address space.
