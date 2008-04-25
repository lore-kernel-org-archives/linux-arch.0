From: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 24/24] Use U64_C() instead of casts in kernel/time.c
Date: Thu, 24 Apr 2008 21:44:17 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC012FA04B@orsmsx424.amr.corp.intel.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com><1209078352-7593-2-git-send-email-hpa@zytor.com><1209078352-7593-3-git-send-email-hpa@zytor.com><1209078352-7593-4-git-send-email-hpa@zytor.com><1209078352-7593-5-git-send-email-hpa@zytor.com><1209078352-7593-6-git-send-email-hpa@zytor.com><1209078352-7593-7-git-send-email-hpa@zytor.com><1209078352-7593-8-git-send-email-hpa@zytor.com><1209078352-7593-9-git-send-email-hpa@zytor.com><1209078352-7593-10-git-send-email-hpa@zytor.com><1209078352-7593-11-git-send-email-hpa@zytor.com><1209078352-7593-12-git-send-email-hpa@zytor.com><1209078352-7593-13-git-send-email-hpa@zytor.com><1209078352-7593-14-git-send-email-hpa@zytor.com><1209078352-7593-15-git-send-email-hpa@zytor.com><1209078352-7593-16-git-send-email-hpa@zytor.com><1209078352-7
 593-17-git-send-email-hpa@zytor.com><1209078352-7593-18-git-send-email-hpa@zytor.com><1FE6DD409037234FAB833C420AA843EC012F9FDA@orsmsx424.amr.corp.intel.com> <200804250410.m3P4A67w019427@tazenda.hos.
	anvin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <200804250410.m3P4A67w019427-TYXNXmPMDn57u0wkx6qpVYSLwOllVvif@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

> Note that since pasting has priority over macro resolution, the header
> file generation is modified to have suffixed versions of all the
> generated values.

Much better.  Builds and boots on ia64 now.  I only ran some trivial
tests, but it still seems to be counting time correctly.

Acked-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
