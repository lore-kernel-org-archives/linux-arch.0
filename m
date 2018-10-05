Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43786 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJEHBN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Oct 2018 03:01:13 -0400
Received: by mail-yw1-f68.google.com with SMTP id j75-v6so4548815ywj.10
        for <linux-arch@vger.kernel.org>; Thu, 04 Oct 2018 17:05:14 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 138-v6sm3081936ywj.11.2018.10.04.17.05.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 17:05:12 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id q129-v6so4544804ywg.8
        for <linux-arch@vger.kernel.org>; Thu, 04 Oct 2018 17:05:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1810050338470.14095@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <alpine.LRH.2.21.1810050338470.14095@namei.org>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 4 Oct 2018 17:05:09 -0700
Message-ID: <CAGXu5j+3HqqBa_ogQqGJYubeZr9uCrbKzEoKO3Or=71e4c_=Gw@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181005000509.OJ9_N8iepkp2D0NlqThacen8yqyPA0tIksQ3gf-7ig4@z>

On Thu, Oct 4, 2018 at 10:49 AM, James Morris <jmorris@namei.org> wrote:
> On Wed, 3 Oct 2018, Kees Cook wrote:
>> Then someone boots the system with:
>>
>> selinux=1 security=selinux
>>
>> In what order does selinux get initialized relative to yama?
>> (apparmor, flagged as a "legacy major", would have been disabled by
>> the "security=" not matching it.)
>
> It doesn't, it needs to be specified in one place.
>
> Distros will need to update boot parameter handling for this kernel
> onwards.  Otherwise, we will need to carry this confusing mess forward
> forever.

Are you saying that you want to overrule Paul and Stephen about
keeping "selinux=1 secuiryt=selinux" working?

>> CONFIG_LSM="yama,apparmor,!selinux"
>>
>> to mean "put selinux here in the order, but don't enable it". Then the
>> problem becomes what happens to an LSM that has been built in but not
>> listed in CONFIG_LSM?
>
> In my most recent suggestion, there is no '!' disablement, just
> enablement.  If an LSM is not listed in CONFIG_LSM="", it's not enabled.

And a user would need to specify ALL lsms on the "lsm=" line?

What do you think of my latest proposal? It could happily work all
three ways: old boot params and security= work ("selinux=1
security=selinux" keeps working), individual LSM enable/disable works
("lsm=+loadpin"), and full LSM ordering works
("lsm=each,lsm,in,order,here"):

https://lore.kernel.org/lkml/CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com/

-Kees

-- 
Kees Cook
Pixel Security
