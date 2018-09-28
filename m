Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44508 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeI2DUH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 23:20:07 -0400
Received: by mail-yb1-f193.google.com with SMTP id x5-v6so3222658ybl.11
        for <linux-arch@vger.kernel.org>; Fri, 28 Sep 2018 13:54:37 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id a204-v6sm2238459ywa.43.2018.09.28.13.54.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:54:34 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id j131-v6so3179766ywc.13
        for <linux-arch@vger.kernel.org>; Fri, 28 Sep 2018 13:54:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <145fab48-969f-0aed-74e8-ac0a5bb1c79b@tycho.nsa.gov>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
 <cb49b4c4-a379-7a8e-41a6-6e6a4afb6fe5@tycho.nsa.gov> <145fab48-969f-0aed-74e8-ac0a5bb1c79b@tycho.nsa.gov>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 28 Sep 2018 13:54:33 -0700
Message-ID: <CAGXu5jKX9VCFqRrchr55_977kOA=1WzdB+YcEZq0y5CPcsp7Zw@mail.gmail.com>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180928205433.lucYcorcmNCSqb9ks0Pf0bW-aq1R1J4JK_FZmmI0x30@z>

On Fri, Sep 28, 2018 at 1:33 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/28/2018 04:25 PM, Stephen Smalley wrote:
>>
>> On 09/28/2018 04:01 PM, Kees Cook wrote:
>>>
>>> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com>
>>> wrote:
>>>>
>>>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>>>>
>>>>> v3:
>>>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>>>
>>>>
>>>> Kees, you can add my
>>>>
>>>>          Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>>>
>>>> for this entire patch set. Thank you for taking this on, it's
>>>> a significant and important chunk of the LSM infrastructure
>>>> update.
>>>
>>>
>>> Thanks!
>>>
>>> John, you'd looked at this a bit too -- do the results line up with
>>> your expectations?
>>>
>>> Any thoughts from SELinux, TOMOYO, or IMA folks?
>>
>>
>> What's it relative to?  First patch fails for me on current security/next.
>
> Never mind - user error ;)

FWIW, it's against v4.19-rc2.

>> Is there a branch in your repo that has the v3 patches?
>
> But still wondered about this one.

Oops! Sorry, I didn't push to kernel.org. Now pushed!

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v3

(and "preview" v4 also with Reviewed-bys added and a cosmetic fix.)

-Kees

-- 
Kees Cook
Pixel Security
