Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46861 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeJMCfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 22:35:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id j202-v6so5329095ywa.13
        for <linux-arch@vger.kernel.org>; Fri, 12 Oct 2018 12:01:22 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id k17-v6sm481415ywk.47.2018.10.12.12.01.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 12:01:19 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id e190-v6so5305188ybb.5
        for <linux-arch@vger.kernel.org>; Fri, 12 Oct 2018 12:01:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
References: <20181011001846.30964-1-keescook@chromium.org> <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com> <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com> <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 12 Oct 2018 12:01:17 -0700
Message-ID: <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181012190117.YhBdqeTpJ0dwVwhYHwyKgG6C7DMikRmrQVvNqG8XzIE@z>

On Friday, October 12, 2018 3:19 AM, John Johansen
<john.johansen@canonical.com> wrote:
> It isn't perfect but it manages consistency across distros as best as
> can be achieved atm.

Yeah, this is why I'm okay with the current series: it provides as
consistent a view as possible, but leaves room for future improvements
(like adding "+" or "!" or "all" or whatever).

I'm curious to see what SELinux folks think of v5, though. I *think* I
addressed all the concerns there, even Paul's "I want my distro
default to not have extreme stacking" case too.

-Kees

-- 
Kees Cook
Pixel Security
