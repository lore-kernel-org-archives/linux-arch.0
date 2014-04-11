From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 02/15] arm: __NR_syscalls fix
Date: Fri, 11 Apr 2014 13:50:50 +0200
Message-ID: <CAJfpegvZ-n4sT0ojj9iUg_R5gMZHT0caad6TpOdcmF=pdiXkqg@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<1397211951-20549-3-git-send-email-miklos@szeredi.hu>
	<20140411103351.GJ16119@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:58296 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbaDKLuv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 07:50:51 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so5233836qge.16
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 04:50:50 -0700 (PDT)
In-Reply-To: <20140411103351.GJ16119@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>

On Fri, Apr 11, 2014 at 12:33 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 11, 2014 at 12:25:38PM +0200, Miklos Szeredi wrote:
>> From: Miklos Szeredi <mszeredi@suse.cz>
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> ---
>
> This has me wondering...
>
> (a) what you think it fixes
> (b) whether you tried to build-test this
>
> The ARM instruction set supports 8-bit immediate constants with an even
> power of two shift.  384 fits that (0x180), 382 does not (0x17e), and
> in your following patch, 383 definitely doesn't (0x17f).
>
> Having this constant larger than necessary does not cause any problem
> for the syscall table: we explicitly pad it with calls to sys_ni_syscall
> to make up the difference.

Yes, and the padding will be of wrong length if NR_syscalls is
incorrect (which may be Oopsable?).  At least that is my impression
from a casual glance.

Thanks,
Miklos
