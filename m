Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35246 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161204AbWASNui (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jan 2006 08:50:38 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0JDobBO003698
	for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2006 08:50:37 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0JDobiA116452
	for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2006 08:50:38 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0JDoZdk021207
	for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2006 08:50:37 -0500
Message-ID: <43CF9921.9070908@us.ibm.com>
Date: Thu, 19 Jan 2006 08:50:25 -0500
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

I have to finish up a couple of things today, but will post the unshare 
test by tomorrow.

Thanks.

-Janak
