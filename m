Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34632 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbdB1Mid (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2017 07:38:33 -0500
Received: by mail-wm0-f44.google.com with SMTP id 196so23491885wmm.1
        for <linux-arch@vger.kernel.org>; Tue, 28 Feb 2017 04:38:32 -0800 (PST)
Date: Tue, 28 Feb 2017 12:38:30 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCHv3 15/33] x86/efi: handle p4d in EFI pagetables
Message-ID: <20170228123830.GF28416@codeblueprint.co.uk>
References: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
 <20170217141328.164563-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217141328.164563-16-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170228123830.ZoIEIcEFBYWrilVhbSrgwO7Sntda0CKliwLiMhGyQfg@z>

On Fri, 17 Feb, at 05:13:10PM, Kirill A. Shutemov wrote:
> Allocate additional page table level and change efi_sync_low_kernel_mappings()
> to make syncing logic work with additional page table level.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> ---
>  arch/x86/platform/efi/efi_64.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)

Looks fine to me, but I haven't tested it.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
