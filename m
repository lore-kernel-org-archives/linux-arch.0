Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18805 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdJSRdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2017 13:33:22 -0400
Subject: Re: [PATCH 1/4][PoC][RFC] sched: Allow to get() and put() signal
 struct
From: Krzysztof Opasiak <k.opasiak@samsung.com>
Message-ID: <bb167290-4373-25a5-ef8e-5330a7cde425@samsung.com>
Date: Thu, 19 Oct 2017 19:33:12 +0200
MIME-version: 1.0
In-reply-to: <20171019073418.GC20787@kroah.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
References: <20171018203230.29871-1-k.opasiak@samsung.com>
        <CGME20171018203328epcas2p4bdcc3650d1c0f0add143488792243932@epcas2p4.samsung.com>
        <20171018203230.29871-2-k.opasiak@samsung.com>
        <20171019073418.GC20787@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: viro@zeniv.linux.org.uk, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com
Message-ID: <20171019173312.hvWvPl5qefZTvzvgafYNZi6fLi36qld0p7lzuYgEUxw@z>



On 10/19/2017 09:34 AM, Greg KH wrote:
> On Wed, Oct 18, 2017 at 10:32:27PM +0200, Krzysztof Opasiak wrote:
>> Allow to get() and put() signal struct from different
>> parts of kernel core, not only from signal.c.
> 
> That says what this does, but not _why_.  Who would ever want to have
> access to these internal-only functions?
> 

Those functions are exposed because I added rlimit-events context to the 
signal_struct and because I'm accessing signal struct of subject 
(process that's being monitored) from context of monitor I need to 
ensure that this structure won't go away until I release all watchers 
that were associated with that process.

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
