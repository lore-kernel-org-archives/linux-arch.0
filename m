Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46540 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772AbXIIVJh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Sep 2007 17:09:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [discuss] [patch 3/5] Use extended crashkernel command line on x86_64
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.951336895@strauss.suse.de>
	<86802c440709091027o32a63d11w629bad87abcc19c2@mail.gmail.com>
	<20070909185257.GA10600@suse.de>
Date: Sun, 09 Sep 2007 15:06:55 -0600
In-Reply-To: <20070909185257.GA10600@suse.de> (Bernhard Walle's message of
	"Sun, 9 Sep 2007 20:52:58 +0200")
Message-ID: <m1ir6jsg40.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Vivek Goyal <vgoyal@in.ibm.com>, linux-arch@vger.kernel.org, discuss@x86-64.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Bernhard Walle <bwalle@suse.de> writes:

> * Yinghai Lu <yhlu.kernel@gmail.com> [2007-09-09 19:27]:
>> >
>> > +#ifdef CONFIG_KEXEC
>> ...
>> 
>> CONFIG_KEXEC or CONFIG_CRASH_DUMP?
>
> Good question. The crashkernel parameter was CONFIG_KEXEC before, and
> I also wondered why, but I didn't change this because maybe there's
> some reason I don't know.
>
> Vivek, do you know why this was CONFIG_KEXEC?

Probably because you use it in the primary kernel you use it.
The option reserves an area of memory for the kernel we switch
to on panic or another kernel crash.

Generally CONFIG_CRASH_DUMP seems to be about the options needed
to read out the crash dump after the fact.

Eric
