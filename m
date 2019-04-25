Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36699 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfDYSLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 14:11:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so245012pgc.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Apr 2019 11:11:21 -0700 (PDT)
Date: Thu, 25 Apr 2019 11:11:19 -0700 (PDT)
Subject: Re: [PATCH 3/3] riscv/signal: Fixup additional syscall restarting
In-Reply-To: <20190410065304.GA2942@infradead.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-e56eb5bc-3336-4e0e-897f-be508b1c5f4a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190425181119.lFVp2sBoAsnhbXjlVN_bZFBb8qZCmU5XhX-tygxSH1A@z>

On Tue, 09 Apr 2019 23:53:04 PDT (-0700), Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!  I've pulled just this patch into my for-next, as I'm assuming the
c-sky patches will go in seperately.  Given that it's been on the list for a
while I think it's a good candidate for rc7, so unless anyone says something or
testing causes a problem I'll send it up tomorrow.
