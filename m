From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] make asm-generic/cacheflush.h more standalone
Date: Tue, 23 Jun 2020 08:56:23 +0200
Message-ID: <CAK8P3a34mMnZa3FWaZ6tCRZBEQuhUNNaHsFjXZC+Xe_hnoxdxw@mail.gmail.com>
References: <20200623135714.4dae4b8a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:44947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgFWG4l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 02:56:41 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M5fdC-1jm0260U2c-007CHn for <linux-arch@vger.kernel.org>; Tue, 23 Jun
 2020 08:56:40 +0200
Received: by mail-qk1-f172.google.com with SMTP id e11so8631318qkm.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 23:56:39 -0700 (PDT)
In-Reply-To: <20200623135714.4dae4b8a@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, Jun 23, 2020 at 5:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Some s390 builds get these warnings:
>
> include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:22:46: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:28:45: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:36:44: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:44:45: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:52:50: warning: 'struct address_space' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:58:52: warning: 'struct address_space' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:75:17: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:74:45: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:82:16: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:81:50: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
>
> Forward declare the named structs to get rid of these.
>
> Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
