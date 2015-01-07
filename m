From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 09/40] metag/uaccess: fix sparse errors
Date: Wed, 7 Jan 2015 11:55:10 +0200
Message-ID: <20150107095510.GA24828@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
 <1420558883-10131-10-git-send-email-mst@redhat.com>
 <54AD00AC.2030801@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54AD00AC.2030801-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 07, 2015 at 09:47:24AM +0000, James Hogan wrote:
> Hi Machael,
> 
> On 06/01/15 15:43, Michael S. Tsirkin wrote:
> > virtio wants to read bitwise types from userspace using get_user.  At the
> > moment this triggers sparse errors, since the value is passed through an
> > integer.
> > 
> > Fix that up using __force.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/metag/include/asm/uaccess.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/metag/include/asm/uaccess.h b/arch/metag/include/asm/uaccess.h
> > index 0748b0a..c314b45 100644
> > --- a/arch/metag/include/asm/uaccess.h
> > +++ b/arch/metag/include/asm/uaccess.h
> > @@ -135,7 +135,7 @@ extern long __get_user_bad(void);
> >  ({                                                              \
> >  	long __gu_err, __gu_val;                                \
> >  	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
> > -	(x) = (__typeof__(*(ptr)))__gu_val;                     \
> > +	(x) = (__force __typeof__(*(ptr)))__gu_val;                     \
> 
> As I mentioned before, can you please adjust the position of the \ to
> line up.
> >  	__gu_err;                                               \
> >  })
> >  
> > @@ -145,7 +145,7 @@ extern long __get_user_bad(void);
> >  	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
> >  	if (access_ok(VERIFY_READ, __gu_addr, size))			\
> >  		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
> > -	(x) = (__typeof__(*(ptr)))__gu_val;                             \
> > +	(x) = (__force __typeof__(*(ptr)))__gu_val;                             \
> 
> same here (this one causes checkpatch error due to 80 column limit).

Oops. Sorry. Will fix both. I won't repost unless there are more issues.

> 
> >  	__gu_err;                                                       \
> >  })
> >  
> > 
> 
> With those changes,
> Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> Cheers
> James
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
