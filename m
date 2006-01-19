Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([69.30.125.51]:39905 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1161139AbWASBRW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 20:17:22 -0500
Received: from [10.107.17.130]
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1B8210> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 18 Jan 2006 17:17:20 -0800
Date: Wed, 18 Jan 2006 17:17:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: new syscalls
In-Reply-To: <20060118133629.1cda96fd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
 <20060118133629.1cda96fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>, Ulrich Drepper <drepper@redhat.com>, David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 18 Jan 2006, Andrew Morton wrote:

> "Luck, Tony" <tony.luck@intel.com> wrote:
>>
>>> Various new syscalls which are trickling their way Linuswards and will need
>>> testing and wiring up once they get there:
>>
>> Are there test-suites for any/all of these new calls?
>>
>
> That's an excellent point.
>
> Guys, architecture maintainers need test suites to verify that the syscalls
> actually work as they wire them up.  Please share.  A stable URL would be
> preferred - something which can go into the changlog or conceivably into
> the kernel source.

How sophisticated this has to be? And what's the expected ETA? The 
epoll_pwait is really a wrapper around epoll_wait (that did not change at 
all), so the test in this case should just make sure that the signal 
behaviour is the one expected.



- Davide


