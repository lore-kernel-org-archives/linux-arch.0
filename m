Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36294 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755234AbeDBS5H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Apr 2018 14:57:07 -0400
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 11:57:05 -0700
Message-ID: <CA+55aFzmQ9specaytsjEb=iNm-NHE5kxMSy_H_jKvqZa4-Fomw@mail.gmail.com>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
Message-ID: <20180402185705.oShXLDt9ZJ2TR0c3c8g0P_3pTMaqDVgeXE5B3V8ebz4@z>

On Mon, Apr 2, 2018 at 12:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> (dirstat only for brevity)

Shortlog?

I'd like to see that each architecture removal is independent of the
others, so that if somebody wants to resurrect any particular
architecture, he/she can do so with a revert.

Can I just fetch things and see? Sure. But there's no excuse not to
have a shortlog in the pull request, even if the full diffstat itself
might be prohibitive.

                Linus
