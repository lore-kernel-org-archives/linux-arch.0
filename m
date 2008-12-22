From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Multiple math errors and SIGFPE
Date: Mon, 22 Dec 2008 08:28:42 -0800
Message-ID: <494FC03A.3090208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:39535 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYLVQ2o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Dec 2008 11:28:44 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>

I have received a bug report related to the si_code field of siginfo for
SIGFPE.  The FPE_ values are (unfortunately) an enumeration rather than
a bitmask, so we can't just OR them together.  Unfortunately when we get
multiple unmasked exceptions at least on x86 we leave info.si_code to
__SI_FAULT, which means it is returned to userspace as zero.  This
violates POSIX, which states that an si_code <= 0 is a user-generated
signal.

Looking at the code in other architectures, it looks like most of them
prioritize the faults, but still end up with __SI_FAULT|0 if none of the
expected conditions are found (which may not be possible, of course.)
Prioritizing the faults seem like the reasonable thing to do in terms of
 dealing with the multiple unmasked errors problem.

I am wondering if it would make sense to notice the combination
__SI_FAULT|0 or __SI_FAULT and (short)si_code < 0 and force SI_KERNEL
into the user-space code field in the generic code.  I am also wondering
if there is any possibility that there is code out there which relies on
the current, buggy behaviour.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
