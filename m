Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34317 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeJCDO4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 23:14:56 -0400
Received: by mail-yb1-f193.google.com with SMTP id 184-v6so1398736ybg.1
        for <linux-arch@vger.kernel.org>; Tue, 02 Oct 2018 13:29:48 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id k17-v6sm4464679ywk.47.2018.10.02.13.29.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 13:29:44 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id l79-v6so1341183ywc.7
        for <linux-arch@vger.kernel.org>; Tue, 02 Oct 2018 13:29:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <125243f2-8532-c0c0-0b0e-d28b3ecb910e@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <125243f2-8532-c0c0-0b0e-d28b3ecb910e@canonical.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 2 Oct 2018 13:29:42 -0700
Message-ID: <CAGXu5jLcK6k+Ox5Q1ZN_4wF9WeR6KchX9LJzbSbfdrcDpZftLg@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181002202942.eF0HOGgO6Vx3SXVXw5O59BGTPYf0gq261Nx1HKTCHQs@z>

On Tue, Oct 2, 2018 at 12:47 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/02/2018 12:17 PM, Kees Cook wrote:
>> I could define CONFIG_LSM_ENABLE as being "additive" to
>> SECURITY_APPARMOR_BOOTPARAM_VALUE and
>> SECURITY_SELINUX_BOOTPARAM_VALUE?
>
> Oh sure lets deal with my complaint about too many ways to configure
> this beast by adding yet another config option :P

This is what v3 already does: SEC...BOOTPARAM_VALUE trumps ...LSM_ENABLE.

> seriously though, please no. That just adds another layer of confusion
> even if it is only being foisted on the distro/builder

You've already sent a patch removing
SECURITY_APPARMOR_BOOTPARAM_VALUE. If SELinux is fine to do that too,
then I think we'll be sorted out. I'll just need to make "lsm.enable="
be an explicit list. (Do you have a problem with "lsm.disable=..." ?)

-Kees

-- 
Kees Cook
Pixel Security
