Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454DCC77B7F
	for <linux-arch@archiver.kernel.org>; Fri, 19 May 2023 11:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjESLEX (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 19 May 2023 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjESLEM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 07:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037619A2;
        Fri, 19 May 2023 04:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD7A3656B2;
        Fri, 19 May 2023 11:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA98C433D2;
        Fri, 19 May 2023 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684494232;
        bh=hCAAc+TNbuzkt0nWAsdUMnYbobl64u6xrVvPxYHXD6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nV61AYVtM/1pc9o0dc8qmGqQ0EntCR5w5fUA7GKknwh7nBnlh6K1q01En8E2Y1R8M
         eFwttfEtz7T/tcYVSB8dapyM0mtaenV5UAY5rD0KI7bIESEzA8v5R+uQbNIms5xeOl
         VkGka5Rolh3+BPmzCIh/poK0u/7oAu7y5vvMnSXL3QjbkHpAVpPAT1eRYa3StLXufi
         AcB6jNZGGIA5ChTksthScCMvbty0NHWJ0eCAorU0wuClfDEBuIxgsuxY4QypRGUJ+o
         Q0/GJ56/Q1ik6okcm1nkcSGrHW0J+0c2VfQA+Hlz8GNNyl7Z++mirjEvr/WjhlQ+Mw
         uGFNjvJ3JuWZA==
Date:   Fri, 19 May 2023 13:03:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/3] net: core: add getsockopt SO_PEERPIDFD
Message-ID: <20230519-zielbereich-inkompatibel-79e1a910e3f9@brauner>
References: <20230517113351.308771-1-aleksandr.mikhalitsyn@canonical.com>
 <20230517113351.308771-3-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517113351.308771-3-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 17, 2023 at 01:33:50PM +0200, Alexander Mikhalitsyn wrote:
> Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
> This thing is direct analog of SO_PEERCRED which allows to get plain PID.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Tested-by: Luca Boccassi <bluca@debian.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v5:
> 	- started using (struct proto)->bpf_bypass_getsockopt hook

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
