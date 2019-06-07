From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Fri, 7 Jun 2019 15:07:28 -0700
Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com> <87ef45axa4.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <87ef45axa4.fsf_-_@xmission.com>
Sender: owner-linux-aio@kvack.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>, Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, omar.kilani@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, David Laight <David.Laight@aculab.com>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 7, 2019 at 2:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The sigsuspend system call overrides the signal mask just
> like all of the other users of set_user_sigmask, so convert
> it to use the same helpers.

Me likey.

Whole series looks good to me, but that's just from looking at the
patches. Maybe testing shows problems..

              Linus

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
