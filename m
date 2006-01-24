Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:22935 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750858AbWAXXog
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jan 2006 18:44:36 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0ONiaNJ004292
	for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2006 18:44:36 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0ONgoiD247094
	for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2006 16:42:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0ONiZ3S006983
	for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2006 16:44:36 -0700
Message-ID: <43D6BBCA.3090706@us.ibm.com>
Date: Tue, 24 Jan 2006 18:44:10 -0500
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
Here is the link to a program for testing unshare system call.

http://prdownloads.sourceforge.net/audit/unshare_test.c?download

Please note that because of a problem in rmdir associated with
bind mounts and clone with CLONE_NEWNS, the test fails while
trying to remove temporary test directory. You can remove that
temporary directory by doing rmdir, twice, from the command line.
The first will fail with EBUSY, but the second will succeed. I have
reported the problem to Ram Pai and Al Viro with a small program
which reproduces the problem. Al told us yesterday that he will
be looking at the problem soon. I have tried multiple rmdirs from
the unshare_test program itself, but for some reason that is not
working. Doing two rmdirs from command line does seem to
remove the directory.

Please let me know if you have trouble downloading/running
the program.

-Janak

