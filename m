Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46796 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeJBEgm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 00:36:42 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so1700860ywa.13
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 14:56:48 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id u22-v6sm10696251ywu.49.2018.10.01.14.56.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:56:44 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id y76-v6so6204901ywd.2
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 14:56:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1810020747380.20364@namei.org>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-15-keescook@chromium.org>
 <alpine.LRH.2.21.1810020747380.20364@namei.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 14:56:43 -0700
Message-ID: <CAGXu5jJKvb=3vu3_b-NNdr_=KwvgO9qa96Qo5qzSZuiy2=+Oig@mail.gmail.com>
Subject: Re: [PATCH security-next v3 14/29] LSM: Plumb visibility into
 optional "enabled" state
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181001215643.KZ7GxqjegQmyA3EcHHM5UG00MpAjoj-2840tcCndx54@z>

On Mon, Oct 1, 2018 at 2:47 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 24 Sep 2018, Kees Cook wrote:
>
>> In preparation for lifting the "is this LSM enabled?" logic out of the
>> individual LSMs, pass in any special enabled state tracking (as needed
>> for SELinux, AppArmor, and LoadPin). This should be an "int" to include
>> handling any future cases where "enabled" is exposed via sysctl which
>> has no "bool" type.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/linux/lsm_hooks.h | 1 +
>>  security/apparmor/lsm.c   | 5 +++--
>>  security/selinux/hooks.c  | 1 +
>>  3 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 5056f7374b3d..2a41e8e6f6e5 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>>  struct lsm_info {
>>       const char *name;       /* Populated automatically. */
>>       unsigned long flags;    /* Optional: flags describing LSM */
>> +     int *enabled;           /* Optional: NULL means enabled. */
>
> This seems potentially confusing.
>
> Perhaps initialize 'enabled' to a default int pointer, like:
>
>         static int lsm_default_enabled = 1;
>
> Then,
>
>         DEFINE_LSM(foobar)
>         flags = LSM_FLAG_LEGACY_MAJOR,
>         .enabled = &lsm_default_enabled,
>         .init = foobar_init,
>         END_LSM;

The reason I didn't do this is because there are only two LSMs that
expose this "enabled" variable, so I didn't like making the other LSMs
have to declare this. Internally, though, this is exactly what the
infrastructure does: if it finds a NULL, it aims it at
&lsm_default_enabled (in a later patch).

However, it seems more discussion is needed on the "enable" bit of
this, so I'll reply to John in a moment...

-Kees

-- 
Kees Cook
Pixel Security
