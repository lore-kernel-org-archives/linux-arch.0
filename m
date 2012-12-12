Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:46750 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab2LLDeL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Dec 2012 22:34:11 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so73042dad.36
        for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2012 19:34:10 -0800 (PST)
Date: Tue, 11 Dec 2012 19:07:14 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH, RESEND] asm-generic, mm: pgtable: consolidate zero page
 helpers
In-Reply-To: <1354881215-26257-1-git-send-email-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.00.1212111906270.18872@chino.kir.corp.google.com>
References: <1354881215-26257-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, John Crispin <blogic@openwrt.org>
Message-ID: <20121212030714.5ghHthkhsn4qPj6kFBfIFCRsJeSQymJooq_x4w4Vc5U@z>

On Fri, 7 Dec 2012, Kirill A. Shutemov wrote:

> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> We have two different implementation of is_zero_pfn() and
> my_zero_pfn() helpers: for architectures with and without zero page
> coloring.
> 
> Let's consolidate them in <asm-generic/pgtable.h>.
> 

What's the benefit from doing this other than generalizing some per-arch 
code?  It simply adds on more layer of redirection to try to find the 
implementation that matters for the architecture you're hacking on.
