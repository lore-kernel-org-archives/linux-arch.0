Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34652 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeKCF5w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Nov 2018 01:57:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id n140-v6so1340462yba.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Nov 2018 13:49:14 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id r185-v6sm8025045ywd.40.2018.11.02.13.49.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:49:10 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id i185-v6so1274523ywa.12
        for <linux-arch@vger.kernel.org>; Fri, 02 Nov 2018 13:49:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1541182406.20901.31.camel@linux.ibm.com>
References: <20181011001846.30964-1-keescook@chromium.org> <20181011001846.30964-13-keescook@chromium.org>
 <1541182406.20901.31.camel@linux.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 2 Nov 2018 13:49:09 -0700
Message-ID: <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
Subject: Re: [PATCH security-next v5 12/30] LSM: Provide separate ordered initialization
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181102204909.4Fd6k-srRpXFfhs7_tioPnTJyGYwzdxe7qcXuda2sYs@z>

On Fri, Nov 2, 2018 at 11:13 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> I don't recall why "integrity" is on the security_initcall, while both
> IMA and EVM are on the late_initcall().

It's because integrity needs to have a VFS buffer allocated extremely
early, so it used the security init to do it. While it's not an LSM,
it does use this part of LSM infrastructure. I didn't see an obvious
alternative at the time, but now that I think about it, maybe just a
simple postcore_initcall() would work?

-Kees

-- 
Kees Cook
