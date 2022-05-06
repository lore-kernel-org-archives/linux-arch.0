Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C8C433FE
	for <linux-arch@archiver.kernel.org>; Fri,  6 May 2022 18:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbiEFSkx (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 6 May 2022 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348466AbiEFSku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 14:40:50 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD37342EDA
        for <linux-arch@vger.kernel.org>; Fri,  6 May 2022 11:37:06 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso90554527b3.9
        for <linux-arch@vger.kernel.org>; Fri, 06 May 2022 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=T5FzwlnwwLPSlsTULB5vVS6qck4pbK33IxK3PwxxGYs=;
        b=OaUVMZ5X4l4KHj/xv5EuDo+yQtXj+Sc1MEWQYWVggQCaUUL2aFUlAHP3rgHICEaO1d
         WKDbBxPKIH6mfVsOyvAiYyUOXZ3t0S9Q94PsVNkZRN4qKAiYccP2FuNGlMRs0NgWsq69
         boJaFzU6odZp697y+JEY8TMWRo6cXl2B9gRDyfflmCeprnmrzulA4TlpEljUAWQy4Bkh
         0C2ZY1X4E8A1FdiTDalb87WZ6CgKeDrvNcYetGX0W40mRDu7uFbpErkIRr2mdAlSN3/I
         IdykCIwrPh7qSt5m9aLfTskJjq29B0O8yGxIGKQ6kiu+J1s/HMrCS3dtdbx4gZFRzV2r
         GJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=T5FzwlnwwLPSlsTULB5vVS6qck4pbK33IxK3PwxxGYs=;
        b=OCQSn+p9qMiHHiUlTUAu9GZ6HdYXWi9dVFsnl6LoCsc5PpCIByM+/cT8+dFt/ayzZB
         oSs6l4HozzDBcieQdbm+OpLuquj4oQU6R5Cfy9EHHzbdJZyYmF+fRXQnFPbjX7D9CZ3p
         Bm+u4vFHxpu2xPhUHZoCmDJZdAtai56bbZFV/6E9mSuDY9BuQGoVLWEYB9S49nYsoanE
         Bn9NHyrJOTvR9Rego7wQVQ63xJfIyxInAZCjLT73aRZFzvJSax46cp5pPtOJD5ehGiC1
         JbkGA+2Tj5wJ6WBCRqwPC1iyntZC41fkw8ZzN+7j+uTZvwLroK7BTK3kfgemxNU3HvZo
         udKw==
X-Gm-Message-State: AOAM533EIJ1szax2z6GfNvMGHCWpiKaFIt8iB8cEygQlj++De9k6n1aq
        Lu3NQxrRywJ9J+ZJ9odEWbvCIWDyVHbhS24FgwFhvRl5
X-Google-Smtp-Source: ABdhPJytmE/rQHS7ImoPJgIFX8PkZOaBw45LiakhfaaT6NEwYcbKoIq8PQZJcIyEokdW9AZi4KkoIHFnaRizgWhxlrU=
X-Received: by 2002:a81:b07:0:b0:2f4:da11:f0f0 with SMTP id
 7-20020a810b07000000b002f4da11f0f0mr3930965ywl.336.1651862226069; Fri, 06 May
 2022 11:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:b410:0:0:0:0 with HTTP; Fri, 6 May 2022 11:37:05
 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
From:   Warren Buffett <kosolnakemedou@gmail.com>
Date:   Fri, 6 May 2022 18:37:05 +0000
Message-ID: <CAJWF6CD2MB_mWmpBHW0+XjLoYPE-sxtBLqoYXU6upTv05_Li8Q@mail.gmail.com>
Subject: Linux-Arch
To:     linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you

Thanks
Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
