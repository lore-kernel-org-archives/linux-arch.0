Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36797 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbcLHSlD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2016 13:41:03 -0500
Received: by mail-ua0-f181.google.com with SMTP id b35so455694182uaa.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Dec 2016 10:41:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161208162150.148763-24-kirill.shutemov@linux.intel.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com> <20161208162150.148763-24-kirill.shutemov@linux.intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 8 Dec 2016 10:40:41 -0800
Message-ID: <CALCETrXXNfL1OyZBa4tHm0cGz3trHV_FiJv=gtk2QRm-HrRXRg@mail.gmail.com>
Subject: Re: [RFC, PATCHv1 22/28] x86/espfix: support 5-level paging
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20161208184041.85B5hdpB10H18A9TCiafq2IFzNTJqnpASfIB-tV1JV8@z>

On Thu, Dec 8, 2016 at 8:21 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> XXX: how to test this?

tools/testing/selftests/x86/sigreturn_{32,64}
