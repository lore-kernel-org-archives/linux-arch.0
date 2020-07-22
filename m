From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC] raw_copy_from_user() semantics
Date: Wed, 22 Jul 2020 13:14:21 +0000
Message-ID: <8fde1b9044a34ff59eb5ff3dafbf2b97@AcuMS.aculab.com>
References: <20200719031733.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
 <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
 <20200722113707.GC27540@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200722113707.GC27540@gaia>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Catalin Marinas' <catalin.marinas@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

From: Catalin Marinas
> Sent: 22 July 2020 12:37
> 
> On Sun, Jul 19, 2020 at 12:34:11PM -0700, Linus Torvalds wrote:
> > On Sun, Jul 19, 2020 at 12:28 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > I think we should try to get rid of the exact semantics.
> >
> > Side note: I think one of the historical reasons for the exact
> > semantics was that we used to do things like the mount option copying
> > with a "copy_from_user()" iirc.
> >
> > And that could take a fault at the end of the stack etc, because
> > "copy_mount_options()" is nasty and doesn't get a size, and just
> > copies "up to 4kB" of data.
> >
> > It's a mistake in the interface, but it is what it is. But we've
> > always handled the inexact count there anyway by originally doing byte
> > accesses, and at some point you optimized it to just look at where
> > page boundaries might be..
> 
> And we may have to change this again since, with arm64 MTE, the page
> boundary check is insufficient:
> 
> https://lore.kernel.org/linux-fsdevel/20200715170844.30064-25-catalin.marinas@arm.com/
> 
> While currently the fault path is unlikely to trigger, with MTE in user
> space it's a lot more likely since the buffer (e.g. a string) is
> normally less than 4K and the adjacent addresses would have a different
> colour.
> 
> I looked (though briefly) into passing the copy_from_user() problem to
> filesystems that would presumably know better how much to copy. In most
> cases the options are string, so something like strncpy_from_user()
> would work. For mount options as binary blobs (IIUC btrfs) maybe the fs
> has a better way to figure out how much to copy.

What about changing the mount code to loop calling get_user()
to read aligned words until failure?
Mount is fairly uncommon and the extra cost is probably small compared
to the rest of doing a mount.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
