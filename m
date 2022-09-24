Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B3C07E9D
	for <linux-arch@archiver.kernel.org>; Sat, 24 Sep 2022 18:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiIXSGz (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 24 Sep 2022 14:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIXSGx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 14:06:53 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C85F117;
        Sat, 24 Sep 2022 11:06:52 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28OI6YeX027777;
        Sun, 25 Sep 2022 03:06:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28OI6YeX027777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664042795;
        bh=hDMgnX158MrDwG0mktalw7fgYIgMHBpCkQ8IghHeCnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ki8kE+FCBcCOj4n/pXw8dAZsRcR/UQsAIl22GS4E47CzeZ/ZwVTpa2G0+3Eg5UCzP
         tI2gW9Z1/REzWFQUcMR6mxdT2dafW8lTzeCn/jVZQ2IzqhFy4Rc3uLdR78hbJ1g+2P
         6P/tXAEnBQrGM2yGb9i3c/wvbYhMCwz9Npn3ODyQcUDLpEaauKgiEBXIOFleY3cr2/
         oWcKOAdooObrTXbW3B1VqlSQ+COJ3hgsFo3KQ01Fby3e6T96isMSF01bXQCHHb8zm6
         oEjqAQqBC7cxhEAtrIbsptQU8jX8nfZNVpSO7DlIsz9jddlxsWGN7rWCIceZo98uRi
         hnqIVaOa2pqNg==
X-Nifty-SrcIP: [209.85.167.181]
Received: by mail-oi1-f181.google.com with SMTP id n124so3600083oih.7;
        Sat, 24 Sep 2022 11:06:35 -0700 (PDT)
X-Gm-Message-State: ACrzQf2s9B7sXQL2iP+YaXYt7BPBlJ/qu5paqJUX2XHhBymq7s/YfhWJ
        QWS/jpZ9CCLM9gf00LeJTKh3w0hGNUHHoH214eE=
X-Google-Smtp-Source: AMsMyM5C7PeWsxuWI4pCUFTQKEkOlybdhD/fZqkx7/gtDW87MSNKtMkuaJwplsZWYra/W+Kl7ygy4fb3uhY3CcEIxHY=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr6658522oie.287.1664042794103; Sat, 24
 Sep 2022 11:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
In-Reply-To: <20220906061313.1445810-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Sep 2022 03:05:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARqw8_M5VE6pJ-HpWchK5f5L-iN7MC6A+x6bZBRkTrE=A@mail.gmail.com>
Message-ID: <CAK7LNARqw8_M5VE6pJ-HpWchK5f5L-iN7MC6A+x6bZBRkTrE=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] kbuild: various cleanups
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 6, 2022 at 3:13 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
>  - Refactor single target build to make it work more correctly
>  - Link vmlinux and modules in parallel
>  - Remove head-y syntax
>
>
> Masahiro Yamada (8):
>   kbuild: fix and refactor single target build
>   kbuild: rename modules.order in sub-directories to .modules.order
>   kbuild: move core-y and drivers-y to ./Kbuild
>   kbuild: move .vmlinux.objs rule to Makefile.modpost
>   kbuild: move vmlinux.o rule to the top Makefile
>   kbuild: unify two modpost invocations
>   kbuild: use obj-y instead extra-y for objects placed at the head
>   kbuild: remove head-y syntax


Various bugs have been reported for v2.


I applied 1/8.
dropped 2/8.
will send v3 for the rest.





-- 
Best Regards
Masahiro Yamada
