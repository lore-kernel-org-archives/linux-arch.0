Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44732 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFLaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 06:30:10 -0500
MIME-Version: 1.0
References: <20200306080905.173466-1-syq@debian.org> <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu> <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
In-Reply-To: <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
From: YunQiang Su <syq@debian.org>
Date: Fri, 6 Mar 2020 19:29:57 +0800
Message-ID: <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Florian Weimer <fw@deneb.enyo.de>, torvalds@linux-foundation.org, Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <20200306112957.Ycf1g-W__UAshzGyYpEbX9zqqU8w0hiMRyzv-LFWfMU@z>

Laurent Vivier <laurent@vivier.eu> 于2020年3月6日周五 下午7:13写道：
>
> Le 06/03/2020 à 09:37, Florian Weimer a écrit :
> > * Laurent Vivier:
> >
> >> Le 06/03/2020 à 09:13, Florian Weimer a écrit :
> >>> * YunQiang Su:
> >>>
> >>>> +  if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> >>>> +          flags |= AT_FLAGS_PRESERVE_ARGV0;
> >>>> +  NEW_AUX_ENT(AT_FLAGS, flags);
> >>>
> >>> Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
> >>> separate AT_ tag dedicated to binfmt_misc.
> >>
> >> Not necessary, but it seemed simpler and cleaner to re-use a flag that
> >> is marked as unused and with a name matching the new role. It avoids to
> >> patch other packages (like glibc) to add it as it is already defined.
> >
> > You still need to define AT_FLAGS_PRESERVE_ARGV0.  At that point, you
> > might as well define AT_BINFMT and AT_BINFMT_PRESERVE_ARGV0.
> >
>
> Yes, you're right.
>
> But is there any reason to not reuse AT_FLAGS?

AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
   /* AT_* values 18 through 22 are reserved */
   27,28,29,30 are not used now.
Which should we use?

>
> Thanks,
> Laurent
