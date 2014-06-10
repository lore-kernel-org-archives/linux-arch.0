From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC 03/10] tools: Add le_direct/be_direct methods for
 unaligned access
Date: Tue, 10 Jun 2014 16:25:55 -0700
Message-ID: <CALCETrUrdvvTc+qt61nQ1iRW4qpyDfMSzqnLKFMUsx7P=XvAfA@mail.gmail.com>
References: <1402441994-16780-1-git-send-email-hpa@zytor.com> <1402441994-16780-4-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:33059 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbaFJX0Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jun 2014 19:26:16 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so3029457veb.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Jun 2014 16:26:15 -0700 (PDT)
In-Reply-To: <1402441994-16780-4-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Jun 10, 2014 at 4:13 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> For architectures which handle unaligned references transparently.

Shouldn't these depend on host endianness?

--Andy
