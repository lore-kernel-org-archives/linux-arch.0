Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57424 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab0KUVrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 21 Nov 2010 16:47:23 -0500
MIME-Version: 1.0
In-Reply-To: <20101121090707.GA5016@liondog.tnic>
References: <4ce85e437577ae827@agluck-desktop.sc.intel.com>
	<20101121090707.GA5016@liondog.tnic>
Date: Sun, 21 Nov 2010 13:47:22 -0800
Message-ID: <AANLkTincT5w82v0964Pfaw+yudmDC2D1uGkC9p6_N23_@mail.gmail.com>
Subject: Re: [RFC] persistent store
From: Tony Luck <tony.luck@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, greg@kroah.com, akpm@linux-foundation.org, ying.huang@intel.com
Message-ID: <20101121214722.SNxhax8g9O_F09NzpP2vMAzzB-WMCBkAbFePlRlUklk@z>

On Sun, Nov 21, 2010 at 1:07 AM, Borislav Petkov <bp@alien8.de> wrote:
> this is actually very cool.

Thanks for looking at it (and more thanks for this endorsement!)

>> 1) "Why do you only allow one platform driver to register?"
>>   I only have one such driver.  Adding more is easy from the "read" side
>>   (just collect all the records from all devices and remember where they
>>   came from so you can call the correct "eraser" function).  But the "write"
>>   side opens up questions that I don't have good answers for:
>>   - Which device(s) should error records be written to?
>>     All of them? Start with one and move on when it is
>>     full?  Write some types of records to one device?
>
> Maybe based on the error type? We definitely need one device which
> should contain all the records, something like main pstore device.

But who decides which records go where? And which device gets to be
the "main" one?  I don't think that we can usefully do this in the
registration mechanism (how does a driver know that other drivers even
exist?).  I continue to want to defer this until someone with two or more
devices on one machine steps forward.

>> 3) "/sys/firmware/pstore is the wrong pathname for this".
>>   You are probably right. I put it under "firmware" because that's where
>>   the "efivars" driver put its top level directory. In my case the ERST
>>   back end is firmware, so there is some vague logic to it ... but better
>>   suggestions are welcome. Perhaps /sys/devices/platform/pstore?
>>
>> 4) "/sys is the wrong place for this."
>>   Perhaps.  I definitely want to use some sort of filesystem interface (so
>>   each record shows up as a file to the user). This seems a lot cleaner
>>   than trying to map the semantics of actual persistent storage devices
>>   onto a character device.  The "sysfs_create_bin_file()" API seems very
>>   well designed for this usage.  If not /sys, then where?  "debugfs"
>>   would work - but not everyone mounts debugfs. Creating a whole new
>>   filesystem for this seems like overkill.
>
> No, I think /sys is the right place for it being always present and
> all. Besides, for example, all the ACPI tables are there anyway
> (/sys/firmware/acpi/tables/) so pstore won't be the first blob there.

Heh! The acpi tables code is where I found out how easy it was to handle
blobs bigger than PAGE_SIZE using memory_read_from_buffer().
>
> /sys/firmware might not be all that sensible if someone comes up with
> persistent storage type which is the network but we'll change that then.

I'd like to get the right place first time - change means having to update
any applications that coded in the pathname.

>> +int
>> +pstore_register(struct pstore_info *psi)
>> +{
>> +     struct  pstore_entry    *new_pstore;
>> +     int     rc = 0, type;
>> +     unsigned long size;
>> +     u64     id;
>> +     unsigned long ps_maxsize;
>
> Alignment here? Maybe something like this:
>
>        struct pstore_entry     *new_pstore;
>        unsigned long           ps_maxsize;
>        int                     rc = 0, type;

Are you talking about textual alignment of the declarations? Yours
does look prettier.

>> +
>> +     spin_lock(&pstore_lock);
>> +     if (psinfo) {
>> +             spin_unlock(&pstore_lock);
>> +             return -EBUSY;
>> +     }
>> +     psinfo = psi;
>> +     spin_unlock(&pstore_lock);
>
> Maybe make this lockless with cmpxchg? OTOH, the spinlock would be
> easier when you have multiple persistent storage devices...

cmpxchg would make the code shorter - I'll try recoding and see if I like
the way it looks.

>> +     ps_maxsize = psi->header_size + psi->data_size + psi->footer_size;
>> +     pstore_buf = kzalloc(ps_maxsize, GFP_KERNEL);
>> +     if (!pstore_buf)
>> +             return -ENOMEM;
>
> newline

Yup. Will fix.

>> +int
>> +pstore_write(int type, char *buf, unsigned long size)
>> +{
>> +     if (!psinfo->writer)
>> +             return -ENODEV;
>
> I think you should move this check to the pstore_register() above. We
> don't want persistent storage backends which do not implement ->write
> anyway since the whole point of them becomes moot, no?

Doh! Yes, of course.  Will fix.

>> +     list_del(&search_pstore->list);
>> +
>> +     spin_unlock(&pstore_lock);
>> +
>> +     sysfs_remove_bin_file(&pstore_kset->kobj, &search_pstore->attr);
>
> AFAICT, you might want to remove the sysfs file _before_ you remove it
> from the pstore list/erase its contents, otherwise concurrent accesses
> to it from userspace readers might make us go boom.

I'll think about the ordering.  I have three things to do here:
1) Remove from the pstore_list
2) Call platform driver to erase from store
3) Call sysfs to remove the binfile.

Potentially the erase could fail ... and I should probably notice
that and do something.

>> +/* types */
>> +#define      PSTORE_DMESG    0
>> +#define      PSTORE_MCE      1
>
> maybe PSTORE_TYPE_DMESG/PSTORE_TYPE_MCE ?

Much better (I suck at naming things).  Will fix.

-Tony
