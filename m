Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40281 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJYElt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2018 00:41:49 -0400
Received: by mail-yb1-f193.google.com with SMTP id g9-v6so2691573ybh.7
        for <linux-arch@vger.kernel.org>; Wed, 24 Oct 2018 13:12:20 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id l30-v6sm5957615ywa.104.2018.10.24.13.12.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:12:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id p144-v6so2677050yba.11
        for <linux-arch@vger.kernel.org>; Wed, 24 Oct 2018 13:12:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33754ab5-5c7a-b174-0ad6-195323a169f1@schaufler-ca.com>
References: <20181011001846.30964-1-keescook@chromium.org> <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com> <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com> <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com> <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
 <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com> <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
 <63410d08-d0d1-8cd9-5d9e-70d95a1a8ca0@schaufler-ca.com> <33754ab5-5c7a-b174-0ad6-195323a169f1@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 24 Oct 2018 13:12:15 -0700
Message-ID: <CAGXu5jLyn6mLKFK+RuBkYWenm8sXXR+yqJ3VzVCpUqOVmru_XA@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>, Jordan Glover <Golden_Miller83@protonmail.ch>, James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Wed, Oct 24, 2018 at 1:56 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/23/2018 12:05 PM, Casey Schaufler wrote:
>> On 10/23/2018 11:50 AM, Kees Cook wrote:
>>
>>> Did you poke around at my combined series?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing
>> I hope to do that on the plane later today.
>
> I had a chance to poke at the combined series and it
> all seems to work as advertised.

/me stares at John, Paul, and Stephen. Hurry up and get off your planes! ;)

-Kees

-- 
Kees Cook
