From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] all arches, signal: Move restart_block to struct task_struct
Date: Mon, 8 Dec 2014 14:51:06 -0800
Message-ID: <CALCETrUCXgAMyddaKcWWhUs5sus-TBkrJbbPsAdHwmPd_g1Okg@mail.gmail.com>
References: <43c88012a4959cd427ab634906e697fbc524e847.1414604015.git.luto@amacapital.net>
 <alpine.DEB.2.11.1410291908290.5308@nanos> <CALCETrWtBCFXzwCAh8fpeFv-EvPxYW20oRmFk1iCYwUvpft=Rw@mail.gmail.com>
 <20141110.211319.1983610686941713044.davem@davemloft.net> <5461EA6B.9020305@nod.at>
 <CALCETrUZhbx-PN8A168khFr6ve_9vdkSiwOcQ-hZbqu4po8hnQ@mail.gmail.com> <20141205061356.1f3f9015@as>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:57082 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbaLHWv1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Dec 2014 17:51:27 -0500
Received: by mail-lb0-f175.google.com with SMTP id u10so4446230lbd.20
        for <linux-arch@vger.kernel.org>; Mon, 08 Dec 2014 14:51:26 -0800 (PST)
In-Reply-To: <20141205061356.1f3f9015@as>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, David Miller <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, richard -rw- weinberger <richard.weinberger@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>

On Fri, Dec 5, 2014 at 3:13 AM, Chuck Ebbert <cebbert.lkml@gmail.com> wrote:
> Should the completely pointless supervisor_stack[] be removed as well?
> I had a patch to do that but I never sent it.

Might as well.

--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC
