Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35776 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbfJPKfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 06:35:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so17035434lfl.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 03:35:38 -0700 (PDT)
Date: Wed, 16 Oct 2019 13:35:37 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 5/5] asm-generic/mm: stub out p{4,d}d_clear_bad() if
 __PAGETABLE_P{4,u}D_FOLDED
Message-ID: <20191016103537.oeanj7nh7u7yhk7l@box>
References: <20191015191926.9281-1-vgupta@synopsys.com>
 <20191015191926.9281-6-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015191926.9281-6-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20191016103537.iddu6jgg8K_52tZ-SHB9PxcexywS1hNaYlS3b4KW1fE@z>

There is couple of typos in the subject of the patch. It has to be

	[PATCH v2 5/5] asm-generic/mm: stub out p{4,u}d_clear_bad() if __PAGETABLE_P{4,U}D_FOLDED

Otherwise the patchset looks good to me. You can use my ACK for all
patches.

-- 
 Kirill A. Shutemov
