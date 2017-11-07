From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
Date: Tue, 7 Nov 2017 14:16:58 +0300
Message-ID: <20171107111658.ifkbeg4dnlheabnr@node.shutemov.name>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <b7348864-533a-ef40-e66f-b14d0f422c04@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:46751 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbdKGLRA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Nov 2017 06:17:00 -0500
Received: by mail-wm0-f45.google.com with SMTP id r68so2938187wmr.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2017 03:17:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b7348864-533a-ef40-e66f-b14d0f422c04@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 07, 2017 at 09:15:21AM +0100, Florian Weimer wrote:
> MAP_FIXED is near-impossible to use correctly.  I hope you don't expect
> applications to do that.  If you want address-based opt in, it should work
> without MAP_FIXED.  Sure, in obscure cases, applications might still see
> out-of-range addresses, but I expected a full opt-out based on RLIMIT_AS
> would be sufficient for them.

Just use mmap(-1), without MAP_FIXED to get full address space.

-- 
 Kirill A. Shutemov
