From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 02/30] x86-64: Use explicit sizes in sigcontext.h, prepare
 for x32
Date: Sun, 19 Feb 2012 16:51:51 -0800
Message-ID: <CA+55aFy__c1j=APK9tjJ__daYtZN74GySANxBZ9kT9e1Zx9DXQ@mail.gmail.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-3-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51841 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab2BTAwM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:52:12 -0500
In-Reply-To: <1329696488-16970-3-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, hjl.tools@gmail.com

On Sun, Feb 19, 2012 at 4:07 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Use explicit sizes (__u64) instead of implicit sizes (unsigned long)
> in the definition for sigcontext.h; this will allow this structure to
> be shared between the x86-64 native ABI and the x32 ABI.

Btw, since we had this issue just with autofs: what are the x32 ABI
alignment issues for __u64? Are they like x86-64 ("natural alignment")
or x86-32 ("4-byte alignment")?

I assume they are natural alignment, and as pointed out by Davem, we
do have the versions of u64 that make this explicit: "compat_u64" is
the 4-byte-aligned one, while "__aligned_u64" is the natively aligned
one.

Just plain "__u64" doesn't tell which it is, which is sad and wrong,
but we're likely stuck with it forever. Unless some shining knight
comes and says "__u64 is native alignment, and if you want anything
else, you need to use __compat_u64", and actually fixes the cases
where x86-32 depends on the 4-byte aligned one.

Which would be nice, but sounds unlikely. Shining knights tend to be
rare. But this *could* possibly be automated, so it's not entirely out
of the question.

                 Linus
