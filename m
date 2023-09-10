Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D99EE57CD
	for <linux-arch@archiver.kernel.org>; Sun, 10 Sep 2023 08:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbjIJI6m (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 10 Sep 2023 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjIJI6l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:58:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024B1B5;
        Sun, 10 Sep 2023 01:58:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C4C433C7;
        Sun, 10 Sep 2023 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694336316;
        bh=ie3mkzGb78frh1QxUYvyoQn4GH0ST3RCcUoT31fNuUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtepG0xn8dCUF6d/nvOR4p1KA2z2RoXleNgidaXdsI9NMFCQI2q0CfrdT8VA/xygA
         m9gdZoMzTl7LlfrvfDZn6IxiU6Z84Y/BqBFsUPlsu0QWk5zOpwIhLbNJNPd1yrYzr2
         5k7/NNn7whYrqyhR1WWdaINPnEJEnlj69/XbcRYYcrLpaGrnuh18sYNheT5vmRdjM7
         cUcFoumVx1hEASilEz09Br0aei9/BXf8xgSxmpfUnHESm2+yiSSEwFeT5AhDSpyqmX
         7jW3wC4u+YKTQdvs/mFwr44+sYiPOYiubMpijZThv68+ydMS+N0VFyZl1GyC0crQc8
         NhSBcQJFlrsGw==
Date:   Sun, 10 Sep 2023 09:58:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
Message-ID: <20230910-esteemed-exodus-706aaae940b1@spud>
References: <20230910082911.3378782-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ORxaGwMyxaL8VJte"
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ORxaGwMyxaL8VJte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote:

> Changlog:
> V11:
>  - Based on Leonardo Bras's cmpxchg_small patches v5.
>  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v3.
>  - Remove abusing alternative framework and use jump_label instead.

btw, I didn't say that using alternatives was the problem, it was
abusing the errata framework to perform feature detection that I had
a problem with. That's not changed in v11.

A stronger forward progress guarantee is not an erratum, AFAICT.

>  - Introduce prefetch.w to improve T-HEAD processors' LR/SC forward progress
>    guarantee.
>  - Optimize qspinlock xchg_tail when NR_CPUS >= 16K.

--ORxaGwMyxaL8VJte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP2FNAAKCRB4tDGHoIJi
0vtHAQDkzGM0Ps4GL3DcCukAmWgFu5NhrG8JrAccsQivkfwJiQD/VS20Hau/Evtj
7e/AK20nyAL4aPqBlnjOO0LuZ9X5mQI=
=80fi
-----END PGP SIGNATURE-----

--ORxaGwMyxaL8VJte--
