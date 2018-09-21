Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35901 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeIUG0P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Sep 2018 02:26:15 -0400
Received: by mail-yb1-f194.google.com with SMTP id 5-v6so4746400ybf.3
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 17:40:04 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 189-v6sm3862955ywf.4.2018.09.20.17.40.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:40:02 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id q129-v6so4537861ywg.8
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 17:40:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <71f833b8-40cb-83f8-6803-7df26e8fa460@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-21-keescook@chromium.org>
 <71f833b8-40cb-83f8-6803-7df26e8fa460@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 17:40:01 -0700
Message-ID: <CAGXu5jLn_=pOTcnAo3m2h5i8yEhwf29qSqbv6N9LPcqdUntKQw@mail.gmail.com>
Subject: Re: [PATCH security-next v2 20/26] LSM: Introduce "lsm.order=" for
 boottime ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180921004001.ICjs4XBMG1-_mEdDKYf0PjYmDwbLNMmA_Pun5W9iDGw@z>

On Thu, Sep 20, 2018 at 5:12 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>> Provide a way to reorder LSM initialization using the new "lsm.order="
>> comma-separated list of LSMs. Any LSMs not listed will be added in builtin
>> order.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>>  security/security.c                             | 15 ++++++++++++++-
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 32d323ee9218..5ac4c1056ffa 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2276,6 +2276,11 @@
>>
>>       lsm.debug       [SECURITY] Enable LSM initialization debugging output.
>>
>> +     lsm.order=lsm1,...,lsmN
>> +                     [SECURITY] Choose order of LSM initialization. Any
>> +                     builtin LSMs not listed here will be implicitly
>> +                     added to the list in builtin order.
>
> Added at the end of the list, or beginning of the list?

Whoops, I had an earlier version that was more clear. I meant to say
"appended" instead of "added" here. Fixed for the next version.

-Kees

-- 
Kees Cook
Pixel Security
