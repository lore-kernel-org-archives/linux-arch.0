Return-Path: <SRS0=jFrJ=EB=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFAFC388F9
	for <linux-arch@archiver.kernel.org>; Mon, 26 Oct 2020 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28E421D7B
	for <linux-arch@archiver.kernel.org>; Mon, 26 Oct 2020 18:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603738664;
	bh=HDMxNqXV2tOMDZjzcG6QUkrBNBP/sxNjWiOD2NAdQDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TcAQzaH0GbMzpLD43/lokIzytFb1ldLMC7/f3YkzMEeU55KUUlieMsNfG70vqq35i
	 2qLWZveauV3OuSXzEVje6OZKyHr9P5pcXj+Skx/Oz0LMGuPhAUKotocGq1MVMq1Qcc
	 ByBxAlE0fHGS46IRIzvLCsPIoycQrZ8uKpWItfAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791025AbgJZS5k (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783600AbgJZS5i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 14:57:38 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C03206FB;
        Mon, 26 Oct 2020 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603738658;
        bh=HDMxNqXV2tOMDZjzcG6QUkrBNBP/sxNjWiOD2NAdQDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qPP2SbXse0fa9bjFNmtKPf8WoAv/h2xLjjarMQWZJjWqxE+B3JBsjrTTIvZzJyvfw
         iPFRgZf5928m7aHR8xE+2fzUHlK6h2zV0LoADVTEZAFV2Tgtuqt/PnRfHUda8TH43Z
         kV01A/q1NGTHjaWHFKriJgyYzJztx7ThLiFFKu4o=
Received: by mail-qt1-f180.google.com with SMTP id q26so7524596qtb.5;
        Mon, 26 Oct 2020 11:57:38 -0700 (PDT)
X-Gm-Message-State: AOAM531Pn2Qxm8q2CLtep24A+sr5TgW6t+j1pj7xIsmqWD6kz1aiQUIG
        KV6y/TWW5//XsbLXS9NAN7GJCmzoTTr81Th8HNc=
X-Google-Smtp-Source: ABdhPJx90Sz24rcwPhXyZqNyGjAUjS7Yow5wlplhOU7STlAfF0M8lJ415u3JmOH8ud1l5eAZio4kFzVysOq4RxCyCSY=
X-Received: by 2002:ac8:7955:: with SMTP id r21mr7905290qtt.204.1603738657776;
 Mon, 26 Oct 2020 11:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160006.3704027-1-arnd@kernel.org> <086e45b325074fc89f51354901aa5af6@AcuMS.aculab.com>
In-Reply-To: <086e45b325074fc89f51354901aa5af6@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 19:57:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a37j8v5jWYP1dYkFrie1xgNK-p8St=wOQyEWLhcc8G6Xg@mail.gmail.com>
Message-ID: <CAK8P3a37j8v5jWYP1dYkFrie1xgNK-p8St=wOQyEWLhcc8G6Xg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: fix ffs -Wshadow warning
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 26, 2020 at 5:44 PM David Laight <David.Laight@aculab.com> wrote:
>
> An alternative would be to add #define ffs(x) our_inline_ffs(x)
> before the inline function definition.

Yes, that would also work.

> I though the idea of the __builtin_ prefix was that you could
> have a function with the same name :-(

It does multiple things, but one of the things it does is that
the ffs() falls back to the libc-provided ffs() function. You can
define a global ffs() like the libc implementation does, but
defining your own means that it will be used in place of
the official one, which is what the warning is for.

       Arnd
