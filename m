Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47971 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbaITRT5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 20 Sep 2014 13:19:57 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so1157355obc.7
        for <linux-arch@vger.kernel.org>; Sat, 20 Sep 2014 10:19:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201409201940.AHG21834.LJOFFHSFQOtVMO@I-love.SAKURA.ne.jp>
References: <201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp>
	<541D16EA.70407@huawei.com>
	<201409201940.AHG21834.LJOFFHSFQOtVMO@I-love.SAKURA.ne.jp>
Date: Sat, 20 Sep 2014 10:19:56 -0700
Message-ID: <CAGXu5jLf3st2WBV5ycEOgCJGk8z5TP1SuvLQcD=sC2cs_4CF8w@mail.gmail.com>
Subject: Re: [PATCH 3.17-rc5] Fix confusing PFA_NO_NEW_PRIVS constant.
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, James Morris <james.l.morris@oracle.com>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>, David Drysdale <drysdale@google.com>, Michael Kerrisk-manpages <mtk.manpages@gmail.com>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@chromium.org>, Linux API <linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>
Message-ID: <20140920171956.I2Gr4uNRh-EUVuwgfEbL2bFF_2n4BLwxDdDUckI2xS4@z>

On Sat, Sep 20, 2014 at 3:40 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Can you apply below patch before new PFA_* are defined?
> Cgroups code might want to define PFA_SPREAD_PAGE as 1 and PFA_SPREAD_SLAB as 2.
> ----------------------------------------
> >From 8543e68adb210142fa347d8bc9d83df0bb2c5291 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 20 Sep 2014 19:24:23 +0900
> Subject: [PATCH 3.17-rc5] Fix confusing PFA_NO_NEW_PRIVS constant.
>
> Commit 1d4457f99928 ("sched: move no_new_privs into new atomic flags")
> defined PFA_NO_NEW_PRIVS as hexadecimal value, but it is confusing
> because it is used as bit number. Redefine it as decimal bit number.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/sched.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5c2c885..4557765 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1957,7 +1957,7 @@ static inline void memalloc_noio_restore(unsigned int flags)
>  }
>
>  /* Per-process atomic flags. */
> -#define PFA_NO_NEW_PRIVS 0x00000001    /* May not gain new privileges. */
> +#define PFA_NO_NEW_PRIVS 0     /* May not gain new privileges. */
>
>  static inline bool task_no_new_privs(struct task_struct *p)
>  {

Thanks, good catch.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Chrome OS Security
