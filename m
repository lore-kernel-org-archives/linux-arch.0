From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 14/40] metag: Ptrace
Date: Fri, 9 Nov 2012 09:26:15 +0000
Message-ID: <509CCC37.3080801@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-15-git-send-email-james.hogan@imgtec.com> <CACM3HyFrzGXh0QMnw0OdxKu6PFzFacJma=0WH9LEYj3SCa=cJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56753 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab2KIJ1X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Nov 2012 04:27:23 -0500
In-Reply-To: <CACM3HyFrzGXh0QMnw0OdxKu6PFzFacJma=0WH9LEYj3SCa=cJA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: linux-arch@vger.kernel.org

On 08/11/12 07:17, Jonas Bonn wrote:
> On 31 October 2012 17:13, James Hogan <james.hogan@imgtec.com> wrote:
>> We use the non-generic interface at the moment (exposing the TBX context
>> structures to userland), pending conversion to the generic ptrace
>> interface.
>>
> 
> Hi James,
> 
> Comment 1, as you already mentioned in the blurb, is to use the
> generic ptrace interface... a lot of your ptrace functions aren't need
> anymore.
> Comment 2, is to avoid exporting the struct pt_regs to userspace.  GDB
> should be using regsets for accessing the current context for new
> architectures and doesn't need to know about the pt_regs layout
> anymore.  Not exporting pt_regs gains you the flexibility to optimize
> context saving in the future if you figure out a better (e.g. cache
> friendlier) way of saving your registers at exception time.

Thanks Jonas,

Yes, this is definitely something we want to do as our pt_regs layout is
rather convoluted and we'd like the flexibility to simplify it.

Cheers
James
