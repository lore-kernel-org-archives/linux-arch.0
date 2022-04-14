Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838CFC433EF
	for <linux-arch@archiver.kernel.org>; Thu, 14 Apr 2022 21:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiDNVYG (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 14 Apr 2022 17:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbiDNVYG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 17:24:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B9EDE0AB
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 14:21:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so11309501lfb.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0sPK0ChjNw7tXzEe9rotzqgy1YIdVEAmTT9OqaXLkVE=;
        b=axOCTDJF734bIOMqNm9SbSBcIUhzVwGinksnc9wP2smqTP9J1j70Sr3k8TShJmOIy2
         4bVSSPj+MpOnT1++/cnUDrAlzKSREogJ0get6nwX/FHyg2cI4Lsl4/pLkEcNvZgRh1T6
         8CF7jAfypEUqEvLcF46XYjRu23PaG33i5GqXEGLVCUfSbdw6FSL+IEf9F0kgg9O1bc1D
         cXQ4QaA8J1Vfl3IxmIpkcDC1JuMYHl30IAccsc8E0fxPVn7qVENiTUagLOEJznxiOV9H
         sc103ZeWWazvWwKFfZfeLlYIltnp2fISiSaPu57hDR9SCgmYnvSwGoMBOyGF6kRz7F0X
         BjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0sPK0ChjNw7tXzEe9rotzqgy1YIdVEAmTT9OqaXLkVE=;
        b=SMtm5+enLXtwD9bjuN64zwrxbY/VuiFTIYlUL0IepV0fUaU0hJMCJLRD7JFq64Jge8
         PwEIv4hli2f5rUQApNRW1/p91i/EsZamSfHzxnz4Re+dnDFUziljbOcKw/1q2wqvyYl6
         ktWSO9FIisTkyzgAradOGUtJz3CFgpD6Qvf0Njtn3SYfYpS0wC/HrX2sj47NlzsekypQ
         4uSq84AxDDhbmXMrdYEDGH3PbMJRDJNkhfy//dLdMB/9P09ioH1q3UQi9c2WpI3Tx6bV
         n4XttggDYy6oyzb7aLnkkGZuLErOxHGescCt7U+cgblpsfmzbnbr9hyDQ45wDL/d1+UZ
         56Sw==
X-Gm-Message-State: AOAM532M4UbQjE26eAlykaMOLjm8QrbsNv5XkRfcA3wm9VXpm+Xrb59X
        uGulYZigvHHuRzgYgijcm7daAX059WtdwrF63LJlAg==
X-Google-Smtp-Source: ABdhPJzGCq5I2pdT/WfEaOqf+NEUjGEo2tp5xmUox0iKDOOpzdH8W3rdPksokfYD/0rNSBZ1HO2C4INST3ITCcpac8s=
X-Received: by 2002:a05:6512:3d8f:b0:46d:152b:5952 with SMTP id
 k15-20020a0565123d8f00b0046d152b5952mr2783659lfv.579.1649971297139; Thu, 14
 Apr 2022 14:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local>
In-Reply-To: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Apr 2022 14:21:25 -0700
Message-ID: <CAKwvOdkEULT_OOeaaCneJjbrE=O3kC8SMDs2thFa9gBfpuo2Jg@mail.gmail.com>
Subject: Re: Dangerous addr to ctrl dependency transformation in fs/nfs/delegation.c::nfs_server_return_marked_delegations()?
To:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 7, 2022 at 8:22 AM Paul Heidekr=C3=BCger
<paul.heidekrueger@in.tum.de> wrote:
>
> Hi all,
>
> work on my dependency checker tool is progressing nicely, and it is
> flagging, what I believe is, a harmful addr to ctrl dependency
> transformation. For context, see [1] and [2]. I'm using the Clang
> compiler.
> [1]: https://linuxplumbersconf.org/event/7/contributions/821/attachments/=
598/1075/LPC_2020_--_Dependency_ordering.pdf
> [2]: https://lore.kernel.org/llvm/YXknxGFjvaB46d%2Fp@Pauls-MacBook-Pro/T/=
#u

Hi Paul,
Thanks for the report and your (and your team's) work on this tool.
Orthogonal to your report, Jose (cc'ed) and I are currently in the
planning process to put together a Kernel+Toolchain microconference
track at Linux Plumbers Conference [0] this year (Sept 12-14) in
Dublin, Ireland.  Would you or someone from your group be able and
interested in presenting more information about your work to an
audience of kernel and toolchain developers at such an event?

Would others be interested in such a topic? (What do they say in
Starship Troopers...?...Would you like to know more?)

[0] https://lpc.events/event/16/
--=20
Thanks,
~Nick Desaulniers
