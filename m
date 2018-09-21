Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41662 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeIUGcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Sep 2018 02:32:04 -0400
Received: by mail-yb1-f196.google.com with SMTP id v10-v6so4747538ybm.8
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 17:45:52 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id c10-v6sm6211691ywh.27.2018.09.20.17.45.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:45:49 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id j131-v6so4531059ywc.13
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 17:45:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 17:45:47 -0700
Message-ID: <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180921004547.V23sUMSJBstzA4o-xPVxltqyZWFjWpgxM9mccp_Y-5E@z>

On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>  config LSM_ORDER
>>       string "Default initialization order of builtin LSMs"
>> -     default "yama,loadpin,integrity"
>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>
> If I want to compile all the major modules into my kernel and use
> AppArmor by default would I use
>
>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>
> or
>
>         default "yama,loadpin,integrity,apparmor"

I was expecting the former, but the latter will have the same result.

> When we have "blob-sharing" how could I compile in tomoyo,
> but exclude it without a boot line option?

Ooh, yes, this series has no way to do that. Perhaps
CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
totally remove LoadPin's CONFIG for this in favor it.

> When we have full stacking, how could I compile in selinux
> but exclude it?

Yup, same problem. Same suggested solution?

Should lsm.enable/disable= also become a comma-separated list, or
should I leave it as a multi-instance thing like I have it?

-Kees

-- 
Kees Cook
Pixel Security
