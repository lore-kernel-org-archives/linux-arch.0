Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35964 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbdFHOAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2017 10:00:39 -0400
Received: by mail-wm0-f44.google.com with SMTP id 7so138599649wmo.1
        for <linux-arch@vger.kernel.org>; Thu, 08 Jun 2017 07:00:34 -0700 (PDT)
Date: Thu, 8 Jun 2017 15:00:31 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCHv7 03/14] x86/boot/efi: Cleanup initialization of GDT
 entries
Message-ID: <20170608140031.GB3220@codeblueprint.co.uk>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170606113133.22974-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606113133.22974-4-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170608140031.5huKxRz4xFwAvInMuW4kiMd57m66e8usfs_5SCNe1x0@z>

On Tue, 06 Jun, at 02:31:22PM, Kirill A. Shutemov wrote:
> This is preparation for following patches without changing semantics of the
> code.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> ---
>  arch/x86/boot/compressed/eboot.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
