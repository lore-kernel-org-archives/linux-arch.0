From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Tue, 14 Jun 2016 14:11:48 +0800
Message-ID: <575FA024.7060608@linux.vnet.ibm.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <20160608092244.GA27029@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33227 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226AbcFNGMD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jun 2016 02:12:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5E5wgKC130415
	for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2016 02:12:03 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23geqntd23-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2016 02:12:02 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Tue, 14 Jun 2016 16:11:57 +1000
In-Reply-To: <20160608092244.GA27029@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, waiman.long@hp.com, peterz@infradead.org


On 2016=E5=B9=B406=E6=9C=8808=E6=97=A5 17:22, Will Deacon wrote:
> On Thu, Jun 02, 2016 at 06:09:08PM +0800, Pan Xinhui wrote:
>> strcut __qrwlock has different layout in big endian machine. we need=
 set
>> the __qrwlock->wmode to NULL, and the address is not &lock->cnts in =
big
>> endian machine.
>>
>> Do as what read unlock does. we are lucky that the __qrwlock->wmode'=
s
>> val is _QW_LOCKED.
>
> Doesn't this have wider implications for the qrwlocks, for example:
>
>    while ((cnts & _QW_WMASK) =3D=3D _QW_LOCKED) { ... }
>
> would actually end up looking at the wrong field of the lock?
>
I does not clearly understand your idea. :(
the condition in the while() is always true from the view of current co=
de.
BUT if __qrwlock has same layout on the two endian machine, the while()=
 will end up. :)


> Shouldn't we just remove the #ifdef __LITTLE_ENDIAN stuff from __qrwl=
ock,
> given that all the struct members are u8?
>
No. that makes codes complex. for example

struct __qrwlock lock;

WRITE_ONCE(lock->wmode, _QW_WAITING);
if (atomic_(&lock->cnts) =3D=3D _QW_WAITING) {
	do_something();
}

IF you remove the  #ifdef __LITTLE_ENDIAN stuff from __qrwlock.
codes above obviously will break. And we already have such code.

thanks
xinhui

> Will
>
