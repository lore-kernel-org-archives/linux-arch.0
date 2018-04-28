Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbeD1FFI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Apr 2018 01:05:08 -0400
Date: Sat, 28 Apr 2018 07:04:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Message-ID: <20180428050458.GF29422@kroah.com>
References: <20180428001526.22475-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428001526.22475-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20180428050458.qE5yBPr_NSgNgq7KsT92rr2YIvPdbXDnbGAjzBmIT6Q@z>

On Fri, Apr 27, 2018 at 05:15:26PM -0700, Luis R. Rodriguez wrote:
> Some architectures do not define PAGE_KERNEL_RO, best we can do
> for them is to provide a fallback onto PAGE_KERNEL. Remove the
> hack from the firmware loader and move it onto the asm-generic
> header, and document while at it the affected architectures
> which do not have a PAGE_KERNEL_RO:
> 
>   o alpha
>   o ia64
>   o m68k
>   o mips
>   o sparc64
>   o sparc
> 
> Blessed-by: 0-day

New tag?  :)
