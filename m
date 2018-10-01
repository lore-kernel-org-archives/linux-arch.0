Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46273 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJAHgt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 03:36:49 -0400
Received: by mail-yw1-f67.google.com with SMTP id j202-v6so358509ywa.13
        for <linux-arch@vger.kernel.org>; Sun, 30 Sep 2018 18:01:35 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id i184-v6sm4640787ywg.97.2018.09.30.18.01.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 18:01:31 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id k66-v6so4832681ywa.10
        for <linux-arch@vger.kernel.org>; Sun, 30 Sep 2018 18:01:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180930192526.4480231c@vmware.local.home>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <20180926123522.4080d9eb@vmware.local.home> <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
 <20180930192526.4480231c@vmware.local.home>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 30 Sep 2018 18:01:29 -0700
Message-ID: <CAGXu5jJsVv9bMh831yx1y8KjhgA204hkpOEVpWzvifATw-w0cw@mail.gmail.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181001010129.77SDtGAMtCM-qVz4bm7dtSVKI-dwPUjomBfBVuCVcFs@z>

On Sun, Sep 30, 2018 at 4:25 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 26 Sep 2018 11:35:21 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> On Wed, Sep 26, 2018 at 9:35 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Mon, 24 Sep 2018 17:18:07 -0700
>> > Kees Cook <keescook@chromium.org> wrote:
>> >
>> >> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> >> security and console initcall trace events") since security init calls
>> >> are about to no longer resemble regular init calls.
>> >
>> > I'm not against the change, but how much are they going to "no longer
>> > resemble regular init calls"?
>>
>> My take on "regular" init calls is that they're always run, link-time
>> ordered, etc. The changes proposed here will make it so not all
>> initialization are run depending on runtime configurations, ordering
>> will be flexible, etc.
>>
>
> Will it still be a good idea to have a tracepoint for those calls?
> Perhaps not an  initcall tracepoint but some other kind?

I'm not opposed. It could be a follow-up patch, I assume?

-Kees

-- 
Kees Cook
Pixel Security
