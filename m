From: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 09/24] ia64: types: use <asm-generic/int-*.h> for the ia64 architecture
Date: Thu, 24 Apr 2008 18:37:44 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC012F9FDA@orsmsx424.amr.corp.intel.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <1209078352-7593-4-git-send-email-hpa@zytor.com> <1209078352-7593-5-git-send-email-hpa@zytor.com> <1209078352-7593-6-git-send-email-hpa@zytor.com> <1209078352-7593-7-git-send-email-hpa@zytor.com> <1209078352-7593-8-git-send-email-hpa@zytor.com> <1209078352-7593-9-git-send-email-hpa@zytor.com> <1209078352-7593-10-git-send-email-hpa@zytor.com> <1209078352-7593-11-git-send-email-hpa@zytor.com> <1209078352-7593-12-git-send-email-hpa@zytor.com> <1209078352-7593-13-git-send-email-hpa@zytor.com> <1209078352-7593-14-git-send-email-hpa@zytor.com> <1209078352-7593-15-git-send-email-hpa@zytor.com> <1209078352-7593-16-git-send-email-hpa@zytor.co
 m> <1209078352-7593-17-git-send-email-hpa@zytor.com> <1209078352-7593-18-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <1209078352-7593-18-git-send-email-hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I get an error while building the ia64 sim_defconfig (which
uses CONFIG_HZ=32)

kernel/time.c: In function `msecs_to_jiffies':
kernel/time.c:472: error: `MSEC_TO_HZ_MUL32UL' undeclared (first use in this function)
kernel/time.c:472: error: (Each undeclared identifier is reported only once
kernel/time.c:472: error: for each function it appears in.)


The generated timeconst.h has:
#define MSEC_TO_HZ_MUL32        0x83126e98

So some weird cpp thing happened and the UL got concatenated
before the MSEC_TO_HZ_MUL32 was swapped out for its defined
value.

All the rest of the ia64 configs build ok.

-Tony
