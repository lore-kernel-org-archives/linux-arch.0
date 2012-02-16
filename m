From: Josh Hunt <johunt@akamai.com>
Subject: Re: [RFC PATCH v2] compat: poll() in 32-bit applications does not
 handle negative timeout values properly on 64-bit kernels
Date: Thu, 16 Feb 2012 10:22:08 -0600
Message-ID: <4F3D2D30.8070403@akamai.com>
References: <4F3602A9.3060206@akamai.com> <1328975240.5661.31.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from prod-mail-xrelay06.akamai.com ([96.6.114.98]:46470 "EHLO
	prod-mail-xrelay06.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752425Ab2BPQWL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Feb 2012 11:22:11 -0500
In-Reply-To: <1328975240.5661.31.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 02/11/2012 09:47 AM, Eric Dumazet wrote:
> Le vendredi 10 f=C3=A9vrier 2012 =C3=A0 23:54 -0600, Josh Hunt a =C3=A9=
crit :
>> We have hit an issue where our 32-bit applications using poll() and
>> passing in a value of -1 for the timeout value return after ~49 days
>> (2^32 msec), instead of waiting indefinitely. I've instrumented the
>> kernel and found we are hitting the case where poll() believes we've
>> passed in a positive number and thus creates a timespec, etc. I've
>> implemented compat_sys_poll() to sign-extend the timeout value and
>> resolve the issue.
>>
>> There was an almost identical patch submitted last year, but for
>> whatever reason did not make it in:
>> https://lkml.org/lkml/2011/9/18/19
>=20
> Probably because Thomas Meyer didnt answer to patch reviewers, and no=
t
> enough people cared.
>=20
> By the way, an inline patch is better, as stated in
> Documentation/SubmittingPatches
>=20
> Anyway, its time to fix this bug...
>=20
> Acked-by: Eric Dumazet <eric.dumazet@gmail.com>
>=20

I can resubmit the patch inline if you feel that will get more attentio=
n
by whoever needs to do the final approval on this.

Josh
