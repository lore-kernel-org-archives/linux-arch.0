Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33262 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752976AbcLLOWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2016 09:22:33 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so11792690wjc.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Dec 2016 06:22:32 -0800 (PST)
Date: Mon, 12 Dec 2016 17:22:29 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC, PATCHv1 22/28] x86/espfix: support 5-level paging
Message-ID: <20161212142229.GA4208@node>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161208162150.148763-24-kirill.shutemov@linux.intel.com>
 <CALCETrXXNfL1OyZBa4tHm0cGz3trHV_FiJv=gtk2QRm-HrRXRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXXNfL1OyZBa4tHm0cGz3trHV_FiJv=gtk2QRm-HrRXRg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20161212142229.dCMSVwtUK8qKCF33jHc-ExCggyJjmFux26HJqMoF2Uo@z>

On Thu, Dec 08, 2016 at 10:40:41AM -0800, Andy Lutomirski wrote:
> On Thu, Dec 8, 2016 at 8:21 AM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > XXX: how to test this?
> 
> tools/testing/selftests/x86/sigreturn_{32,64}

Hm. They fail on non-patched kernel with QEMU, but not KVM. :-/
I guess I'd need to fix QEMU first.

-- 
 Kirill A. Shutemov
