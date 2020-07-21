From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Tue, 21 Jul 2020 14:16:51 -0700
Message-ID: <CAHk-=wh59vJmaH_jWWxpr97XdQfUpOTJgMEA11qzvMwJFjB0VQ@mail.gmail.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk> <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
 <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com> <20200721211118.GB2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200721211118.GB2786714@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 2:11 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > > But I didn't check. Maybe we don't have anything that stupid in the kernel.
>
> I did.

So then the commit message really should have said so, I feel. That
would have avoided the whole worry, and made it clear that it's not an
issue.

                Linus
