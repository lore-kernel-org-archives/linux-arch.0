From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] Remove #ifdef CONFIG_64BIT from all asm-generic/fcntl.h
Date: Mon, 14 Sep 2015 15:50:12 -0700 (PDT)
Message-ID: <55f74f24.a2eb420a.57553.fffff8c5@mx.google.com>
References: <18247.1441883885@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34063 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbINWuO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2015 18:50:14 -0400
Received: by padhy16 with SMTP id hy16so155859956pad.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2015 15:50:13 -0700 (PDT)
In-Reply-To: <18247.1441883885@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: dhowells@redhat.com, arnd@arndb.de, 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org

On Thu, 10 Sep 2015 04:18:05 PDT (-0700), dhowells@redhat.com wrote:
> David Howells <dhowells@redhat.com> wrote:
>
>> Rather than iterating through all the rest of your patches and saying the same
>> thing, if there's something in a UAPI header that needs wrapping in __KERNEL__
>> to exclude it from userspace's use, then it should be transferred to the
>> non-UAPI variant of that header (which should #include the UAPI variant).
>
> I should mention that there is the odd case where this is difficult to
> achieve.  See include/uapi/linux/acct.h for an example...

OK, sorry about that.  I'm submitting a v3 that should fix these
problems.
