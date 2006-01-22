Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:22716 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750945AbWAVRqG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 22 Jan 2006 12:46:06 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0MHk5ij023962
	for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2006 12:46:05 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0MHk6fI120070
	for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2006 12:46:06 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0MHk5sd008677
	for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2006 12:46:06 -0500
Message-ID: <43D3C4CB.30801@us.ibm.com>
Date: Sun, 22 Jan 2006 12:45:47 -0500
From: JANAK DESAI <janak@us.ibm.com>
MIME-Version: 1.0
Subject: Re: new syscalls
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com> <20060118133629.1cda96fd.akpm@osdl.org>
In-Reply-To: <20060118133629.1cda96fd.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>, David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton wrote:

>"Luck, Tony" <tony.luck@intel.com> wrote:
>  
>
>>>Various new syscalls which are trickling their way Linuswards and will need
>>>testing and wiring up once they get there:
>>>      
>>>
>>Are there test-suites for any/all of these new calls?
>>
>>    
>>
>
>That's an excellent point.
>
>Guys, architecture maintainers need test suites to verify that the syscalls
>actually work as they wire them up.  Please share.  A stable URL would be
>preferred - something which can go into the changlog or conceivably into
>the kernel source.
>
>Thanks.
>
>  
>
Hi Andrew,

I apologize for not sending out the unshare test program by Friday as I had
promised. I got distracted with a strange problem with rmdir. Steve Grubb
first noticed it while testing the pam module that uses unshare. I was 
able to
reproduce the problem with one of my unshare testcases as well. Initially
I suspected the unshare code, however the problem appears to be in the
base code. I am doing some additional debugging now, so I can narrow
down the release/patch that introduced the problem. Once I gather useful
information, I will email Ram Pai and Al Viro with the appropriate
information (hopefully by tonight) and a small test program that can
reproduce the problem. My new ETA for unshare test is by tomorrow
night.

Thanks.

-Janak
