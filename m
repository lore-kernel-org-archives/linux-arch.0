From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [RFC PATCH v2] compat: poll() in 32-bit applications does not
 handle negative timeout values properly on 64-bit kernels
Date: Sat, 11 Feb 2012 16:47:20 +0100
Message-ID: <1328975240.5661.31.camel@edumazet-laptop>
References: <4F3602A9.3060206@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49543 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab2BKPra (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2012 10:47:30 -0500
In-Reply-To: <4F3602A9.3060206@akamai.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Hunt <johunt@akamai.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Le vendredi 10 f=C3=A9vrier 2012 =C3=A0 23:54 -0600, Josh Hunt a =C3=A9=
crit :
> We have hit an issue where our 32-bit applications using poll() and
> passing in a value of -1 for the timeout value return after ~49 days
> (2^32 msec), instead of waiting indefinitely. I've instrumented the
> kernel and found we are hitting the case where poll() believes we've
> passed in a positive number and thus creates a timespec, etc. I've
> implemented compat_sys_poll() to sign-extend the timeout value and
> resolve the issue.
>=20
> There was an almost identical patch submitted last year, but for
> whatever reason did not make it in:
> https://lkml.org/lkml/2011/9/18/19

Probably because Thomas Meyer didnt answer to patch reviewers, and not
enough people cared.

By the way, an inline patch is better, as stated in
Documentation/SubmittingPatches

Anyway, its time to fix this bug...

Acked-by: Eric Dumazet <eric.dumazet@gmail.com>
