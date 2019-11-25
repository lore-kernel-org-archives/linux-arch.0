Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33729 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKYWKl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:10:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so20139586wrr.0
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:10:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <8b0c833bde42e761cadfd3542263ad7a8be5eb5b.1573179553.git.thehajime@gmail.com>
In-Reply-To: <8b0c833bde42e761cadfd3542263ad7a8be5eb5b.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:10:28 +0100
Message-ID: <CAFLxGvw_tkmAq0nGrgEs8jQFGLADDuAyUOsYhdDzAH5yhHFHEA@mail.gmail.com>
Subject: Re: [RFC v2 05/37] lkl: memory handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>, Levente Kurusa <levex@linux.com>, Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, Yuan Liu <liuyuan@google.com>, linux-kernel-library@freelists.org

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> LKL is a non MMU architecture and hence there is not much work left to
> do other than initializing the boot allocator and providing the page
> and page table definitions.
>
> The backstore memory is allocated via a host operation and the memory
> size to be used is specified when the kernel is started, in the
> lkl_start_kernel call.
>
> Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Levente Kurusa <levex@linux.com>
> Signed-off-by: Yuan Liu <liuyuan@google.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  arch/um/lkl/include/asm/page.h          | 14 ++++++
>  arch/um/lkl/include/asm/pgtable.h       | 62 +++++++++++++++++++++++
>  arch/um/lkl/include/uapi/asm/host_ops.h |  5 ++
>  arch/um/lkl/mm/bootmem.c                | 66 +++++++++++++++++++++++++

This is also something which needs unification with UML.
UML in NOMMU mode would be LKL then...

--
Thanks,
//richard
