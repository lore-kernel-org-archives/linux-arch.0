From: Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC] persistent store (version 3) (part 1 of 2)
Date: Wed, 8 Dec 2010 09:12:21 -0800
Message-ID: <AANLkTin7xDWO8fU2WA7cxC55TNi2+kAb50ajCySCfg9G@mail.gmail.com>
References: <4cfd2b97258571235f@agluck-desktop.sc.intel.com>
	<20101208062433.GB29751@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36758 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0LHRMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2010 12:12:22 -0500
In-Reply-To: <20101208062433.GB29751@liondog.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, greg@kroah.com, akpm@l

On Tue, Dec 7, 2010 at 10:24 PM, Borislav Petkov <bp@alien8.de> wrote:
> looks good. Minor nitpicks below.

Thanks for looking at this.

>> 1) Is "struct file" too big to be on the stack? I can change it to k=
malloc() it.
>
> Well, this happens during normal operation when we init the pstore an=
d
> since we don't need it after pstore_mkwrite has returned (do we?), I
> guess we should be fine.
struct file is 184 bytes (with the CONFIG options I am using, it can ge=
t
a bit larger, but not much).

>> + =A0 =A0 =A0 =A0 =A0 =A0 the dying moments. =A0In the case of a pan=
ic() the last part
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"panic" (I'd remove the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bracke=
ts)

Ok. Will do.

>> + =A0 =A0 dentry =3D d_alloc_name(root, name);
>> + =A0 =A0 if (!IS_ERR(dentry))
>> + =A0 =A0 =A0 =A0 =A0 =A0 d_add(dentry, inode);
>
> what happens if it IS_ERR? Error handling like
>
> =A0 =A0 =A0 =A0goto d_alloc_error;
>
> d_alloc_error:
> =A0 =A0 =A0 =A0iput(inode);
> =A0 =A0 =A0 =A0return -ENOSPC;
>
>
> or similar, at least this is what ramfs seems to be doing.

Good point - I need to clean up if things fail (and akpm would
like to see me re-factor so that there is only one "return"
statement for better maintainabiliy).  I'll fix up stuff here.

>> + =A0 =A0 kmsg_dump_register(&pstore_dumper);
>
> You don't check psi->write() method's existence anymore, I'm assuming
> this is implied now... ?

Andrew's comments on version 2 were:
>It doesn't seem appropriate to check this here.  It's a programming
>error!  Just install the thing and let the kernel oops - the programme=
r
>will notice.

So I dropped the tests ... just checking whether the function pointer
was NULL wasn't a very strong test anyway.

>> + =A0 =A0 if (!psinfo)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> newline.

OK.

>> +#define PSTOREFS_MAGIC =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x6165676C
>
> what does that mean anyway? "aegl" :)

My initials: Anthony Eric George Luck. I've been using "aegl"
as my Unix login since 1979 (6th Edition on a pdp11/34).

>> +/* types */
>> +#define =A0 =A0 =A0PSTORE_TYPE_DMESG =A0 =A0 =A0 0
>> +#define =A0 =A0 =A0PSTORE_TYPE_MCE =A0 =A0 =A0 =A0 1
>
> You could make this into a proper enum
>
> enum pstore_type_id {
> =A0 =A0 =A0 =A0PSTORE_TYPE_DMESG =A0 =A0 =A0 =3D 0,
> =A0 =A0 =A0 =A0PSTORE_TYPE_MCE =A0 =A0 =A0 =A0 =3D 1,
> =A0 =A0 =A0 =A0PSTORE_TYPE_MAX,
> };
OK. Type checking is nice.  I think I might need a
PSTORE_TYPE_UNKNOWN to handle the case
where a new platform driver saves a record to
persistent store, and then the user boots an older
kernel that doesn't know about the new type (in
the APEI/ERST driver the type turns into a UUID
in the UEFI header for the record - so there is some
mapping going on at that level).

>> +struct pstore_info {
>> + =A0 =A0 struct module =A0 *owner;
>> + =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0*name;
>> + =A0 =A0 struct mutex =A0 =A0mutex; =A0/* serialize access to 'buf'=
 */
>
> =A0[ maybe a more descriptive variable name like buf_mutex or whateve=
r ]

Sure. Will change.

>> +#if defined(CONFIG_PSTORE) || defined(CONFIG_PSTORE_MODULE)
>
> What is CONFIG_PSTORE_MODULE? Can't seem to find it in your (2 of 2)
> message either.

This is a remnant of when PSTORE was tristate - when I chose 'm'
rather than 'y' in "make menuconfig" I ended up with CONFIG_PSTORE_MODU=
LE
rather than CONFIG_PSTORE.  But now it is just a "bool" this isn't
needed any more. Will fix.

-Tony
