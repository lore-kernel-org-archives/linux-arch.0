Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26734 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcCGSkd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 13:40:33 -0500
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
References: <1456951177-23579-1-git-send-email-khalid.aziz@oracle.com>
 <20160305.230702.1325379875282120281.davem@davemloft.net>
 <56DD9949.1000106@oracle.com> <56DD9E94.70201@oracle.com>
 <CALCETrXey2_xEXhzjgHtZmf-dLp-9pec===d-8chLxrp8wgRXg@mail.gmail.com>
 <56DDA6FD.4040404@oracle.com> <56DDBE68.6080709@linux.intel.com>
 <CALCETrWPeFsyGsDNyehMpub1QrjZxyWpG_x_2A0yKqROXYfJ5A@mail.gmail.com>
 <56DDC47C.8010206@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <56DDCAD3.3090106@oracle.com>
Date: Mon, 7 Mar 2016 11:39:15 -0700
MIME-Version: 1.0
In-Reply-To: <56DDC47C.8010206@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Rob Gardner <rob.gardner@oracle.com>, David Miller <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, chris.hyser@oracle.com, Richard Weinberger <richard@nod.at>, Vlastimil Babka <vbabka@suse.cz>, Konstantin Khlebnikov <koct9i@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Greg Thelen <gthelen@google.com>, Jan Kara <jack@suse.cz>, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, Andrew Lutomirski <luto@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, bsegall@google.com, Geert Uytterhoeven <geert@linux-m68k.org>, Davidlohr Bueso <dave@stgolabs.net>, Alexey Dobriyan <adobriyan@gmail.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20160307183915.ny-2xUmXcVJzK0M1Qx2kBg9fJgYlq2zoQgJePIS8sk8@z>

On 03/07/2016 11:12 AM, Dave Hansen wrote:
> On 03/07/2016 09:53 AM, Andy Lutomirski wrote:
>> Also, what am I missing?  Tying these tags to the physical page seems
>> like a poor design to me.  This seems really awkward to use.
>
> Yeah, can you describe the structures that store these things?  Surely
> the hardware has some kind of lookup tables for them and stores them in
> memory _somewhere_.
>

Version tags are tied to virtual addresses, not physical pages.

Where exactly are the tags stored is part of processor architecture and 
I am not privy to that. MMU stores these lookup tables somewhere and 
uses it to authenticate access to virtual addresses. It really is 
irrelevant to kernel how MMU implements access controls as long as we 
have access to the knowledge of how to use it.

Thanks,
Khalid

