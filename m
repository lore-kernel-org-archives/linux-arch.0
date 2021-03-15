Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A72C433E0
	for <linux-arch@archiver.kernel.org>; Mon, 15 Mar 2021 19:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E2464E4D
	for <linux-arch@archiver.kernel.org>; Mon, 15 Mar 2021 19:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCOTwZ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 15 Mar 2021 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhCOTwP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 15:52:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2115AC06174A;
        Mon, 15 Mar 2021 12:52:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B296D2C4;
        Mon, 15 Mar 2021 19:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B296D2C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615837934; bh=vJ1LwzCHga3XYU7TZXaZBlXrzETaMIRW57nEqTnZdIk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mLmGDagdSoMzCzv7AIZnjz9vPzOXTXUxWVcu95DOrx3m0mmb4l0zs1iKDd63j0Fde
         aVWv5lV95GmUEVPZLpS7733T0+jTgdz15LUtrROmeSWt9IaJA6IpHZkZ9X6qmatxGS
         llJ1mjvLHPpImbY3/hN71IExCpQnWA9CdmWT1u4Szx9X1GmkLmbXSBzn8hDjNBYRQ6
         m83RUjB6LfgWNfQ+LQkuBoAgvCBVWvaraOiHgUWR/CpOIffX8Y3hSIjYy2upH5r5LP
         g7zhfIyw9U827alRltDw6JEl0bbltXFjHvvWkYhyfYQnOIYG7YWFG+Lygc64Gs+PPl
         ea321Zq36T8rg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH] docs: Group arch-specific documentation under "CPU
 Architectures"
In-Reply-To: <20210312152804.2110703-1-j.neuschaefer@gmx.net>
References: <20210312152804.2110703-1-j.neuschaefer@gmx.net>
Date:   Mon, 15 Mar 2021 13:52:14 -0600
Message-ID: <87k0q819g1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> To declutter the top-level table of contents (the side bar), this
> patch reduces the architecture-specfic documentation to one top-level
> item, "CPU Architectures".
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> As a side effect, the TOC in index.html effectively gets one level of
> detail less. This could be fixed by specifying ':maxdepth: 3'.
> ---
>  Documentation/arch.rst  | 26 ++++++++++++++++++++++++++
>  Documentation/index.rst | 20 ++------------------
>  2 files changed, 28 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/arch.rst

I've badly wanted to clean up that page for a long time; this is a step
in that direction, so I'm happy to see it.  Applied, thanks.

And no, we need *less* detail on the front page, not more, so no need to
bring all that back.

Thanks,

jon
