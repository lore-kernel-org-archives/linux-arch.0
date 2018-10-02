Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46667 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeJBLa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 07:30:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id j202-v6so255796ywa.13
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 21:49:41 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id e82-v6sm14022145ywa.60.2018.10.01.21.49.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 21:49:39 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id j202-v6so255764ywa.13
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 21:49:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-22-keescook@chromium.org>
 <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 21:49:37 -0700
Message-ID: <CAGXu5j+ND4K5GvxJ1ieLr5E=Zsfb6mGQL8yTegOXv4V4qmuZUA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 21/32] LSM: Finalize centralized LSM
 enabling logic
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181002044937.d_7yG4llSWq0duSynsQ7VuDE_xN1tecrhIClhkhMc0I@z>

On Mon, Oct 1, 2018 at 6:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/1/18 5:54 PM, Kees Cook wrote:
>> Prior to this patch, default "enable" behavior was unchanged: SELinux
>> and AppArmor were controlled separately from the centralized control
>> defined by CONFIG_LSM_ENABLE and "lsm.enable=...". This changes the
>> logic to give all control over to the central logic.
>>
>> Instead of allowing SELinux and AppArmor to override the central LSM
>> enabling logic, by having separate CONFIG and boot parameters, this
>> forces all "enable" variables to disabled, then enables any listed in
>> the CONFIG_LSM_ENABLE and "lsm.enable=..." settings, and finally disables
>> any listed in "lsm.disable=...".
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  6 ++--
>>  include/linux/lsm_hooks.h                     |  2 +-
>>  security/security.c                           | 32 +++++++------------
>>  3 files changed, 15 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 67c90985d2b8..f646cfab5613 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2279,14 +2279,12 @@
>>       lsm.disable=lsm1,...,lsmN
>>                       [SECURITY] Comma-separated list of LSMs to disable
>>                       at boot time. This overrides "lsm.enable=",
>
> better:                               This overrides "lsm.enable=" and

Eek, yes! Thank you. :)

-Kees

>
>> -                     CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
>> -                     parameters.
>> +                     CONFIG_LSM_ENABLE.
>>
>>       lsm.enable=lsm1,...,lsmN
>>                       [SECURITY] Comma-separated list of LSMs to enable
>>                       at boot time. This overrides any omissions from
>> -                     CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
>> -                     boot parameters.
>> +                     CONFIG_LSM_ENABLE.
>>
>>       machvec=        [IA-64] Force the use of a particular machine-vector
>>                       (machvec) in a generic kernel.
>
>
> --
> ~Randy



-- 
Kees Cook
Pixel Security
