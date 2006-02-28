Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:12490 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751004AbWB1KGB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Feb 2006 05:06:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17412.8306.348507.178322@cargo.ozlabs.ibm.com>
Date: Tue, 28 Feb 2006 21:05:38 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Fwd: [PATCH] Add mm->task_size and fix powerpc vdso] 
In-Reply-To: <10152.1141118520@warthog.cambridge.redhat.com>
References: <1141115747.3767.53.camel@localhost.localdomain>
	<10152.1141118520@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

David Howells writes:

> Is it possible to end up with a 32-bit and a 64-bit process sharing an
> mm_struct? I assume not as I imagine this is set up by execve() which'll
> destroy any CLONE_VM sharing.

No... the only way to switch between 32-bit and 64-bit is via exec,
which creates a new mm.

Paul.
