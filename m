From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Wed, 3 Oct 2018 13:21:59 +0000
Message-ID: <71b13208253f4b3fa82640ec96bf9301@AcuMS.aculab.com>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <1f1d699b1c8d472495a5b07199c31a6e@AcuMS.aculab.com>
 <20181001161535.3zslyuk6vmnpioy6@ryuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001161535.3zslyuk6vmnpioy6@ryuk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Aleksa Sarai' <cyphar@cyphar.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dev@opencontainers.org" <dev@opencontainers.org>, "containers@lists.linux-foundation.org" <containers@lists.linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

From: Aleksa Sarai
> Sent: 01 October 2018 17:16
> 
> On 2018-10-01, David Laight <David.Laight@ACULAB.COM> wrote:
...
> > >   * Mountpoint crossings are blocked by AT_XDEV.
> >
> > You might want a mountpoint flag that allows crossing into the mounted
> > filesystem (you may need to get out in order to do pwd()).
> 
> Like a mount flag? I'm not sure how I feel about that. The intention is
> to allow for a process to have control over how path lookups are
> handled, and tying it to a mount flag means that it's no longer entirely
> up to the process.

Right, but you may have some mount points that you don't want to cross
and others that it is perfectly fine to cross.
For example you might want to be able to cross into a 'tmp' filesystem.

...
> > If you make the flags a property of the directory vnode (perhaps as
> > well as any syscall flags), and make it inherited by vnode lookup then
> > it can be used to stop library functions (or entire binaries) using
> > blocked paths.
> > You'd then only need to add an fcntl() call to set the flags (but never
> > clear them) to get the restriction applied to every lookup.
> 
> This seems like it might be useful, but it could always be done as a
> follow-up patch by just setting LOOKUP_BLAH if the dirfd has the flag
> set. I'm also a little bit concerned that (because fd flags are set on
> the 'struct file') if you start sharing fds then you can no longer use
> the lookup scoping for security (a racing process could remove the
> flags while the management process resolves through it).

I was thinking that the flags would never be removable.
A management process might have to flip its cwd back and forth
in order to clear the flags (opendir(".") should give a different
struct file).

This all gets tied up with the slight requirement for per-thread cwd.

I had another thought that the crudentials structure used for a file
lookup could also be taken from the cwd (not sure how it would
get there - especially if you need the correct group list).
That would allow a 'management' process to open a file in the context
of the target user process.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
