Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44087 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJBFTD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 01:19:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id s73-v6so6213456ywg.11
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 15:39:00 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id m3-v6sm5451728ywe.50.2018.10.01.15.38.56
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:38:57 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id q129-v6so6218821ywg.8
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 15:38:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001172315.225d18dc@gandalf.local.home>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com> <20181001172315.225d18dc@gandalf.local.home>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 15:38:55 -0700
Message-ID: <CAGXu5jJbO7c0Hiw8_9hhkbo74c-56g5ppW8g1ynyPt-WsLaxRw@mail.gmail.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181001223855.V0Ych5ZBYXg9jFwmzeqEEhrB5tXsLl7S4q14JuM_a6A@z>

On Mon, Oct 1, 2018 at 2:23 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 1 Oct 2018 14:07:55 -0700
> John Johansen <john.johansen@canonical.com> wrote:
>
>> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> > This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> > security and console initcall trace events") since security init calls
>> > are about to no longer resemble regular init calls.
>> >
>> > Cc: James Morris <jmorris@namei.org>
>> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> > Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
>> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> > Cc: linux-security-module@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>
>> though I do think it would be a good idea to add a new set
>> of trace points, but that can come as a separate patch
>>
>>
>
> Agreed.

BTW, how would this look? I'm not familiar with adding new tracepoints...

-Kees

-- 
Kees Cook
Pixel Security
