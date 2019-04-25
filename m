Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f48.google.com ([209.85.167.48]:35181 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfDYQVV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 12:21:21 -0400
Received: by mail-lf1-f48.google.com with SMTP id j20so239539lfh.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Apr 2019 09:21:19 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v4sm4764908ljv.4.2019.04.25.09.21.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:21:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id j20so239460lfh.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Apr 2019 09:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <1556181403-3881-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1556181403-3881-1-git-send-email-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2019 09:21:01 -0700
Message-ID: <CAHk-=wh8NTGSOerqZNhefEn=AX5kgx27tD+kv=UpOB8u-FeYTA@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixes for v5.1-rc7
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190425162101.4Zl7OVI21mNOeXAzVadn2Pses3V-T327VyfsDr9sWaU@z>

On Thu, Apr 25, 2019 at 1:36 AM <guoren@kernel.org> wrote:
>
> Here are the patches which made on 5.1-rc6 and all are tested in our
> buildroot gitlab CI:

This really looks like it should come in the next merge window, not during rc7.

You had absolutely zero csky updates during the merge window, you
can't then magically come up with "look, here's 1300 lines of fixes"
during the late rc series.

Re-send when the merge window opens.

                   Linus
