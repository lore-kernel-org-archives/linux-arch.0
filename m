From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lib: Reduce user_access_begin() boundaries in
 strncpy_from_user() and strnlen_user()
Date: Thu, 23 Jan 2020 10:47:42 -0800
Message-ID: <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
References: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38328 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAWSsC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 13:48:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so3137164lfm.5
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 10:48:00 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id u15sm1514225lfl.87.2020.01.23.10.47.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:47:58 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id z26so3097454lfg.13
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 10:47:58 -0800 (PST)
In-Reply-To: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>

On Thu, Jan 23, 2020 at 12:34 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> The range passed to user_access_begin() by strncpy_from_user() and
> strnlen_user() starts at 'src' and goes up to the limit of userspace
> allthough reads will be limited by the 'count' param.
>
> On 32 bits powerpc (book3s/32) access has to be granted for each 256Mbytes
> segment and the cost increases with the number of segments to unlock.
>
> Limit the range with 'count' param.

Ack. I'm tempted to take this for 5.5 too, just so that the
unquestionably trivial fixes are in that baseline, and the
infrastructure is ready for any architecture that has issues like
this.

Adding 'linux-arch' to the participants, to see if other architectures
are at all looking at actually implementing the whole
user_access_begin/end() dance too..

               Linus
