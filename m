Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41061 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab2JOQQe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 12:16:34 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1440840qad.19
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2012 09:16:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1350302608-8322-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1350302608-8322-1-git-send-email-kirill.shutemov@linux.intel.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 15 Oct 2012 17:16:13 +0100
Message-ID: <CAHkRjk7akwhcmeYV_Ank-YVotUMW0mN_1xeu5zbXWE+z5d9xdg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic, mm: PTE_SPECIAL cleanup
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20121015161613.na3vHvUYJSEmwgpLWFPBA7_2-AmvN-rNI23J33AeZEE@z>

On 15 October 2012 13:03, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Advertise PTE_SPECIAL through Kconfig option and consolidate dummy
> pte_special() and mkspecial() in <asm-generic/pgtable.h>
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/Kconfig                             |    6 ++++++
>  arch/alpha/include/asm/pgtable.h         |    2 --
>  arch/arm/include/asm/pgtable.h           |    3 ---
>  arch/arm64/Kconfig                       |    1 +
>  arch/arm64/include/asm/pgtable.h         |    2 --

For the arm64 bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
