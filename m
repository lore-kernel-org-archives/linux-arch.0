Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D575C05027
	for <linux-arch@archiver.kernel.org>; Mon,  6 Feb 2023 08:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBFIPg (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 6 Feb 2023 03:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjBFIPg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 03:15:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C06187;
        Mon,  6 Feb 2023 00:15:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 275F7B80D3E;
        Mon,  6 Feb 2023 08:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37752C433EF;
        Mon,  6 Feb 2023 08:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675671330;
        bh=2gQ41oYPOBY5IgrYuSTiswD4o/d5V+Imcxfkr8pdJVQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OLCLAE9iWVg8sdJLB1pTwzy/jiRZOhjVjYYxysGh7i1M45W5h29UkzQGcta/UFQUi
         47AjTT1hAsX1fgw+3wEmY2oulcaMkHwvAyD3JmHpCP1tsx/9l9fcSBG16FMZbvnc/D
         rCdIBNh+GCr5jsFLmQAkjKhekZeCT2ebH2xVGwo+ixHlM0MnU/w2OTq1mfvtcDn9hG
         z8NMSQQUKuZ1NlAER0OK2Akix3cNgSTovObtCwyX64VJYFJRT+n6Ryti4KdRbXCwVl
         /I5UWQ0gX0CNEdz7B3DLd5T0r9nXeWzwx1AOwBuCI0TuSDGb6rEgoNDZzu5KRB65aY
         G5ZpZL3BJMrkg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, guoren@kernel.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Subject: Re: [PATCH V2] riscv: kprobe: Fixup misaligned load text
In-Reply-To: <20230204063531.740220-1-guoren@kernel.org>
References: <20230204063531.740220-1-guoren@kernel.org>
Date:   Mon, 06 Feb 2023 09:15:27 +0100
Message-ID: <87mt5rgqg0.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> The current kprobe would cause a misaligned load for the probe point.
> This patch fixup it with two half-word loads instead.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/878rhig9zj.fsf@all.your.base.ar=
e.belong.to.us/
> Reported-by: Bjorn Topel <bjorn.topel@gmail.com>
> Cc: Jessica Clarke <jrtc27@jrtc27.com>
> ---
> Changelog
> V2:
>  - Optimize coding convention (Thx Bjorn & Jessica)

Thank you for fixing this!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
