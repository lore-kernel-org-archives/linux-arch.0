From: YunQiang Su <syq-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Date: Fri, 6 Mar 2020 19:29:57 +0800
Message-ID: <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
References: <20200306080905.173466-1-syq@debian.org> <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu> <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <40da389d-4e74-2644-2e7c-04d988fcc26f-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Vivier <laurent-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org>
Cc: Florian Weimer <fw-d32yF4oPJVt0XxTmqZlbVQ@public.gmane.org>, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, libc-alpha-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Laurent Vivier <laurent-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org> 于2020年3月6日周五 下午7:13写道：
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
