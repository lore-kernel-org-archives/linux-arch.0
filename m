Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11949 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934629AbbKSXeY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Nov 2015 18:34:24 -0500
Subject: Re: [RFC] Limiting linker scope
References: <564E5232.201@nod.at>
From: Richard Weinberger <richard@nod.at>
Message-ID: <564E5C7C.7090407@nod.at>
Date: Fri, 20 Nov 2015 00:34:20 +0100
MIME-Version: 1.0
In-Reply-To: <564E5232.201@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, octavian.purdila@intel.com
Message-ID: <20151119233420.BbzTGtwEzyLbpvRCWt6z2oH3ik5n3FUtJXip7h5orCU@z>

Am 19.11.2015 um 23:50 schrieb Richard Weinberger:
> Hi!
> 
> UML recently had an interesting bug[1] where the host side of UML
> tried to call sigsuspend() but as the kernel itself offers a function
> with the same name it called sigsuspend() on
> the UML kernel side and funny things happened.
> 
> The root cause of the problem is that the UML links userspace
> code like glibc, libpcap, etc. to the kernel image and symbols can
> clash. Especially if one side is a shared library it will not noticed
> at compile time.
> 
> As this is not the first bug of this kind I'm facing on UML I've
> started to think how to deal with that.
> 
> Is it somehow possible to limit the linker scope?
> Such that we can force LD no not blindly link every symbols of
> vmlinux into another object? Maybe using a white list?
> I have do admit I've never used LD scripts nor GNU export maps,
> maybe they can help. Currently I'm reading their docs and hope
> to find a way to implement my idea.
> 
> The problem is also not specific to UML, the emerging Linux Kernel
> Library will suffer from the same issue.

I take this back. LKL continues to impress me.
It creates a new kernel object using objcopy -G and marks only some
symbols as global. This approach could work for UML too.

Thanks,
//richard
