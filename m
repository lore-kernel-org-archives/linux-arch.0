From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: [RFC] change non-atomic bitops method
Date: Mon, 9 Feb 2015 16:18:10 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1044A02027E12@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
	<20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
	<20150203011730.GA15653@node.dhcp.inet.fi>
	<35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
	<20150202223851.f30768d0.akpm@linux-foundation.org>
	<35FD53F367049845BC99AC72306C23D1044A02027E0D@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0E@CNBJMBX05.corpusers.net>
 <20150203025925.d1c95fb8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cnbjrel01.sonyericsson.com ([219.141.167.165]:17902 "EHLO
	cnbjrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759539AbbBIISO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Feb 2015 03:18:14 -0500
In-Reply-To: <20150203025925.d1c95fb8.akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: "'Kirill A. Shutemov'" <kirill@shutemov.name>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org]
> Sent: Tuesday, February 03, 2015 6:59 PM
> To: Wang, Yalin
> Cc: 'Kirill A. Shutemov'; 'arnd@arndb.de'; 'linux-arch@vger.kernel.org';
> 'linux-kernel@vger.kernel.org'; 'linux@arm.linux.org.uk'; 'linux-arm-
> kernel@lists.infradead.org'
> Subject: Re: [RFC] change non-atomic bitops method
> 
> On Tue, 3 Feb 2015 16:42:14 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com>
> wrote:
> 
> > I make a change in kernel to test hit/miss ratio:
> 
> Neat, thanks.
> 
> >
> > ...
> >
> > After use the phone some time:
> > root@D5303:/ # cat /proc/meminfo
> > VmallocUsed:       10348 kB
> > VmallocChunk:      75632 kB
> > __set_bit_miss_count:10002 __set_bit_success_count:1096661
> > __clear_bit_miss_count:359484 __clear_bit_success_count:3674617
> > __test_and_set_bit_miss_count:7 __test_and_set_bit_success_count:221
> > __test_and_clear_bit_miss_count:924611
> __test_and_clear_bit_success_count:193
> >
> > __test_and_clear_bit_miss_count has a very high miss rate.
> > In fact, I think set/clear/test_and_set(clear)_bit atomic version can
> also
> > Be investigated to see its miss ratio,
> > I have not tested the atomic version,
> > Because it reside in different architectures.
> 
> Hopefully misses in test_and_X_bit are not a problem.  The CPU
> implementation would be pretty stupid to go and dirty the cacheline
> when it knows it didn't change anything.  But maybe I'm wrong about
> that.
> 
> That we're running clear_bit against a cleared bit 10% of the time is a
> bit alarming.  I wonder where that's coming from.
> 
> The enormous miss count in test_and_clear_bit() might indicate an
> inefficiency somewhere.
I te-test the patch on 3.10 kernel.
The result like this:

VmallocChunk:   251498164 kB
__set_bit_miss_count:11730 __set_bit_success_count:1036316
__clear_bit_miss_count:209640 __clear_bit_success_count:4806556
__test_and_set_bit_miss_count:0 __test_and_set_bit_success_count:121
__test_and_clear_bit_miss_count:0 __test_and_clear_bit_success_count:445

__clear_bit miss rate is a little high,
I check the log, and most miss coming from this code:

<6>[  442.701798] [<ffffffc00021d084>] warn_slowpath_fmt+0x4c/0x58
<6>[  442.701805] [<ffffffc0002461a8>] __clear_bit+0x98/0xa4
<6>[  442.701813] [<ffffffc0003126ac>] __alloc_fd+0xc8/0x124
<6>[  442.701821] [<ffffffc000312768>] get_unused_fd_flags+0x28/0x34
<6>[  442.701828] [<ffffffc0002f9370>] do_sys_open+0x10c/0x1c0
<6>[  442.701835] [<ffffffc0002f9458>] SyS_openat+0xc/0x18
In __clear_close_on_exec(fd, fdt);



<6>[  442.695354] [<ffffffc00021d084>] warn_slowpath_fmt+0x4c/0x58
<6>[  442.695359] [<ffffffc0002461a8>] __clear_bit+0x98/0xa4
<6>[  442.695367] [<ffffffc000312340>] dup_fd+0x1d4/0x280
<6>[  442.695375] [<ffffffc00021b07c>] copy_process.part.56+0x42c/0xe38
<6>[  442.695382] [<ffffffc00021bb9c>] do_fork+0xe0/0x360
<6>[  442.695389] [<ffffffc00021beb4>] SyS_clone+0x10/0x1c
In __clear_open_fd(open_files - i, new_fdt);

Do we need test_bit() before clear_bit()at these 2 place?

Thanks
