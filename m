From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] fix generic get_user and put_user
Date: Tue, 17 May 2011 17:25:28 -0400
Message-ID: <1305667528.2239.64.camel@deneb.redhat.com>
References: <1305657349-2783-1-git-send-email-msalter@redhat.com>
	 <201105172226.54517.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932296Ab1EQVZc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 May 2011 17:25:32 -0400
In-Reply-To: <201105172226.54517.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Tue, 2011-05-17 at 22:26 +0200, Arnd Bergmann wrote:
> On Tuesday 17 May 2011, Mark Salter wrote:
> > diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> > index 1d0fdf8..5079335 100644
> > --- a/include/asm-generic/uaccess.h
> > +++ b/include/asm-generic/uaccess.h
> > @@ -162,9 +162,10 @@ static inline __must_check long __copy_to_user(void __user *to,
> >  
> >  #define put_user(x, ptr)                                       \
> >  ({                                                             \
> > +       __typeof__(*(ptr)) *__pu_ptr = (ptr);                   \
> >         might_sleep();                                          \
> > -       access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)) ?            \
> > -               __put_user(x, ptr) :                            \
> > +       access_ok(VERIFY_WRITE, __pu_ptr, sizeof(*ptr)) ?       \
> > +               __put_user(x, __pu_ptr) :                       \
> >                 -EFAULT;                                        \
> >  })
> >  
> > @@ -218,9 +219,10 @@ extern int __put_user_bad(void) __attribute__((noreturn));
> >  
> >  #define get_user(x, ptr)                                       \
> >  ({                                                             \
> > +       __typeof__(*(ptr)) *__gu_ptr = (ptr);                   \
> >         might_sleep();                                          \
> > -       access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?             \
> > -               __get_user(x, ptr) :                            \
> > +       access_ok(VERIFY_READ, __gu_ptr, sizeof(*ptr)) ?        \
> > +               __get_user(x, __gu_ptr) :                       \
> >                 -EFAULT;                                        \
> >  })
> >  
> 
> IIRC, this doesn't work for get_user if the pointer is marked const.
> Do you see a real problem with the current definitions, or are you
> just trying to improve them genrally?
> 

I think you're thinking of doing this:

  __typeof__(*(ptr)) __tmp_x;

then assigning to __tmp_x wouldn't work if ptr was a pointer to a const
value.

But that does make me think there's a problem with my patch if the ptr
itself is const. In that case you might see a warning about losing the
const attribute with the assignment. So maybe those should be:

 __typeof__(*(ptr)) *const __xx_ptr = (ptr);

And yes, I am seeing an actual runtime failure due to put_user double
incrementing a ptr. A grep of the kernel shows a few dozen cases where
this can bite. Mostly in arch code where arch-specific implentations of
put_user/get_user are being used, but also in driver and network code.

--Mark
