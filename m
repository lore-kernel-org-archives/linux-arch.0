Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:41595
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbeKOHJn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Nov 2018 02:09:43 -0500
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
 <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
 <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
 <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com>
 <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
 <63410d08-d0d1-8cd9-5d9e-70d95a1a8ca0@schaufler-ca.com>
 <33754ab5-5c7a-b174-0ad6-195323a169f1@schaufler-ca.com>
 <CAGXu5jLyn6mLKFK+RuBkYWenm8sXXR+yqJ3VzVCpUqOVmru_XA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1df16f7f-aabb-9581-d41d-25d0582cdd06@schaufler-ca.com>
Date: Wed, 14 Nov 2018 13:04:50 -0800
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLyn6mLKFK+RuBkYWenm8sXXR+yqJ3VzVCpUqOVmru_XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: John Johansen <john.johansen@canonical.com>, Jordan Glover <Golden_Miller83@protonmail.ch>, James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On 10/24/2018 1:12 PM, Kees Cook wrote:
> On Wed, Oct 24, 2018 at 1:56 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/23/2018 12:05 PM, Casey Schaufler wrote:
>>> On 10/23/2018 11:50 AM, Kees Cook wrote:
>>>
>>>> Did you poke around at my combined series?
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing
>>> I hope to do that on the plane later today.
>> I had a chance to poke at the combined series and it
>> all seems to work as advertised.
> /me stares at John, Paul, and Stephen. Hurry up and get off your planes! ;)
>
> -Kees
>
Now that we have next-general updated I'm porting these forward.
