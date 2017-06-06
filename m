From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
Date: Tue, 6 Jun 2017 14:46:20 +0200
Message-ID: <CAK8P3a1XsE9uCwn9N7oc4GycPERX3t1XhGyiixxRjhG8GXoEuA@mail.gmail.com>
References: <20170603135111.5444-1-asarai@suse.de> <20170603135111.5444-2-asarai@suse.de>
 <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com> <6faa7b93-a355-f7ba-e5e9-12f2414ac695@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <6faa7b93-a355-f7ba-e5e9-12f2414ac695@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Aleksa Sarai <asarai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 6, 2017 at 1:05 PM, Aleksa Sarai <asarai@suse.de> wrote:
>>> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
>>> index 65799575c666..2a6bd9ae3f8b 100644
>>> --- a/drivers/tty/pty.c
>>> +++ b/drivers/tty/pty.c
>>> @@ -481,6 +481,16 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
>>>          return -ENOIOCTLCMD;
>>>   }
>>>
>>> +static long pty_bsd_compat_ioctl(struct tty_struct *tty,
>>> +                                unsigned int cmd, unsigned long arg)
>>> +{
>>> +       /*
>>> +        * PTY ioctls don't require any special translation between
>>> 32-bit and
>>> +        * 64-bit userspace, they are already compatible.
>>> +        */
>>> +       return pty_bsd_ioctl(tty, cmd, arg);
>>> +}
>>> +
>>
>>
>> This looks correct but unnecessary, you can simply point both
>> function pointers to the same function:
>
>
> They have different types, since they have different return types:
>
> int  (*ioctl)(struct tty_struct *tty,
>             unsigned int cmd, unsigned long arg);
> long (*compat_ioctl)(struct tty_struct *tty,
>                      unsigned int cmd, unsigned long arg);
>
> If you like, I can change (*ioctl) to return longs as well, and then change
> all of the call-sites (since unlocked_ioctl also returns long).

Ah, my mistake. In most other data structures that have a compat_ioctl
callback pointer, the prototypes are the same, and I had not realized
that tty_operations is an exception.

        Arnd
