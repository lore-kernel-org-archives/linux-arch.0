Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeCPUdZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 16:33:25 -0400
Subject: Re: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for
 clarity
References: <87k1wimybi.fsf_-_@xmission.com>
 <20180116004009.31036-13-ebiederm@xmission.com>
 <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
 <818f8945-f990-a770-476e-f82bdc77dbda@intel.com>
 <87efkjeqe8.fsf@xmission.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ccd9afa6-15d1-3e41-c1a4-3352d09c37a4@intel.com>
Date: Fri, 16 Mar 2018 13:33:16 -0700
MIME-Version: 1.0
In-Reply-To: <87efkjeqe8.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Message-ID: <20180316203316.xeTcbiI_yAQkEPYBrPXR9DwRJBJBZUMtjyl-PO98n-M@z>

On 03/16/2018 01:06 PM, Eric W. Biederman wrote:
>> It does not revert cleanly so I reverted it manually.  Patch doing that
>> is attached.  Should we do this, or is there a better option?
> Please see:
> 859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")

It would be really nice to actually cc the folks that wrote and maintain
the code when you both break their stuff and fix it.  I don't see myself
or the x86 maintainers cc'd on any of this: the patch that caused the
breakage *or* the fix.
