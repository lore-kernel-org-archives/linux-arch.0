Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33359 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbeI0Atn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Sep 2018 20:49:43 -0400
Received: by mail-yw1-f68.google.com with SMTP id x67-v6so11243842ywg.0
        for <linux-arch@vger.kernel.org>; Wed, 26 Sep 2018 11:35:27 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id j8-v6sm3318130ywj.6.2018.09.26.11.35.23
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:35:23 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id q129-v6so11218370ywg.8
        for <linux-arch@vger.kernel.org>; Wed, 26 Sep 2018 11:35:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926123522.4080d9eb@vmware.local.home>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <20180926123522.4080d9eb@vmware.local.home>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 26 Sep 2018 11:35:21 -0700
Message-ID: <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180926183521.uiJRn9C4d5fcgNkSesYkFyryI2yNZLt65OOyprwv5fI@z>

On Wed, Sep 26, 2018 at 9:35 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 24 Sep 2018 17:18:07 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> security and console initcall trace events") since security init calls
>> are about to no longer resemble regular init calls.
>
> I'm not against the change, but how much are they going to "no longer
> resemble regular init calls"?

My take on "regular" init calls is that they're always run, link-time
ordered, etc. The changes proposed here will make it so not all
initialization are run depending on runtime configurations, ordering
will be flexible, etc.

-Kees

-- 
Kees Cook
Pixel Security
