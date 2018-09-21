Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41336 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388718AbeIUGXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Sep 2018 02:23:33 -0400
Received: by mail-yb1-f194.google.com with SMTP id v10-v6so4740791ybm.8
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 17:37:22 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id u197-v6sm3623653ywu.33.2018.09.20.17.37.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:37:19 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id b2-v6so383275ywe.11
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 17:37:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-19-keescook@chromium.org>
 <d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 17:37:18 -0700
Message-ID: <CAGXu5jJRHN6hMwk49Ss8knSX4CJa0UkWe0pPMHbnFGwECjo_rw@mail.gmail.com>
Subject: Re: [PATCH security-next v2 18/26] LSM: Build ordered list of ordered
 LSMs for init
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180921003718.uN-R2Kxv9_7EZj0LnlGlD0grpHvFAke6dNzo7Rs_BmM@z>

On Thu, Sep 20, 2018 at 5:04 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>> This constructs a list of ordered LSMs to initialize, using a hard-coded
>> list of only "integrity": minor LSMs continue to have direct hook calls,
>> and major LSMs continue to initialize separately.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Do you think that this mechanism will be sufficiently
> flexible to accommodate dynamically loaded security modules
> in the future? While I am not personally an advocate of
> dynamically loaded security modules I have been working to
> ensure that I haven't done anything that would actively
> interfere with someone who did.

I don't think it does, no. This is all just the boot time
initialization order, so a dynamic LSM would be unchanged: it would
initialize at module load time. :)

-Kees

-- 
Kees Cook
Pixel Security
