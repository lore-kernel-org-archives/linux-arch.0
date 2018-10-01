Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34373 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBGaR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 02:30:17 -0400
Received: by mail-yb1-f195.google.com with SMTP id 184-v6so67189ybg.1
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 16:50:01 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id u22-v6sm11175857ywu.49.2018.10.01.16.49.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 16:49:59 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id y76-v6so62926ywd.2
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 16:49:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
 <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 16:49:57 -0700
Message-ID: <CAGXu5jJr8P_rS+DcQJxMM9xnB0vFFc75Xrk7Qv9yx8_DLB1Vjg@mail.gmail.com>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181001234957.r1c2wAE7Yl-QvvSNkHmdTiF2q-jOucY-i6igNUpbcKY@z>

On Mon, Oct 1, 2018 at 4:44 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/01/2018 04:30 PM, Kees Cook wrote:
>> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
>> enabled. Is that okay?
>>
> ugh I would rather get rid of apparmor=0 or to emit a warning with apparmor
> disabled, but if we have to live with it then yes I can live with last
> option wins

Removing it would be much preferred! :)

Assuming Paul is okay with the same results in SELinux, I'll prepare patches...

-Kees

-- 
Kees Cook
Pixel Security
