Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([69.30.125.51]:41702 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1161422AbWATAe7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jan 2006 19:34:59 -0500
Received: from [10.107.17.130]
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1B85DA> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 19 Jan 2006 16:34:52 -0800
Date: Thu, 19 Jan 2006 16:34:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: new syscalls
In-Reply-To: <43D02D85.90100@redhat.com>
Message-ID: <Pine.LNX.4.63.0601191629160.6527@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
 <20060118133629.1cda96fd.akpm@osdl.org> <Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
 <20060118172802.5155048f.akpm@osdl.org> <Pine.LNX.4.63.0601191347160.6527@localhost.localdomain>
 <Pine.LNX.4.63.0601191606300.6527@localhost.localdomain> <43D02D85.90100@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-arch-owner@vger.kernel.org
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, dwmw2@infradead.org, dhowells@redhat.com, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 19 Jan 2006, Ulrich Drepper wrote:

> Davide Libenzi wrote:
>> There is a problem with the test we have inside the kernel about the
>> size of sigset_t, from the kernel (8 bytes on i386) and the glibc one
>> (128 bytes):
>
> Not really a problem.  We always pass down _NSIG/8 as the size.

Ok, I use _NSIG/8 inside the test software now.



- Davide


