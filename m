Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E27C433B4
	for <linux-arch@archiver.kernel.org>; Wed, 19 May 2021 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5580561353
	for <linux-arch@archiver.kernel.org>; Wed, 19 May 2021 20:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhESUe3 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 19 May 2021 16:34:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUe3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 May 2021 16:34:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621456388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0p8MioOkDUIBuJUcEW1idhCC8PIDTDypesaYkL0D8Yo=;
        b=r3hCAeM72iIkQ5X8tjaCnyHmWELYwuc8uLvTv+0kZaHCPlPe0Kw+OVX3izs+vFbLXeWuIX
        HtBC1Upm/MU2skOoz4nlIkiLrwfRONwvX7eCrucGGnTUHJbmonPhf/B/hWqpg133YKrdp/
        DQ2SmgNR6aZpeedjeUg0sVigsTyyxfiD2Lm1whXcnCwnVURdL5sg9CBpl+UaR1R5M3miOQ
        K2P1KeYsiGjPX8AJwAvcHfzbm3eqXabrKPp6NpGGeRJVc5eYSZKfuZP9FZnLMQujEA3qAQ
        DPEV8aDYrrf5hWmKF2XSWmb4PX8aL0sV0ftdmJk8WrQs0NTOD3kXCOAklsfhHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621456388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0p8MioOkDUIBuJUcEW1idhCC8PIDTDypesaYkL0D8Yo=;
        b=Pob2NdQPhmtTENHwM04XCsn7t3KGOmUUm1iHfU+olicjxvbwriUj9R5SifesEGPw6quTQk
        4jF4ZBUGIjkQ6zAQ==
To:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v3 4/4] compat: remove some compat entry points
In-Reply-To: <20210517203343.3941777-5-arnd@kernel.org>
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-5-arnd@kernel.org>
Date:   Wed, 19 May 2021 22:33:07 +0200
Message-ID: <87h7iycvlo.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 17 2021 at 22:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These are all handled correctly when calling the native
> system call entry point, so remove the special cases.
>  arch/x86/entry/syscall_x32.c              |  2 ++
>  arch/x86/entry/syscalls/syscall_32.tbl    |  6 ++--
>  arch/x86/entry/syscalls/syscall_64.tbl    |  4 +--

That conflicts with

  https://lore.kernel.org/lkml/20210517073815.97426-1-masahiroy@kernel.org/

which I'm picking up. We have more changes in that area coming in.

Thanks,

        tglx


