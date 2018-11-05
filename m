Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728718AbeKEXeO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Nov 2018 18:34:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5E9GJh015106
        for <linux-arch@vger.kernel.org>; Mon, 5 Nov 2018 09:14:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2njpkvu0dw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 05 Nov 2018 09:14:18 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 5 Nov 2018 14:14:16 -0000
Subject: Re: [PATCH security-next v5 12/30] LSM: Provide separate ordered
 initialization
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 05 Nov 2018 09:13:58 -0500
In-Reply-To: <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
References: <20181011001846.30964-1-keescook@chromium.org>
         <20181011001846.30964-13-keescook@chromium.org>
         <1541182406.20901.31.camel@linux.ibm.com>
         <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <1541427238.21115.58.camel@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181105141358.p6RYcTAulC-zMrc8ZWbxYjRGxY9WROwt0O9pV86Cq_k@z>

On Fri, 2018-11-02 at 13:49 -0700, Kees Cook wrote:
> On Fri, Nov 2, 2018 at 11:13 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > I don't recall why "integrity" is on the security_initcall, while both
> > IMA and EVM are on the late_initcall().
> 
> It's because integrity needs to have a VFS buffer allocated extremely
> early, so it used the security init to do it. While it's not an LSM,
> it does use this part of LSM infrastructure. I didn't see an obvious
> alternative at the time, but now that I think about it, maybe just a
> simple postcore_initcall() would work?

I was questioning why the "security_initcall", which is called after
the late_initcall.  Moving it to the postcore_initcall, before the
late_initcall, sounds right.

Mimi
