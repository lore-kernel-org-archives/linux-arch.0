Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35690 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdFHOJa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2017 10:09:30 -0400
Received: by mail-wr0-f169.google.com with SMTP id q97so19137069wrb.2
        for <linux-arch@vger.kernel.org>; Thu, 08 Jun 2017 07:09:29 -0700 (PDT)
Date: Thu, 8 Jun 2017 15:09:22 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCHv7 04/14] x86/boot/efi: Fix __KERNEL_CS definition of GDT
 entry on 64-bit configuration
Message-ID: <20170608140922.GC3220@codeblueprint.co.uk>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170606113133.22974-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606113133.22974-5-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170608140922.BNB2lL5MSptNAzgA8ovt-OGo9BOCYVvjmyeq91AEgmg@z>

On Tue, 06 Jun, at 02:31:23PM, Kirill A. Shutemov wrote:
> Define __KERNEL_CS GDT entry as long mode (.L=1, .D=0) on 64-bit
> configuration.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> ---
>  arch/x86/boot/compressed/eboot.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
