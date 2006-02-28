Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48344 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932135AbWB1Jcx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Feb 2006 04:32:53 -0500
Subject: Re: [Fwd: [PATCH] Add mm->task_size and fix powerpc vdso]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <10152.1141118520@warthog.cambridge.redhat.com>
References: <1141115747.3767.53.camel@localhost.localdomain>
	 <10152.1141118520@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 20:32:45 +1100
Message-Id: <1141119165.3767.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-02-28 at 09:22 +0000, David Howells wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Forgot this list on the CC ... Comments welcome, the idea is to finally
> > track if an mm is 32 or 64 bits (knowing that I have an urgent need to
> > get that fixed in 2.6.16 due to a problem with the powerpc vdso).
> 
> Is it possible to end up with a 32-bit and a 64-bit process sharing an
> mm_struct? I assume not as I imagine this is set up by execve() which'll
> destroy any CLONE_VM sharing.

Well, if it's possible, I don't see how it would be possible for those
to have a vDSO at all ... But I don't think it's possible with any
current code path.

Ben.


