Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38445 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeJCG67 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Oct 2018 02:58:59 -0400
Received: by mail-yb1-f196.google.com with SMTP id e190-v6so1629826ybb.5
        for <linux-arch@vger.kernel.org>; Tue, 02 Oct 2018 17:13:03 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id x64-v6sm5624592ywx.103.2018.10.02.17.12.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id v1-v6so1572605ywv.6
        for <linux-arch@vger.kernel.org>; Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3b539d37-136f-b868-3155-f2982eb63890@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <3b539d37-136f-b868-3155-f2982eb63890@canonical.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 2 Oct 2018 17:12:58 -0700
Message-ID: <CAGXu5jJ-2V5ch-Qer_O0mg1J5-9SUmyJXsGYicZEMyg5KkqHaw@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: James Morris <jmorris@namei.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181003001258.__ajPrBEJAlmkd4CnmjddIF0os8QoddqeQprm51Hzm8@z>

On Tue, Oct 2, 2018 at 5:05 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/02/2018 04:54 PM, Kees Cook wrote:
>> That's not how I have it currently. It's a comma-separated a string,
>> including the reserved name "all". The default would just be
>> "CONFIG_LSM_ENABLE=all". Casey and I wanted this to have a way to
>> capture new LSMs by default at build-time.
>>
>
> I understand where you are coming from, but speaking with my distro
> hat on, that is not going to work. As a distro Ubuntu very much wants
> to be able to offer all the LSMs built in to the kernel so the user
> can select them. But very much wants to be able to specify a default
> supported subset that is enabled at boot.
>
> I expect RH and Suse will feel similarily. Speaking for Ubuntu if this
> isn't available as part of lsm stacking it will get distro patched in.

Right. Ubuntu would do something like:

CONFIG_LSM_ENABLE=yama,apparmor,integrity

And that's why I wanted non-explicit lsm.enable, so that an end user
could just do:

lsm.enable=loadpin

to add loadpin.

Perhaps we could have both? "lsm.enable=+loadpin" (add loadpin to
build default list) vs "lsm.enable=loadpin" (override build default
list with ONLY loadpin).

-Kees

-- 
Kees Cook
Pixel Security
