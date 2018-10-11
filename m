Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37272 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJKWmF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2018 18:42:05 -0400
Received: by mail-yw1-f68.google.com with SMTP id y14-v6so3722346ywa.4
        for <linux-arch@vger.kernel.org>; Thu, 11 Oct 2018 08:14:29 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id r5-v6sm18018146ywr.80.2018.10.11.08.14.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 08:14:26 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id m129-v6so3728717ywc.1
        for <linux-arch@vger.kernel.org>; Thu, 11 Oct 2018 08:14:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1810111443500.25845@namei.org>
References: <20181011001846.30964-1-keescook@chromium.org> <alpine.LRH.2.21.1810111443500.25845@namei.org>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 11 Oct 2018 08:14:24 -0700
Message-ID: <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181011151424.BeaORWZtAcG4p6FD2CAffzHvLkdGxpwks5nDKiMdi0I@z>

On Wed, Oct 10, 2018 at 8:45 PM, James Morris <jmorris@namei.org> wrote:
> On Wed, 10 Oct 2018, Kees Cook wrote:
>
>> v5:
>> - redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
>> - dropped various Reviewed-bys due to rather large refactoring
>
> Patches 1-10 applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> and next-testing.

Very cool; thanks!

As for the rest, I could post some examples of how the new CONFIG_LSM
and "lsm=..." work (and how they mix with the "legacy" options). Would
that be helpful?

-Kees

-- 
Kees Cook
Pixel Security
