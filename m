Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f178.google.com ([209.85.219.178]:33724 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJBGSi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 02:18:38 -0400
Received: by mail-yb1-f178.google.com with SMTP id u88-v6so60181ybi.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 16:38:23 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c142-v6sm11783957ywa.81.2018.10.01.16.38.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 16:38:21 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id o63-v6so55181yba.2
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 16:38:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 16:38:20 -0700
Message-ID: <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181001233820.ZWZciyjTVTiLzR5vX790ZH-r--ju2bQ5P7sjhCDtPe0@z>

On Mon, Oct 1, 2018 at 4:30 PM, Kees Cook <keescook@chromium.org> wrote:
> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
> enabled. Is that okay?

Actually, what the v3 series does right now is leaves AppArmor and
SELinux alone -- whatever they configured for enable/disable is left
alone.

The problem I have is when processing CONFIG_LSM_ENABLE ... what do I
do with the existing "enable" flag? It's set by both
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE and apparmor=0/1.

Right now I can't tell the difference between someone booting with
apparmor=0 or CONFIG_LSM_ENABLE not including apparmor.

i.e. how do I mix CONFIG_LSM_ENABLE with apparmor=0/1? (assuming
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE has been removed)

-Kees

-- 
Kees Cook
Pixel Security
