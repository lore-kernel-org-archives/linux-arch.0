Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38013 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeIUDlb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 23:41:31 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so4600519ybb.5
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 14:55:56 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id p78-v6sm15598838ywp.31.2018.09.20.14.55.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 14:55:53 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id b3-v6so3548255yba.4
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 14:55:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1898403.NNy4ELVaME@merkaba>
References: <20180920162338.21060-1-keescook@chromium.org> <1898403.NNy4ELVaME@merkaba>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 14:55:52 -0700
Message-ID: <CAGXu5jJfp2ezmODaQgj_gROdpr=_Dc4_h=ujPeR-ggTZ8AUciQ@mail.gmail.com>
Subject: Re: [PATCH security-next v2 00/26] LSM: Explict LSM ordering
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180920215552.iF-B8n877xzC9YjAEen-qCzV9eNTFl-kQMqt7cG3ILY@z>

On Thu, Sep 20, 2018 at 1:14 PM, Martin Steigerwald <martin@lichtvoll.de> w=
rote:
> Kees Cook - 20.09.18, 18:23:
>> v2:
>> - add "lsm.order=3D" and CONFIG_LSM_ORDER instead of overloading
>> "security=3D" - reorganize introduction of ordering logic code
>>
>> Updated cover letter:
>>
>> This refactors the LSM registration and initialization infrastructure
>> to more centrally support different LSM types. What was considered a
>> "major" LSM is kept for legacy use of the "security=3D" boot parameter,
>> and now overlaps with the new class of "exclusive" LSMs for the future
>> blob sharing (to be added later). The "minor" LSMs become more well
>> defined as a result of the refactoring.
>>
>> Instead of continuing to (somewhat improperly) overload the kernel's
>> initcall system, this changes the LSM infrastructure to store a
>> registration structure (struct lsm_info) table instead, where metadata
>> about each LSM can be recorded (name, flags, order, enable flag, init
>> function). This can be extended in the future to include things like
>> required blob size for the coming "blob sharing" LSMs.
>
> I read the cover letter and still don=C2=B4t know what this is about. Now=
 I
> am certainly not engaged deeply with LSM. I bet my main missing piece
> is: What is a "blob sharing" LSM.
>
> I think it would improve the cover letter greatly if it explains briefly
> what is a major LSM, what is a minor LSM and what is a "blob sharing"
> LSM.
>
> Why those are all needed? What is the actual security or end user
> benefit of this work? The questions are not to question your work. I bet
> it makes all perfect sense. I just did not understand its sense from
> reading the cover letter.

Sure, thanks! I'll include more details for any later versions. This
is mainly related to some internal refactoring the LSM is doing to
support additional LSM that need more extensive "stacking" of the
kernel internals. I aimed this at linux-doc@ and linux-arch@ to get
feedback on the Documentation/ and linker script changes,
respectively. In theory, users don't need to know anything about
minor/major nor blob-sharing, as that should normally be all an
internal issue.

Thanks!

-Kees

--=20
Kees Cook
Pixel Security
