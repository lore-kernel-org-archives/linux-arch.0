Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38353 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbdDKKvJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2017 06:51:09 -0400
Received: by mail-wm0-f47.google.com with SMTP id t189so58020038wmt.1
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2017 03:51:09 -0700 (PDT)
Date: Tue, 11 Apr 2017 13:51:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 3/8] x86/boot/64: Add support of additional page table
 level during early boot
Message-ID: <20170411105106.4zgbzuu4s4267zyv@node.shutemov.name>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-4-kirill.shutemov@linux.intel.com>
 <20170411070203.GA14621@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411070203.GA14621@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170411105106.15GJ0MLBJ_IJ9J94hbWqvZHAkRGD1og5oXmYj9E65h8@z>

On Tue, Apr 11, 2017 at 09:02:03AM +0200, Ingo Molnar wrote:
> I realize that you had difficulties converting this to C, but it's not going to 
> get any easier in the future either, with one more paging mode/level added!
> 
> If you are stuck on where it breaks I'd suggest doing it gradually: first add a 
> trivial .c, build and link it in and call it separately. Then once that works, 
> move functionality from asm to C step by step and test it at every step.

I've described the specific issue with converting this code to C in cover
letter: how to make compiler to generate 32-bit code for a specific
function or translation unit, without breaking linking afterwards (-m32
break it).

I would be glad to convert it, but I'm stuck.

Do you have an idea how to get around the issue.

-- 
 Kirill A. Shutemov
