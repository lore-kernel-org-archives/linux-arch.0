From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Date: Mon, 2 Apr 2018 21:08:57 -0700
Message-ID: <CA+55aFzo_Hdsy31JD+CqUVFJvu2uQpaPOFdTL7J7XoR6WirkxA@mail.gmail.com>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 2, 2018 at 12:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The series is rather long and conflicts in trivial ways with lots
> of subsystem trees. You probably want to pull it either really
> early in the merge window or really late.

Ok, I've been pulling arch updates, so it went in now.

Side note: the most concise yet useful form of diff I found for your
pull request was this:

    git diff -M --stat=5000 --summary merge^..merge | grep '\+'

which shows the diffstat, but skips anything that doesn't have a plus
sign in it. So all the pure removal lines are entirely gone.

So it shows stuff that had actual modifications, and perhaps more
importantly, it still shows the final summary, which matches yours:

 2498 files changed, 95 insertions(+), 467668 deletions(-)

which is pretty nice to see. Closer to hal a million lines gone. (Or,
as the drm people would say "one header file").

You should probably check the end result (I haven't pushed out yet,
doing a few more things and build tests, but it should be out soon).

            Linus
