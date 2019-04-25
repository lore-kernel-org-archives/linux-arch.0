Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([54.37.238.230]:36176 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDYNZf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Apr 2019 09:25:35 -0400
Date: Thu, 25 Apr 2019 15:22:49 +0200
From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH RESEND v5 0/5] namei: vfs flags to restrict path
 resolution
Message-ID: <20190425132249.GA26669@angband.pl>
References: <20190320143717.2523-1-cyphar@cyphar.com>
 <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
 <20190325130429.dbrgjxnvq3w5cpb3@yavin>
 <CAGXu5jKPrarixQkWWXOBCu6kRRpQd0aaJsPJbvsAyh0Wvc620A@mail.gmail.com>
 <20190424153806.64qkkmkudzodxnz2@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424153806.64qkkmkudzodxnz2@yavin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Jann Horn <jannh@google.com>, Christian Brauner <christian@brauner.io>, David Drysdale <drysdale@google.com>, Tycho Andersen <tycho@tycho.ws>, Linux Containers <containers@lists.linux-foundation.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190425132249.jZfhXCeI5ZvTdLt1WcoGvPxApusSnL2DvNwSVHmg8rw@z>

On Thu, Apr 25, 2019 at 01:38:06AM +1000, Aleksa Sarai wrote:
>  * openat(2) ignores unknown flags, meaning that old kernels will ignore
>    new programs trying to use O_THISROOT and might end up causing
>    security issues. Yes, it'd be trivial to check whether the new O_*
>    flags are supported at start-up, but I think a security feature
>    shouldn't have a foot-gun associated with it. In fact, I didn't know
>    openat(2) ignored unknown flags until I wrote this patchset -- I
>    doubt many other userspace developers do either.

For this reason, I propose every new syscall that has flags to follow a
bitmask scheme, where any flag assigned a bit in the upper half returns
EOPNOTSUPP when called on an old kernel.  That would allow defining which
flags can be safely ignored and which can't.

It otherwise takes major hacks to implement a fail-if-not-supported flag
while keeping compat with old kernels.  For example, for mmap(), MAP_SHARED
has been duplicated as MAP_SHARED_VALIDATE just to allow an unrelated flag
(MAP_SYNC) to fail on old kernels.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Imagine there are bandits in your house, your kid is bleeding out,
⢿⡄⠘⠷⠚⠋⠀ the house is on fire, and seven giant trumpets are playing in the
⠈⠳⣄⠀⠀⠀⠀ sky.  Your cat demands food.  The priority should be obvious...
