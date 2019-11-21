From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 02/23] y2038: add __kernel_old_timespec and __kernel_old_time_t
Date: Thu, 21 Nov 2019 15:17:36 +0100
Message-ID: <CAK8P3a1GSncyq6dX482ZY8TmJxT8gazFZpnJs-Jzomq6keWjHg@mail.gmail.com>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-2-arnd@arndb.de>
 <a5f530323b66cd8c0055c5e642ef4eb035c53808.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5f530323b66cd8c0055c5e642ef4eb035c53808.camel@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 20, 2019 at 11:30 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> > The 'struct timespec' definition can no longer be part of the uapi headers
> > because it conflicts with a a now incompatible libc definition. Also,
> > we really want to remove it in order to prevent new uses from creeping in.
> >
> > The same namespace conflict exists with time_t, which should also be
> > removed. __kernel_time_t could be used safely, but adding 'old' in the
> > name makes it clearer that this should not be used for new interfaces.
> >
> > Add a replacement __kernel_old_timespec structure and __kernel_old_time_t
> > along the lines of __kernel_old_timeval.
> [...]
> > --- a/include/uapi/linux/time_types.h
> > +++ b/include/uapi/linux/time_types.h
> > @@ -28,6 +28,11 @@ struct __kernel_old_timeval {
> >  };
> >  #endif
> >
> > +struct __kernel_old_timespec {
> > +     __kernel_time_t tv_sec;                 /* seconds */
>
> Should this be __kernel_old_time_t for consistency?

Yes. I had already noticed this and changed it in the current version
of "y2038: uapi: change __kernel_time_t to __kernel_old_time_t".

      Arnd
