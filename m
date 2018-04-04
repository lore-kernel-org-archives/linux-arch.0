Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40988 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeDDIin (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Apr 2018 04:38:43 -0400
MIME-Version: 1.0
In-Reply-To: <20180404080142.GC9342@amd>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
 <CA+55aFzmQ9specaytsjEb=iNm-NHE5kxMSy_H_jKvqZa4-Fomw@mail.gmail.com>
 <CAK8P3a2pdmLOHb2wkPVvqLDo71Rf3hLVfhG7vsMzaPD-DMEzSg@mail.gmail.com>
 <CAMuHMdVZg8BL7D2eB-FnDbJabU3sfda6nOnaCdJj-3OC-+KP0g@mail.gmail.com> <20180404080142.GC9342@amd>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 10:38:41 +0200
Message-ID: <CAK8P3a3Rj7utFTrNrNiv3948whE9Tsta9mmLPdX5HxBhif-_9w@mail.gmail.com>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>, "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
Message-ID: <20180404083841.vPDO6semvbgftU4IQe1ePBDnp3qclrydPDqBIdvnUCE@z>

On Wed, Apr 4, 2018 at 10:01 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2018-04-03 11:18:15, Geert Uytterhoeven wrote:

>> In reality, a resurrection may not be implemented as a pure revert, but as
>> the addition of a new architecture, implemented using modern features (DT,
>> CCF, ...).
>
> By insisting on new features instead of pure revert + incremental
> updates, you pretty much make sure resurection will not be possible
> :-(.

It wasn't that anybody demanded it to be that way, but rather that the
maintainer chose to do it like that, as you can see from the first version
that got posted: https://marc.info/?l=linux-arch&m=142181640803103
This is the only reference point we have, since no other architecture
ever got removed and then put back.

Also, now that the other architectures are gone, a lot of changes can
be done more easily that will be incompatible with a pure revert, so
the more time passes, the harder it will get to do that.

Some of the architectures (e.g. tile or cris) have been kept up to
date, but others had already bitrotted to the point where they were
unlikely to work on any real hardware for many relases, but a revert
could still be used as a starting point in theory.

      Arnd
