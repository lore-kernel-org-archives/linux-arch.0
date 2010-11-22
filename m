From: Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC] persistent store
Date: Mon, 22 Nov 2010 08:55:34 -0800
Message-ID: <AANLkTi=fNH4-VjLh1zzk-UdEQevR16_K8igdLeodw6yL@mail.gmail.com>
References: <4ce85e437577ae827@agluck-desktop.sc.intel.com>
	<1290391175.2903.132.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290391175.2903.132.camel@yhuang-dev>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Nov 21, 2010 at 5:59 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> This patch provides a general "read" interface for kmsg_dumper and so=
me
> other persistent storage users. Another possible choice is to just
> extend the original interface to add persistent store support. For
> example, we can add a "read" function in kmsg_dumper, and output the
> content of persistent store via extend /dev/kmsg via prefix every lin=
e
> comes from persistent store or adding some "ioctl" to do that. (But i=
t
> seems that nobody likes "ioctl").

In Linux (and Unix before it) "everything is a file" ... but this
doesn't work very well if the file has internal structure (e.g.
is made of records that can be individually changed or
deleted).  A filesystem seems a much better model.

>> "writer" which writes a record with a type to the persistent store
>
> I think it is necessary to require this to be NMI safe (in comments?)=
,
> because hardware error handler may need to write to persistent storag=
e
> in NMI context. Or we can add a "flag" field to let storage provider
> advocate its capability of NMI safe.

I can add a comment to pstore.h to document the NMI-safe
requirement for the "writer" function.

>> =A0 - Which device(s) should error records be written to?
>> =A0 =A0 All of them? Start with one and move on when it is
>> =A0 =A0 full? =A0Write some types of records to one device?
>
> The persistent storage may be full, and the writing may fail. So I th=
ink
> we can just try to write one by one, until the first success writing.

A good option - if we ever find someone luck enough to have
more than one persistent store device.

>> + =A0 =A0 =A0 sysfs_remove_bin_file(&pstore_kset->kobj, &search_psto=
re->attr);
>
> It seems that the corresponding memory is not freed after erasing.

Ouch!  Good catch.  Will add a kfree()

-Tony
