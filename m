From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 01/11] sysctl: Separate the binary sysctl logic into it's own file.
Date: Fri, 06 Nov 2009 05:58:43 -0800
Message-ID: <m1vdhnzre4.fsf@fess.ebiederm.org>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
	<200911061310.02785.arnd@arndb.de> <m1ljij24p0.fsf@fess.ebiederm.org>
	<200911061411.19580.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:50473 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZKFN6o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2009 08:58:44 -0500
In-Reply-To: <200911061411.19580.arnd@arndb.de> (Arnd Bergmann's message of "Fri\, 6 Nov 2009 14\:11\:19 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday 06 November 2009, Eric W. Biederman wrote:
>> The primary proc path already doesn't need the lock_kernel().  My next
>> patch winds up killing the entire binary path and rebuilding on top of
>> /proc/sys.  Which removes that lock_kernel().
>> 
>> Which I think elegantly solves all of the sysctl BKL lock issues.
>
> Yes, that sounds like an excellent plan, but I'm not completely sure
> if the lack of the BKL in the procfs case is intentional. As a
> particular case that I stumbled over, 'core_pattern' is read
> with the BKL held to protect against sysctl changing it, but
> it is changed with proc_dostring without the BKL.

Then that is a bug.  The bottom line is sys_sysctl never gets used
in practice, making the proc interface normative.

> Most uses of intvec or string seem to be racy and probably need
> a proper serialization method anyway.

That sounds familiar.  Of course in practice the changes are rare
enough and are of static variables that don't get reallocated
that I would be surprised if the lack of lacking ever causes
more more than temporary strange behavior.

Eric
