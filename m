From: Christoph Lameter <cl@linux.com>
Subject: Re: [gcv v3 27/35] arm: Replace __get_cpu_var uses
Date: Fri, 6 Sep 2013 15:39:17 +0000
Message-ID: <00000140f3ed6950-03760ead-5f78-414c-91e3-e3d40175cc92-000000@email.amazonses.com>
References: <00000140e97747d2-ee164a4d-d692-409a-a919-083eff3a41ca-000000@email.amazonses.com> <20130904174624.GB5599@mudshark.cambridge.arm.com> <00000140ea29d3c8-5110dd9f-9dcf-470f-9b7e-4e7ff0874052-000000@email.amazonses.com> <20130904182113.GD5599@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1309041324530.26497@gentwo.org> <00000140eac4f5fc-9f8c86db-05dd-496f-abf8-63ca3667574f-000000@email.amazonses.com> <20130905130359.GA22351@mudshark.cambridge.arm.com> <00000140ee828138-3328099b-149e-433d-8262-0a481806ca85-000000@email.amazonses.com>
 <20130905172810.GB29219@mudshark.cambridge.arm.com> <00000140ef40d3fc-55c44dfd-7403-43f4-b1fb-d116c55be5a6-000000@email.amazonses.com> <20130906110423.GE30450@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a9-97.smtp-out.amazonses.com ([54.240.9.97]:55744 "EHLO
	a9-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752749Ab3IFPpU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2013 11:45:20 -0400
In-Reply-To: <20130906110423.GE30450@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Tejun Heo <tj@kernel.org>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 6 Sep 2013, Will Deacon wrote:

> Ok, I had a crack at putting something together on top of HEAD, but I still
> see some errors due to pcpu array types (even with your patch in mainline).
> I think some of your conversions to __this_cpu_read should use this_cpu_ptr
> instead, but could you have a quick look at my fixup below please?

That could be the case since the cocci script does assume a read operation
is needed if there was no & in front of the __get_cpu_var. This is wrong
for pointers and arrays.

Patch looks fine to me.
