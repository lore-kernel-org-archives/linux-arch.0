Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45758 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbeHUTQ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2018 15:16:56 -0400
Date: Tue, 21 Aug 2018 08:56:11 -0700
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: cleanup PER_CPU_DEF_ATTRIBUTES macro
Message-ID: <20180821155611.GN3978217@devbig004.ftw2.facebook.com>
References: <20180821134030.lycgq7l7czetdngs@K55DR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821134030.lycgq7l7czetdngs@K55DR>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Pateenok <pateenoc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Dennis Zhou <dennisszhou@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180821155611.MkmuBUW9OjYqhyunJ1HhUJhvrE4rUgoZm2cbMp2TLKc@z>

Hello,

On Tue, Aug 21, 2018 at 04:40:30PM +0300, Alexander Pateenok wrote:
> The macro is not used:
> 
>   $ grep -r PER_CPU_DEF_ATTRIBUTES
>   include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak		\
>   include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES		\
>   include/asm-generic/percpu.h:#ifndef PER_CPU_DEF_ATTRIBUTES
>   include/asm-generic/percpu.h:#define PER_CPU_DEF_ATTRIBUTES
> 
> It was added with b01e8dc34379 ("alpha: fix percpu build breakage") and
> removed in 2009 with b01e8dc34379..6088464cf1ae.
> 
> Signed-off-by: Alexander Pateenok <pateenoc@gmail.com>

I'm not sure this is a meaningful cleanup, but then again, why not?
Can you please repost the patch to Andrew so that it can go through
-mm tree?  Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
