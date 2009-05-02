From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] driver-core: devtmpfs - driver core maintained /dev tmpfs
Date: Sat, 2 May 2009 23:59:20 +0200
Message-ID: <ac3eb2510905021459v41bccb5dy90eba3ed52d9b860@mail.gmail.com>
References: <1241097822.2516.3.camel@poy> <20090502071636.GA9487@infradead.org>
	<ac3eb2510905020434k57b561f7ld3db423f3dba26f0@mail.gmail.com>
	<9b2b86520905021322l31845d2dubad98d78380aa1d5@mail.gmail.com>
	<9b2b86520905021441r76ba0b73u1ef02b5aa855a02b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:64218 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761391AbZEBV7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 May 2009 17:59:36 -0400
In-Reply-To: <9b2b86520905021441r76ba0b73u1ef02b5aa855a02b@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Jan Blunck <jblunck@suse.de>, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, adam@yggdrasil.com

On Sat, May 2, 2009 at 23:41, Alan Jenkins
<sourcejedi.lkml@googlemail.com> wrote:
> On 5/2/09, Alan Jenkins <sourcejedi.lkml@googlemail.com> wrote:
>> On 5/2/09, Kay Sievers <kay.sievers@vrfy.org> wrote:
>>> On Sat, May 2, 2009 at 09:16, Christoph Hellwig <hch@infradead.org>
>>> wrote:
>>>> >After the rootfs is mounted by the kernel, the
>>>>> populated tmpfs is mounted at /dev. In initramfs, it can be moved
>>>>> to the manually mounted root filesystem before /sbin/init is
>>>>> executed.
>>>>
>>>> That for example is something that is not acceptable. =C2=A0We rea=
lly don't
>>>> want the kernel to mess with the initial namespace in such a major=
 way.
>>>
>>> There is nothing like "mess around", it's not mounted at all, until
>>> the kernel mounts the root filesystem at /, then devtmpfs is mounte=
d
>>> the first time, and only if it's compiled in because you asked for =
it.
>>> Also, just try:
>>> =C2=A0 egrep 'mknod|create_dev' init/*.c
>>> and see what we currently do.
>>>
>>>> Counter-proposal: =C2=A0Re-introduce a proper mini-devfs. =C2=A0Al=
l nodes in there
>>>> are kernel-created and not changeable which sorts out that whole
>>>> mess of both drivers and userspace messing with tree topology we h=
ad
>>>> both in original devfs and this new devtmpfs. =C2=A0Single-instanc=
e so it can
>>>> be
>>>> populated before it's actually mounted somewhere, that way the ker=
nel
>>>> doesn't have to do any policy devicision on where it's mounted.
>>>
>>> That sounds worse than devtpfs, and does not help for most of the
>>> mentioned problems we are trying to solve here.
>>
>> On a narrow issue: do you really object to moving the "mount dev -t
>> devfs2 /dev" into userspace (and therefore giving it a user-visible
>> name)?? =C2=A0That would address Cristophs particular objection abou=
t
>> "messing around" with the initial namespace. =C2=A0It means I can be=
 100%
>> sure I can boot an old initramfs with this option enabled. =C2=A0And=
 it
>> gives a nice clean way for new initramfs' to test for this feature -
>> when they try to mount it, it fails. =C2=A0It would seem to make for=
 a
>> rather smoother migration path.
>>
>> It shouldn't mean too many more LOC, you're already doing the "singl=
e
>> instance" thing.
>
> Also, AFAICS this would avoid a memory leak on umount.
>
> In it's original form, if you unmount it, you can't get it back. =C2=A0=
But
> it doesn't get destroyed either; all the tmpfs nodes just hang around
> in limbo, right?

Sure you can't get it back if you drop it, but what would be the point
of un-mounting it and wanting it back? It's just like every other
tmpfs too. :)

> It'd be even nicer if it somehow avoided consuming memory when it
> isn't used.

It's probably easy to make it destroy itself, and free everything, if
it's un-mounted, if that solves your concerns about built-in but not
used.

> I guess that requires more code, looks more like a "real"
> devfs, and as C. says is probably more sane if exported as a read
> only. =C2=A0Hopefully it would make it possible to remove the code
> afterwards, but that sounds like even more work.

Then you should probably not enable it, or have a boot option to
disable it. What's the point in removing it later, it is exactly what
you want, and what everybody has today, a /dev on tmpfs, just that the
kernel will puts the default nodes in there.

> But is read-only so bad? =C2=A0You just have to copy it over to a tmp=
fs and
> then mount that on top of /dev. =C2=A0That's atomic, so it won't inte=
rfere
> with parallel early init. =C2=A0I sympathize, devtmpfs is a really ne=
at
> hack that does exactly what udev needs. =C2=A0But you have to admit, =
it
> doesn't fit in _quite_ as well with the kernel status quo.

I think it fits quite nice as a "device node companion" to sysfs. And
I don't really see the point of a read-only mount, it should be the
/dev that is used on the real system, until you shut it down.

Thanks,
Kay
