Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36746 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdFHOSp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2017 10:18:45 -0400
Received: by mail-wr0-f170.google.com with SMTP id v111so19213050wrc.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Jun 2017 07:18:44 -0700 (PDT)
Date: Thu, 8 Jun 2017 15:18:42 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCHv7 05/14] x86/boot/efi: Define __KERNEL32_CS GDT on 64-bit
 configurations
Message-ID: <20170608141842.GD3220@codeblueprint.co.uk>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170606113133.22974-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606113133.22974-6-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170608141842.nszcQz84Ws3cCqmh9wOs_sgRFBGu779rkySx7rOD938@z>

On Tue, 06 Jun, at 02:31:24PM, Kirill A. Shutemov wrote:
> We would need to switch temporarily to compatibility mode during booting
> with 5-level paging enabled. It would require 32-bit code segment
> descriptor.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> ---
>  arch/x86/boot/compressed/eboot.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
