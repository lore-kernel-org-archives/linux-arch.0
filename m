Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268720AbUHUADm@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:51948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264973AbUHUADm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 20:03:42 -0400
Date: Fri, 20 Aug 2004 17:07:12 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: copy_mount_options()
Message-Id: <20040820170712.68e4cda9.akpm@osdl.org>
In-Reply-To: <20040820165133.67df8d1b.davem@redhat.com>
References: <20040820130110.07f7c23c.davem@redhat.com>
	<20040820131053.3d5e0f9b.akpm@osdl.org>
	<20040820141137.646c349f.davem@redhat.com>
	<20040820143111.3fd0070e.akpm@osdl.org>
	<20040820144052.14413a4f.davem@redhat.com>
	<20040820154736.166b66ec.akpm@osdl.org>
	<20040820231833.GH1945@krispykreme>
	<20040820165133.67df8d1b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, linux-arch@vger.kernel.org, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

"David S. Miller" <davem@redhat.com> wrote:
>
> On Sat, 21 Aug 2004 09:18:33 +1000
> Anton Blanchard <anton@samba.org> wrote:
> 
> > I too hate that interface, Im continually getting it wrong. It would be
> > nice to remove the possibility of having similar such subtle bugs.
> 
> I agree.
> 
> There used to be clever code that would truncate the pipe write
> and stuff like that, and TCP even used to do something similar
> at one point.  But I go look now and neither of them do that
> any more.
> 
> It would even make the kernel smaller because all of these silly:
> 
> 	return copy_*_user(...) ? -EFAULT : 0;
> 
> would just expand to a direct use of the return value.
> 
> So many arch user copy routines would have enormous amounts
> of complexity removed, and I saw this quite well when doing
> the sparc64 stuff I did yesterday.

I'm all for it.  I'll sneak the below patch into -mm, see what breaks.

It's a bit weird that the usercopy functions return unsigned long.  If they
are to return -EFAULT they really should be changed to return an int.

--- 25/arch/i386/lib/usercopy.c~usercopy-return-EFAULT	Fri Aug 20 17:04:37 2004
+++ 25-akpm/arch/i386/lib/usercopy.c	Fri Aug 20 17:05:52 2004
@@ -560,14 +560,14 @@ survive:
 			to += len;
 			n -= len;
 		}
-		return n;
+		return n ? -EFAULT : 0;
 	}
 #endif
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
 		n = __copy_user_intel(to, from, n);
-	return n;
+	return n ? -EFAULT : 0;
 }
 
 unsigned long
@@ -577,7 +577,7 @@ __copy_from_user_ll(void *to, const void
 		__copy_user_zeroing(to, from, n);
 	else
 		n = __copy_user_zeroing_intel(to, from, n);
-	return n;
+	return n ? -EFAULT : 0;
 }
 
 /**
@@ -599,7 +599,7 @@ copy_to_user(void __user *to, const void
 	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __copy_to_user(to, from, n);
-	return n;
+	return n ? -EFAULT : 0;
 }
 EXPORT_SYMBOL(copy_to_user);
 
@@ -627,6 +627,6 @@ copy_from_user(void *to, const void __us
 		n = __copy_from_user(to, from, n);
 	else
 		memset(to, 0, n);
-	return n;
+	return n ? -EFAULT : 0;
 }
 EXPORT_SYMBOL(copy_from_user);
_
