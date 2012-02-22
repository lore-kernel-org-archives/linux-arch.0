From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/30] x86-64: Use explicit sizes in sigcontext.h, prepare for x32
Date: Wed, 22 Feb 2012 21:23:38 +0000
Message-ID: <201202222123.38816.arnd@arndb.de>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <201202221222.58399.arnd@arndb.de> <4F453086.8030602@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51177 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab2BVVYZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2012 16:24:25 -0500
In-Reply-To: <4F453086.8030602@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, hjl.tools@gmail.com

On Wednesday 22 February 2012, H. Peter Anvin wrote:
> On 02/22/2012 04:22 AM, Arnd Bergmann wrote:
> > On Monday 20 February 2012, H. Peter Anvin wrote:
> >> We are using __u64 as x86-32 compatible since we are sharing most of the
> >> really complex path (like ioctl) with i386 much more so than x86-64.  So
> >> it is defined in userspace as:
> >>
> >> typedef unsigned long long __u64 __attribute__((aligned(4)));
> >>
> >> __aligned_u64 obviously is naturally aligned, which matches uint64_t is
> >> userspace.
> > 
> > Has someone audited the interfaces to check if there are data structures that
> > use a plain signed or unsigned "long long" instead of __s64/__u64 in places
> > where i386 differs from the other compat implementations?
> > 
> > I found DRM_IOCTL_UPDATE_DRAW, but there could be more like this one.
> > 
> 
> Has someone audited every single ioctl in the kernel?  Definitely not,
> which is why x32 is marked EXPERIMENTAL.  I think it is still time for
> this work to switch to happening in the upstream, however.

Depends on how you want to do it. In some cases, the easiest answer
would be to change the data structure to use __u64 and be compatible
with i386. Once there are distros built using data structure with
padding around a long long, you have to use a run-time conditional
in the compat handler.

I'd say we should fix at least the ones that are easy to spot because
they already use compat_u64 or have an #ifdef CONFIG_X86_64 in compat
code. I've looked at everything I could find that fits into that category
and found only two locations. My expectation is that all other data
structures that would fall into this category are already broken
for 32 bit emulation on x86.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/drm/drm.h b/include/drm/drm.h
index 49d94ed..73b7c33 100644
--- a/include/drm/drm.h
+++ b/include/drm/drm.h
@@ -438,7 +438,7 @@ struct drm_update_draw {
 	drm_drawable_t handle;
 	unsigned int type;
 	unsigned int num;
-	unsigned long long data;
+	__u64 data;
 };
 
 /**
diff --git a/include/sound/asound.h b/include/sound/asound.h
index a2e4ff5..a17e96c 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -824,8 +824,8 @@ struct snd_ctl_elem_value {
 			long *value_ptr;	/* obsoleted */
 		} integer;
 		union {
-			long long value[64];
-			long long *value_ptr;	/* obsoleted */
+			__s64 value[64];
+			__s64 *value_ptr;	/* obsoleted */
 		} integer64;
 		union {
 			unsigned int item[128];
	Arnd
