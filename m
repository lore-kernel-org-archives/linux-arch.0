From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH RFC 2/8] blackfin: implement syscall restart generically
Date: Tue, 25 Oct 2011 20:01:38 -0400
Message-ID: <CAMjpGUeQch6_-wPRVrktLGFt5h3UV3usaD6XHu_gn82DFcEh1Q@mail.gmail.com>
References: <cover.1319364492.git.jonas@southpole.se> <f33d604e18508d766a224f66f0bc9340af00ee89.1319364492.git.jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58893 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab1JZACA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2011 20:02:00 -0400
In-Reply-To: <f33d604e18508d766a224f66f0bc9340af00ee89.1319364492.git.jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Sun, Oct 23, 2011 at 06:19, Jonas Bonn <jonas@southpole.se> wrote:
> --- a/arch/blackfin/include/asm/syscall.h
> +++ b/arch/blackfin/include/asm/syscall.h
>
> =C2=A0static inline long
> =C2=A0syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return regs->p0;
> + =C2=A0 =C2=A0 =C2=A0 return regs->orig_p0;
> =C2=A0}

i'm not sure this is correct.  we set the orig_p0 to -1 when forcing
the syscall to go to restart.  shouldn't syscall_get_nr() still return
the right value ?

> =C2=A0syscall_set_return_value(struct task_struct *task, struct pt_re=
gs *regs,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0int error, long val)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 regs->r0 =3D error ? -error : val;
> + =C2=A0 =C2=A0 =C2=A0 regs->r0 =3D error ? error : val;
> =C2=A0}

this fix is unrelated (and unmentioned in the changelog).  i also see
a bunch of other arches doing this.  so we should pull this change out
into a dedicated patchset, and fix all the arches at the same time.
-mike
