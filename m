Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42285 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424224Ab2LGUfT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2012 15:35:19 -0500
Date: Fri, 7 Dec 2012 12:35:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH, REBASED] asm-generic, mm: PTE_SPECIAL cleanup
Message-ID: <20121207123517.3fc93a34.akpm@linux-foundation.org>
In-Reply-To: <20121207144112.GA17044@otc-wbsnb-06>
References: <1354881321-29363-1-git-send-email-kirill.shutemov@linux.intel.com>
	<20121207143002.GB21233@arm.com>
	<20121207144112.GA17044@otc-wbsnb-06>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20121207203517.qve1rYYJzk5Abw129X9KubXi6xJRal1joJB-iG5Fe1Q@z>

On Fri, 7 Dec 2012 16:41:12 +0200
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Advertise PTE_SPECIAL through Kconfig option and consolidate dummy
> pte_special() and mkspecial() in <asm-generic/pgtable.h>

why?
