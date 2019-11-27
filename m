Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lithops.sigma-star.at ([195.201.40.130]:35472 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfK0O2l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Nov 2019 09:28:41 -0500
Date: Wed, 27 Nov 2019 15:28:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <48783237.99334.1574864917843.JavaMail.zimbra@nod.at>
In-Reply-To: <m2wobmq7v8.wl-thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com> <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at> <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net> <243342257.98153.1574762974057.JavaMail.zimbra@nod.at> <98acf77a7c6f6cba7f76c12a850ac2929b9e5a48.camel@sipsolutions.net> <CAMoF9u3LRC_NaVJzmKPc0+XBxhAqdhnr4-ZzY_ypwQEzUz78yQ@mail.gmail.com> <293078386.98317.1574784295793.JavaMail.zimbra@nod.at> <m2wobmq7v8.wl-thehajime@gmail.com>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: tavi purdila <tavi.purdila@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>, linux-um <linux-um@lists.infradead.org>, retrage01 <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, pscollins <pscollins@google.com>, sigmaepsilon92 <sigmaepsilon92@gmail.com>, liuyuan <liuyuan@google.com>, anton ivanov <anton.ivanov@cambridgegreys.com>

----- Ursprüngliche Mail -----
>> Can you please point out a little further why UML's net or block drivers
>> are not usable for LKL?
> 
> I think we can do it (but need to check).
> 
> LKL may use UML's drivers, and UML can also use LKL's devices/drivers
> (as my 36/37 and 37/37 patches do, though the patches has no careful
> consideration on IRQ handling).

Of course. So please don't get me wrong, I don't want LKL to become
UML. I hope that UML can also benefit from LKL.

Thanks,
//richard
