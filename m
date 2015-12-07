From: Andy Lutomirski <luto@amacapital.net>
Subject: [PSEUDOPATCH] rename is_compat_task
Date: Mon, 7 Dec 2015 15:12:59 -0800
Message-ID: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33535 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973AbbLGXNT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2015 18:13:19 -0500
Received: by obbww6 with SMTP id ww6so1839997obb.0
        for <linux-arch@vger.kernel.org>; Mon, 07 Dec 2015 15:13:18 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

Hi all-

Every time I look at is_compat_task, I cringe.  That function
determines whether we're in a compat syscall, not whether we're in a
compat task.  There are probably architectures (arm64?) under which
these are the same conditions, but they are definitely *not* the same
thing on x86.

Can we just fix it?  I propose the following patch:

$ find -type f |xargs sed -i -e 's/is_compat_task/in_compat_syscall/g'

If there's general agreement, can we do that at the end of the next
merge window?

I could also send a patch series to add in_compat_syscall, change all
the users, then delete the old stuff, but that seems overcomplicated
for something that's literally just renaming a token.

--Andy
