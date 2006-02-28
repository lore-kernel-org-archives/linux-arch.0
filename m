Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:8609 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750819AbWB1JWP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Feb 2006 04:22:15 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1141115747.3767.53.camel@localhost.localdomain> 
References: <1141115747.3767.53.camel@localhost.localdomain> 
Subject: Re: [Fwd: [PATCH] Add mm->task_size and fix powerpc vdso] 
Date: Tue, 28 Feb 2006 09:22:00 +0000
Message-ID: <10152.1141118520@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Forgot this list on the CC ... Comments welcome, the idea is to finally
> track if an mm is 32 or 64 bits (knowing that I have an urgent need to
> get that fixed in 2.6.16 due to a problem with the powerpc vdso).

Is it possible to end up with a 32-bit and a 64-bit process sharing an
mm_struct? I assume not as I imagine this is set up by execve() which'll
destroy any CLONE_VM sharing.

David
